Subcheat::Command.define('url') do
  attr('URL')
end

Subcheat::Command.define('revision') do
  attr('Revision')
end

Subcheat::Command.define('path') do
  attr('URL').sub(attr('Repository Root'), '')
end

Subcheat::Command.define('root') do
  attr('Repository Root')
end