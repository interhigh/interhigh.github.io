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

## Contributing

1. Create your feature branch (`git checkout -b my-new-feature`)
2. Commit your changes (`git commit -am 'Add some feature'`)
3. Push to the branch (`git push origin my-new-feature`)
4. Create new Pull Request

### Useful Git Commands

#### Pulling in updates from a different branch to your branch

`git pull origin master` When `master` branch has new changes, you'd want to make sure your branch incorporates those changes. This might give you conflicts that you'll need to resolve (e.g. if the file you're changing got changed on `master` branch). Git should tell you which files they are.

This is a good resource to learn how to resolve conflicts: https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line

## Resources

* [Jekyll Documentation](http://jekyllrb.com/docs/home/) - Explains how Jekyll works
* [Foundation Documentation](http://foundation.zurb.com/docs/index.html) - Our front-end styling framework


-------------------------
-------------------------

# IH Website Code Overview
This explains the overall structure of the IH website, and how to update the site as necessary.

### Architecture
 - The IH website is simply a static site (HTML/CSS/JS) running on top of Jekyll (a microblogging framework). Updating a page simply involves:
   - 1) Editing an HTML/CSS file to display what you want it to.
   - 2) Pushing the commit to the Git repository, hosted on Github.
 - The only non-static portion is the IH signup form (button on the front page used to request IH at your church). This is the only code that lives separately from the Git repository (more below).
 - When a new commit is made to the repo, it will automatically be pulled and deployed live to `interhigh.org`.
 - The site is hosted on our GP servers. If you have questions regarding our servers, Steven Leung may know more, as he helped to set these servers up.


### Project Directory Structure

###### Individual pages (HTML):
If you wanted to edit a particular page, simply update the corresponding HTML file, which can be found within its own subdirectory (with the exception of the homepage):
 - `/about` - The about page
 - `/contact` - The contact page
 - `/devotionals` - The DT page
 - `/media` - The Photos and Videos page
 - `/index.html` - The main homepage (not in a subdirectory)

###### CSS/SCSS Files:
To edit the styling of the page, update the relevant CSS file. Styling files can be found in several locations:
 - `/static/css` - This contains most of the CSS styles for each individual page. They are organized into their own respective folders.
  - `/css` - This contains a few global styles and some one-off stylesheets


###### Other static files
 - Other static resources (e.g. `.js` files, devotional DOC/PDF files, etc) can be found within `/static`.


###### Jekyll configuration file
 - This can be found at `/_config.yml`.
 - This configures general things related to the project, most notably the navigation bar entries. You would need to add a new entry here if you wanted to add another navbar item.


### Editing the IH signup form
 - The code for the IH signup form (button on the front page used to request IH at your church) is not found in the Git repository, but separately within Google Sheets. This code handles everything after the form is filled out and submitted to the server.
   - This code does the following:
     - 1) Updates a Google Sheets form with the submitted information
     - 2) Sends a notification email to a list of addresses (IH leads)
   - This code can be updated by signing into the Interhigh Google Account (ask Dave for the account details). Then:
     - 1) Go to `https://sheets.google.com`
     - 2) Edit the `Interhigh Website Responses` spreadsheet
     - 3) In the top menu, click Tools > Script Editor
     - 4) Edit the code as necessary. Here, you can add or remove email addresses to the contact list, update the notification email, or change the general behavior of a form submission.
     - 5) Once you save the code, you'll need to publish the latest version. Clicking `File > Manage versions` will show all of the revisions of the code.
     - 6) In the menu, click `Publish > Deploy as web app`. Update the project version to the new version that you just created with your changes.
     - 7) Click Update. That's it, the code should be deployed!


