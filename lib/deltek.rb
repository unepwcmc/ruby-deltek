require 'deltek/client'
require 'deltek/extractor'

module Deltek
  def self.config wsdl, username, password, database_name
    @client = Deltek::Client.new(wsdl, username, password, database_name)
  end

  def self.projects limit=10, offset=0, raw=false
    Deltek::Extractor.projects(@client.projects(limit, offset), raw)
  end

  def self.project code, raw=false
    Deltek::Extractor.project(@client.project(code), raw)
  end

  def self.employees limit=10, offset=0, raw=false
    Deltek::Extractor.employees(@client.employees(limit, offset), raw)
  end

  def self.employee first_name, last_name, raw=false
    Deltek::Extractor.employee(@client.employee(first_name, last_name), raw)
  end

  def self.employee id, raw=false
    Deltek::Extractor.employee(@client.employee(id), raw)
  end

  def self.clients limit=10, offset=0, raw=false
    Deltek::Extractor.clients(@client.clients(limit, offset), raw)
  end

  def self.client_by_name name, raw=false
    Deltek::Extractor.client(@client.client_by_name(name), raw)
  end

  def self.client_by_id id, raw=false
    Deltek::Extractor.client(@client.client_by_id(id), raw)
  end
end
