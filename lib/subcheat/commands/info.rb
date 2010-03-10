Subcheat::Command.define('url', false) do
  attr('URL')
end

Subcheat::Command.define('revision', false) do
  attr('Revision')
end

Subcheat::Command.define('path', false) do
  attr('URL').sub(attr('Repository Root'), '')
end

Subcheat::Command.define('root', false) do
  attr('Repository Root')
end

Subcheat::Command.define('--version') do
  puts 'Subcheat ' + Subcheat.version
  'svn --version'
end