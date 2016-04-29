require 'deltek/client'
require 'deltek/extractor'

class Deltek
  def initialize wsdl, username, password, database_name
    @client = Deltek::Client.new(wsdl, username, password, database_name)
  end

  def projects limit=10, offset=0
    Deltek::Extractor.projects(@client.projects(limit, offset))
  end

  def project code
    Deltek::Extractor.project(@client.project(code))
  end

  def employees limit=10, offset=0
    Deltek::Extractor.employees(@client.employees(limit, offset))
  end

  def employee first_name, last_name
    Deltek::Extractor.employee(@client.employee(first_name, last_name))
  end

  def employee id
    Deltek::Extractor.employee(@client.employee(id))
  end

  def clients limit=10, offset=0
    Deltek::Extractor.clients(@client.clients(limit, offset))
  end

  def client_by_name name
    Deltek::Extractor.client(@client.client_by_name(name))
  end

  def client_by_id id
    Deltek::Extractor.client(@client.client_by_id(id))
  end
end
