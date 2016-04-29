require 'savon'
require 'erb'

class Deltek::Client
  attr_accessor :savon, :username, :password, :database_name, :integrated_security
  TEMPLATES_PATH = File.join(File.dirname(__FILE__), '/templates')

  def initialize wsdl_url, username, password, database_name
    self.username = username
    self.password = password
    self.database_name = database_name
    self.integrated_security = true

    self.savon = Savon.client do
      digest_auth(username, password)
      wsdl(wsdl_url)
    end
  end

  def projects limit, offset
    savon.call(
      :get_projects_by_query, xml: projects_xml(limit, offset)
    ).body[:get_projects_by_query_response][:get_projects_by_query_result]
  end

  def project code
    savon.call(
      :get_projects_by_query, xml: project_xml(code)
    ).body[:get_projects_by_query_response][:get_projects_by_query_result]
  end

  def employees limit, offset
    savon.call(
      :get_employees_by_query, xml: employees_xml(limit, offset)
    ).body[:get_employees_by_query_response][:get_employees_by_query_result]
  end
  def employee first_name, last_name
    savon.call(
      :get_employees_by_query, xml: employee_xml(first_name, last_name)
    ).body[:get_employees_by_query_response][:get_employees_by_query_result]
  end

  def employee id
    savon.call(
      :get_employees_by_query, xml: employee_xml(id)
    ).body[:get_employees_by_query_response][:get_employees_by_query_result]
  end

  def clients limit, offset
    savon.call(
      :get_clients_by_query, xml: clients_xml(limit, offset)
    ).body[:get_clients_by_query_response][:get_clients_by_query_result]
  end
  def client_by_name name
    savon.call(
      :get_clients_by_query, xml: client_by_name_xml(name)
    ).body[:get_clients_by_query_response][:get_clients_by_query_result]
  end

  def client_by_id id
    savon.call(
      :get_clients_by_query, xml: client_by_id_xml(id)
    ).body[:get_clients_by_query_response][:get_clients_by_query_result]
  end

  PROJECT_XML_TEMPLATE = File.read(File.join(TEMPLATES_PATH, 'get_projects_by_query.xml.erb'))
  def projects_xml limit, offset
    _record_detail = "Primary"

    _query = %Q{
      SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (ORDER BY wbs1) as row FROM PR
      ) PR WHERE row > #{offset} AND row <= #{limit + offset}
    }
    ERB.new(PROJECT_XML_TEMPLATE).result(binding)
  end

  def project_xml code
    _query = %Q(SELECT PR.* FROM PR Where PR.WBS1 = '#{code}')
    ERB.new(PROJECT_XML_TEMPLATE).result(binding)
  end

  EMPLOYEE_XML_TEMPLATE = File.read(File.join(TEMPLATES_PATH, 'get_employees_by_query.xml.erb'))
  def employees_xml limit, offset
    _record_detail = "Primary"

    _query = %Q{
      SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (ORDER BY LastName) as row FROM EM
      ) EM WHERE row > #{offset} AND row <= #{limit + offset}
    }
    ERB.new(EMPLOYEE_XML_TEMPLATE).result(binding)
  end
  def employee_xml first_name, last_name
    _query = %Q(SELECT EM.* FROM EM Where EM.FirstName = '#{first_name}' AND EM.LastName = '#{last_name}')
    ERB.new(EMPLOYEE_XML_TEMPLATE).result(binding)
  end
  def employee_xml id
    _query = %Q(SELECT EM.* FROM EM Where EM.employee = '#{id}')
    ERB.new(EMPLOYEE_XML_TEMPLATE).result(binding)
  end

  CLIENT_XML_TEMPLATE = File.read(File.join(TEMPLATES_PATH, 'get_clients_by_query.xml.erb'))
  def clients_xml limit, offset
    _record_detail = "Primary"

    _query = %Q{
      SELECT * FROM (
        SELECT *, ROW_NUMBER() OVER (ORDER BY name) as row FROM CL
      ) CL WHERE row > #{offset} AND row <= #{limit + offset}
    }
    ERB.new(CLIENT_XML_TEMPLATE).result(binding)
  end
  def client_by_name_xml name
    _query = %Q(SELECT CL.* FROM CL Where CL.Name LIKE '%#{name}%')
    ERB.new(CLIENT_XML_TEMPLATE).result(binding)
  end
  def client_by_id_xml id
    _query = %Q(SELECT CL.* FROM CL Where CL.clientid = '#{id}')
    ERB.new(CLIENT_XML_TEMPLATE).result(binding)
  end
end
