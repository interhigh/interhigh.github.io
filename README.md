# interhigh.github.io

The homepage for Interhigh.

## Development Setup

### Cloning the repository

```bash
git clone git@github.com:interhigh/interhigh.github.io.git
```

### Setting up the environment

First, make sure you have Ruby and RubyGems installed. You will also need NodeJS.

* [Ruby Installation](http://www.ruby-lang.org/en/downloads/)
* [RubyGems Installation](http://rubygems.org/pages/download)

Install Homebrew
```
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
```


Use Homebrew to install rbenv (the tool that will manage your ruby installations)
```
brew install rbenv
brew install ruby-build
brew install rbenv-gem-rehash
```

Setup rbenv in your PATH by adding the following to your ~/.bash_profile
```
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

Use rbenv to install Ruby
```
rbenv install 2.1.2
rbenv global 2.1.2
```

Install bundler
```
gem install bundler
```

Run the following commands:

```bash
cd interhigh.github.io
gem install jekyll
bundle install
```

If this doesn't work, try the more comprehensive tutorial here:
* [Jekyll Installation Guide](http://jekyllrb.com/docs/installation/)

### Running the server

In the interhigh.github.io folder, run this:

```bash
bundle exec jekyll serve
```

Then you can find the webpage running at ```http://127.0.0.1:4000/```.

## Resources

* [Jekyll Documentation](http://jekyllrb.com/docs/home/) - Explains how Jekyll works
* [Foundation Documentation](http://foundation.zurb.com/docs/index.html) - Our front-end styling framework
