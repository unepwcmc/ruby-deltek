# ruby-deltek
A wrapper around the Deltek SOAP API

## Installation

Add a line to your `Gemfile`:
```
  gem "deltek", github: "unepwcmc/ruby-deltek"
```

## Usage

The `ruby-deltek` wrapper has three main entry points: `clients`, `projects`,
and `employees`. To initialise the library, call `Deltek.config/4` (perhaps in an initializer):
```
Deltek.config(wsdl, username, password, database_name)
```

Now use the `Deltek` module to access the Deltek API:
```
## Projects

# Retrieve a project by its code
Deltek.project("00000.00.E")

# Retrieve the first 10 projects
Deltek.projects

# Retrieve 25 projects with no offset
Deltek.projects(25)

# Retrieve 25 projects offset by 50 (useful for pagination)
Deltek.projects(25, 50)

## Employees

# Retrieve an employee by first and last name
Deltek.employee("Alice", "Bob")

# Retrieve an employee by its id (usually found in projects details)
Deltek.employee("231")

# Retrieve paginated employees
Deltek.employees(25, 50)

## Clients

# Retrieve a client by name (implemented with %LIKE%)
Deltek.client_by_name("Grand Budapest")

# Retrieve a client by its id (usually found in projects details)
Deltek.client_by_id("231")

# Retrieve paginated clients
Deltek.clients(25, 50)
```
