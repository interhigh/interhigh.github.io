
=begin

How to mark content for translation:

Simply add the following translation tags into the Markdown document
to indicate that you want text to be translated:

[translate]: #start
Text that you want translated goes here.

[translate]: #end

Everything between the "[translate]: #start" and "[translate]: #end" tags
will be translated.
Note that the tags must be on their own separate lines with no extra text.
Also, there MUST be a line break before writing [translate]: #end, or else the
tag will appear in the test.

=end
class AutoTranslate
  # Translators
  BING = 'bing'

  # Language codes
  ENGLISH = 'en'
  KOREAN = 'ko'
  CHINESE_TRADITIONAL = 'zh-CHT'

  attr_accessor :translator
  attr_accessor :from
  attr_accessor :to


  def initialize(translator=BING, from=ENGLISH, to=KOREAN)
    @translator = translator
    @from = from
    @to = to
  end

  def translate(to_translate)
    if @translator == BING
      translate_bing(to_translate)
    else
      raise "'${@translator}' is not a supported translator!"
    end
  end

  def translate_bing(to_translate)
    translator = BingTranslator.new(@from, @to)
    translator.translate(to_translate)
  end

end

require 'json'
require 'uri'
require 'net/http'
class BingTranslator
  # Language codes
  # http://msdn.microsoft.com/en-us/library/hh456380.aspx
  ENGLISH = 'en'
  KOREAN = 'ko'

  # Initializes a translator that uses Bing.
  #
  # @param The language code to translate from
  # @param The language code to translate to
  def initialize(from, to)
    @from = from
    @to = to
    @access_token = fetch_access_token
  end

  # Translates a string.
  #
  # @param The string to translate
  def translate(to_translate)
    fetch_translation(to_translate, @from, @to, @access_token)
  end


  private

  # Gets the access token necessary for translation requests
  def fetch_access_token
    client_secret = '2qr3A7LUfZKGuPIgn8VNx6EmISm3Y4X0rGeXZJOxTvk='

    # See http://msdn.microsoft.com/en-us/library/hh454950.aspx
    # Also: https://datamarket.azure.com/developer/applications/edit/InterhighTranslations
    oauth_uri = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'

    post_data = {
      'client_id' => 'InterhighTranslations',
      'client_secret' => client_secret,
      'scope' => 'http://api.microsofttranslator.com',
      'grant_type' => 'client_credentials',
    }

    uri = URI(oauth_uri)
    response = Net::HTTP.post_form(uri, post_data)
    response = JSON.parse(response.body)
    return response['access_token']
  end

  # Sends the string to Bing for translation
  def fetch_translation(to_translate, from, to, access_token)
    # API documentation:
    # http://msdn.microsoft.com/en-us/library/ff512421.aspx
    translation_uri = 'http://api.microsofttranslator.com/V2/Http.svc/Translate'

    uri = URI.parse(translation_uri)
    params = {
      :appId => '',
      :text => to_translate,
      :from => from,
      :to => to,
      :contentType => 'text/plain',
    }
    uri.query = URI.encode_www_form(params)

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field('Authorization', "Bearer #{access_token}")
    res = Net::HTTP.new(uri.host, uri.port).start do |http|
      http.request(request)
    end

    result = res.body
    result = result.gsub(/<string xmlns=".*">/, "")
    result = result.gsub(/<\/string>/, "")
    result
  end

end


class FileTranslator

  def initialize(autotranslate)
    @autotranslate = autotranslate
  end

  # Sends the string to Bing for translation
  def translate_file(filename)
    f = File.read(filename)
    f = translate_title(f)
    f = translate_body(f)
    f = update_category(f)
    f
  end

  def translate_title(file)
    translated = ''
    title_translated = false
    file.each_line do |line|
      if not title_translated
        match_obj = /title:\s+"(.*)"/.match(line)
        if match_obj
          translated_title = @autotranslate.translate(match_obj[1])
          translated += "title: \"#{translated_title}\"\n"
          title_translated = true
          next
        end
      end
      translated += line
    end
    translated
  end

  def translate_body(file)
    translated = ''
    in_translate_block = false
    to_translate = ''
    file.each_line do |line|
      if line.start_with?('[translate]: #start')
        in_translate_block = true
        translated += line
        next
      elsif line.start_with?('[translate]: #end')
        in_translate_block = false
        translated += @autotranslate.translate(to_translate)
        translated += "\n\n"
        translated += line
        to_translate = ''
        next
      end

      if in_translate_block
        to_translate += line
      else
        translated += line
      end
    end
    translated
  end

  def update_category(file)
    from_language = @autotranslate.from
    to_language = @autotranslate.to

    updated = ''
    is_updated = false
    file.each_line do |line|
      if not is_updated
        match_obj = /categories:\s+\[['"]#{from_language}['"]\]/.match(line)
        if match_obj
          updated += "categories: ['#{to_language}']\n"
          is_updated = true
          next
        end
      end
      updated += line
    end
    updated
  end

end



class JekyllTranslator

  def initialize(project_root_path, from_languages, to_languages)
    @project_root_path = project_root_path
    @posts_path = project_root_path + "/_posts/"
    @from_languages = from_languages
    @to_languages = to_languages
  end

  def translate()

    @from_languages.each do |from|
      from_files = Dir.entries("#{@posts_path}/#{from}/").select { |file| file.end_with?(".markdown") }

      @to_languages.each do |to|
        to_files = Dir.entries("#{@posts_path}/#{to}/").select { |file| file.end_with?(".markdown") }
        new_files = from_files.select { |file| not to_files.include?(file) }

        at = AutoTranslate.new(AutoTranslate::BING, from, to)
        ft = FileTranslator.new(at)

        new_files.each do |new_file|
          puts "Translating \"#{new_file}\" from \"#{from}\" to \"#{to}\"..."
          translated = ft.translate_file("#{@posts_path}/#{from}/#{new_file}")
          File.write("#{@posts_path}/#{to}/#{new_file}", translated)
        end
      end
    end

  end

  def puts_welcome
    puts '==================================='
    puts '= [AutoTranslate] module loaded.'
    puts '==================================='
  end

  def puts_complete
    puts '==================================='
    puts '= [AutoTranslate] complete!'
    puts '==================================='
  end

end

project_root_path = File.dirname(__FILE__) + "/../"
from_languages = [AutoTranslate::ENGLISH]
to_languages = [AutoTranslate::KOREAN, AutoTranslate::CHINESE_TRADITIONAL]
jt = JekyllTranslator.new(project_root_path, from_languages, to_languages)
jt.puts_welcome
jt.translate()
begin
rescue
  puts "An error occurred while trying to translate the documents. Please sure you are connected to the internet."
end
jt.puts_complete
