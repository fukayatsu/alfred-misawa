# coding: utf-8
require 'json'

def item_xml(options = {})
  <<-ITEM
  <item arg="#{options[:arg]}" uid="#{options[:uid]}">
    <title>#{options[:title]}</title>
    <subtitle>#{options[:subtitle]}</subtitle>
    <icon>#{options[:icon]}</icon>
  </item>
  ITEM
end

items = []
entries = JSON.parse(File.open('meigens.json', 'r:utf-8').read)
entries.each do |entry|
  body  = entry['body'] || entry['title'] || ''
  image = entry['image']

  next unless ARGV.first
  next unless body.match(ARGV.first.encode('UTF-8', 'UTF-8-MAC'))
  break if items.length > 20

  items << item_xml(
    arg:      image,
    uid:      image,
    icon:     image,
    title:    body.gsub("\n", ""),
    subtitle: 'Enter to copy url to clipboard. (Cmd + Enter to copy as markdown.)',
  )
end

puts "<?xml version='1.0'?><items>#{items.join}</items>"
