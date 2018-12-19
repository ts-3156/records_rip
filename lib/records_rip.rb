require "active_support"
require "records_rip/version"
require "records_rip/model"
require "records_rip/tomb"

ActiveSupport.on_load(:active_record) do
  include(RecordsRip::Model)
end

module RecordsRip
  class Error < StandardError; end
  # Your code goes here...
end
