require 'slim'
require 'better_errors'
require_relative "./lib/build_cleaner"

# ---- Global configuration ---- #

Time.zone = "Paris"

# ----- Paths ----- #

set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :fonts_dir, 'assets/fonts'

# ---- Blog ---- #

activate :blog do |blog|
  blog.prefix = "blog"
  blog.permalink = "{year}-{month}-{day}-{title}.html"
  blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.taglink = "categories/{tag}.html"
  blog.summary_length = 500
  blog.default_extension = ".md"
  blog.layout = "article_layout"
end

# ----- RSS Feed ----- #
page "/feed.xml", layout: false

# ----- Slim ------#
Slim::Engine.set_options :pretty => true

# ----- Pretty Urls ----- #

activate :directory_indexes

# ----- Google Analytics ---- #

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-31671208-1'
end

# ----- Disqus ---- #

activate :disqus do |d|
  d.shortname = 'benjamindigeon'
end

# ----- Code Syntax ---- #

activate :syntax
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# ----- Deployment ----- #

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.remote   = 'origin'
  deploy.branch   = 'master'
  deploy.strategy = :force_push
  deploy.build_before = true
end

# ----- Disable Rack::ShowExceptions middleware ----- #
set :show_exceptions, false

# ----- Configurations ----- #

# Development-specific configurations
configure :development do
  activate :livereload # Reload the browser automatically whenever files change
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# Build-specific configurations
configure :build do
  # For solving Middleman 4 build issues
  activate :build_cleaner

  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Compress
  activate :gzip
end
