require 'paytunia/connection'

Dir[File.dirname(__FILE__) + '/paytunia/api/**.rb'].each do |file|
  require file
   Paytunia::Connection.send :include, file.gsub(/\.rb$/, '').camelcase.constantize

end