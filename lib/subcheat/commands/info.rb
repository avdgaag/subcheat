textcommand :url do
  attr('URL')
end

textcommand :revision do
  attr('Revision')
end

textcommand :path do
  attr('URL').sub(attr('Repository Root'), '')
end

textcommand :root do
  attr('Repository Root')
end

subcommand :'--version' do
  puts 'Subcheat ' + Subcheat.version
  'svn --version'
end