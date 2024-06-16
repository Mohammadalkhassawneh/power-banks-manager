# power-banks-manager
# Project Name

PowerBankManager

## Description

PowerBankManager is a Rails application designed to manage power banks across warehouses, stations, and users. It allows administrators to create and manage warehouses, stations, users, and assign power banks to different entities. Normal users can view lists of locations and stations, check available power banks in stations, and perform actions like taking and returning power banks

## Installation

### Prerequisites

- Ruby (version 3.3.1)
- Rails (7.1.3)
- PostgreSQL (for development and production environments)
- Git

### Steps

1. Clone the repository:

   git clone https://github.com/Mohammadalkhassawneh/power-banks-manager.git
   cd PowerBankManager

2. bundle install

3. rails db:create
4. rails db:migrate
5. rails db:seed
6. rails s

### Testing
Running Tests

To run tests using RSpec:
 bundle exec rspec

