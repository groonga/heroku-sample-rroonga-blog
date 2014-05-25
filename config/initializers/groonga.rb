require 'fileutils'
require 'groonga'

database_path = ENV['GROONGA_DATABASE_PATH'] || 'groonga/database'
if File.exist?(database_path)
  Groonga::Database.open(database_path)
else
  Groonga::Database.create(path: database_path)
end
