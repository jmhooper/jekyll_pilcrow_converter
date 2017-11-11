# ¶

This is a converter for Jekyll sites that adds a pilcrow anchor link to the beginning of paragraphs.

With this converter, this markdown

```markdown

This is a paragraph!

```

...generates this HTML...

```html
<p id='123abc'>
  <a href='#123abc' class='pilcrow'>¶ </a>
  This is a paragraph!
</p>
```

To add this to your Jekyll site, just add this to your Gemfile and you're set:

```ruby
group :jekyll_plugins do
  gem 'jekyll_pilcrow_converter'
end
```

You can build the example site in this repo to see the converter in action.
