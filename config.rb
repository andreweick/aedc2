Time.zone = "UTC"

page "/feed.xml", :layout => false

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :directory_indexes

configure :build do
  # activate :minify_css
  # activate :minify_javascript
  activate :cache_buster
  # activate :relative_assets
  require "middleman-smusher"
  activate :smusher
end


# Support for the old Liquid tags
require "lib/liquid_vimeo"
require "lib/liquid_photo"
require "lib/liquid_photo2"


# Ruby helpers to do the same thing
require "lib/post_helpers"
helpers PostHelpers


# Multiple Blogs
activate :blog do |blog|
  blog.name              = "Eick Family"
  blog.layout            = "post"
  blog.prefix            = "blog"
  blog.permalink         = ":year-:month-:day-:title.html"
  blog.tag_template      = "tag.html"
  blog.taglink           = "tags/:tag.html"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length    = 250
  # blog.per_page          = 5
  # blog.page_link         = "page/:num"
end

activate :blog do |blog|
  blog.name              = "Blog 2"
  blog.layout            = "post"
  blog.prefix            = "blog2"
  blog.tag_template      = "tag.html"
end

activate :blog do |blog|
  blog.name              = "Blog 3"
  blog.layout            = "post"
  blog.prefix            = "blog3"
  blog.tag_template      = "tag.html"
end
