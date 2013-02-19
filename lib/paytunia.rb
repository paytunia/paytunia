Dir[File.dirname(__FILE__) + '/paytunia/api/**.rb'].each do |file|
  require file
end

require 'paytunia/connection'
