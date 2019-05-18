# Airport Management System :

This application is for managing an airport system using Api's secured by JWT, There are 2 roles in the app: passenger and user , passenger can view available flights and reserve tickets from selected flight and user can manage flights , airports , airports terminals , airlines , seats and tickets

## Setting up the environment :

- Ruby version is `2.4.1`
- Database is Postgresql
- Rails version is `5.1.7`

## Usage :
- Navigate to the project folder from the terminal
  - Run 'bundle install'
  - Create config/database.yml file to match your PostgreSQL server configurations
  - Run `bundle exec rake db:create` to create the database
  - Run `bundle exec rake db:schema:load` to load the current schema to your database
	- Run Rails local server using command `rails s`
  - From Api Rest client, create api calls using `http://localhost:3000` as a base url 
