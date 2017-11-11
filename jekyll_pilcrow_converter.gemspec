Gem::Specification.new do |s|
  s.name = 'jekyll_pilcrow_converter'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.summary = 'Add pilcrow links to paragraphs'
  s.description = <<-HEREDOC
    This gem is a Jekyll plugin that adds an anchor link to the
    beginning of paragraphs in a rendered site.
  HEREDOC
  s.authors = ['Jonathan Hooper']
  s.email = 'jon@jonathanhooper.net'
  s.files = Dir.glob('lib/**/*') + ['LICENSE', 'README.md']
  s.homepage = 'https://github.com/jmhooper/jekyll_pilcrow_converter'
  s.metadata = {
    'source_code_uri' => 'https://github.com/jmhooper/jekyll_pilcrow_converter'
  }
  s.add_runtime_dependency 'jekyll'
  s.add_runtime_dependency 'kramdown'
end
