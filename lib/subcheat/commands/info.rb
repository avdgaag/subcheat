Subcheat::Command.define('url') do
  info[/URL: (.+)$/i, 1]
end

Subcheat::Command.define('revision') do
  info[/Revision: (\d+)/i, 1]
end

Subcheat::Command.define('path') do
  info[/URL: (.+)$/i, 1].sub(info[/Repository Root: (.+)$/i, 1], '')
end

Subcheat::Command.define('root') do
  info[/Repository Root: (.+)$/i, 1]
end