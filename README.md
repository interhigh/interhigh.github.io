# interhigh.github.io

The homepage for Interhigh.

## Development Setup

### Cloning the repository

```bash
git@github.com:interhigh/interhigh.github.io.git
```

### Setting up the environment

First, make sure you have Ruby and RubyGems installed. You will also need NodeJS.

* [Ruby Installation](http://www.ruby-lang.org/en/downloads/)
* [RubyGems Installation](http://rubygems.org/pages/download)

Run the following commands:

```bash
cd interhigh.github.io
gem install bundler
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
