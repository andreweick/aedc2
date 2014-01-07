Time.zone = "UTC"

page "/feed.xml", :layout => false

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

activate :directory_indexes

activate :clowncar

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
  blog.name              = "Family"
  blog.layout            = "post"
  # blog.page_link         = "page/:num"
  blog.paginate          = true
  blog.per_page          = 5
  blog.prefix            = "family"
  blog.permalink         = ":year-:month-:day-:title.html"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length    = 250
  #blog.tag_template      = "tag.html"
  blog.taglink           = "tags/:tag.html"
end

activate :blog do |blog|
  blog.name              = "Snapshot"
  blog.layout            = "post"
  blog.paginate          = true
  blog.per_page          = 5
  blog.permalink         = ":year-:month-:day-:title.html"
  blog.prefix            = "snapshot"
  #blog.tag_template      = "tag.html"
end

activate :blog do |blog|
  blog.name              = "History"
  blog.layout            = "post"
  blog.paginate          = true
  blog.per_page          = 5
  blog.permalink         = ":year-:month-:day-:title.html"
  blog.prefix            = "history"
  #blog.tag_template      = "tag.html"
end

activate :blog do |blog|
  blog.name              = "Soccer"
  blog.layout            = "post"
  blog.paginate          = true
  blog.per_page          = 5
  blog.permalink         = ":year-:month-:day-:title.html"
  blog.prefix            = "soccer"
  #blog.tag_template      = "tag.html"
end
