textcommand :url do |svn|
  svn.attr('URL')
end

textcommand :revision do |svn|
  svn.attr('Revision')
end

textcommand :path do |svn|
  svn.attr('URL').sub(attr('Repository Root'), '')
end

textcommand :root do |svn|
  svn.attr('Repository Root')
end

subcommand :'--version' do |svn|
  puts 'Subcheat ' + Subcheat.version
  'svn --version'
end