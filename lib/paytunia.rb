require "httparty"
Dir[File.dirname(__FILE__) + '/paytunia/*.rb'].each do |file|
  require file
end