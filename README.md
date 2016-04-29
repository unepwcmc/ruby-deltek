# ruby-deltek
A wrapper around the Deltek SOAP API

## Installation

Add a line to your `Gemfile`:
```
  gem "deltek", github: "unepwcmc/ruby-deltek"
```

## Usage

The `ruby-deltek` wrapper has three main entry points: `clients`, `projects`,
and `employees`. To initialise the library, call `Deltek.new/4`:
```
deltek = Deltek.new(wsdl, username, password, database_name)
```

Once you have the `deltek` object, use it to execute calls to the Deltek API:
```
## Projects

# Retrieve a project by its code
deltek.project("00000.00.E")

# Retrieve the first 10 projects
deltek.projects

# Retrieve 25 projects with no offset
deltek.projects(25)

# Retrieve 25 projects offset by 50 (useful for pagination)
deltek.projects(25, 50)

## Employees

# Retrieve an employee by first and last name
deltek.employee("Alice", "Bob")

# Retrieve an employee by its id (usually found in projects details)
deltek.employee("231")

# Retrieve paginated employees
deltek.employees(25, 50)

## Clients

# Retrieve a client by name (implemented with %LIKE%)
deltek.client_by_name("Grand Budapest")

# Retrieve a client by its id (usually found in projects details)
deltek.client_by_id("231")

# Retrieve paginated clients
deltek.clients(25, 50)
```
