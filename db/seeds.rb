# Clear existing data
puts "Clearing existing data..."
PowerBank.destroy_all
User.destroy_all
Station.destroy_all
Warehouse.destroy_all
Location.destroy_all

# Create admin user
admin = User.create!(
  email: 'admin@test.com',
  password: 'password',
  password_confirmation: 'password',
  role: 'admin'
)
puts "Admin created: #{admin.email}"

# Create regular user
user = User.create!(
  email: 'user@test.com',
  password: 'password',
  password_confirmation: 'password'
)
puts "User created: #{user.email}"

# Create warehouses and locations
warehouse1 = Warehouse.create!(name: 'Warehouse A')
warehouse2 = Warehouse.create!(name: 'Warehouse B')
puts "Warehouses created: #{warehouse1.name}, #{warehouse2.name}"

location1 = Location.create!(name: 'Location A')
location2 = Location.create!(name: 'Location B')
puts "Locations created: #{location1.name}, #{location2.name})"
# Create stations
station1 = Station.create!(name: 'Station 1', status: :online, warehouse: warehouse1, location: location1)
station2 = Station.create!(name: 'Station 2', status: :offline, warehouse: warehouse2, location: location2)
puts "Stations created: #{station1.name}, #{station2.name}"
# Create power banks
PowerBank.create!(serial_number: 'PB001', station: station1, user: user, warehouse: warehouse1)
PowerBank.create!(serial_number: 'PB002', station: station1, warehouse: warehouse1)
PowerBank.create!(serial_number: 'PB003', station: station1, warehouse: warehouse1)
PowerBank.create!(serial_number: 'PB004', station: station1, warehouse: warehouse1)
PowerBank.create!(serial_number: 'PB005', station: station1, warehouse: warehouse1)
PowerBank.create!(serial_number: 'PB006', station: station2, warehouse: warehouse2)
PowerBank.create!(serial_number: 'PB007', station: station2, warehouse: warehouse2)
PowerBank.create!(serial_number: 'PB008', station: station2, warehouse: warehouse2, user: user)
PowerBank.create!(serial_number: 'PB009', warehouse: warehouse2, user: user)
PowerBank.create!(serial_number: 'PB0010', warehouse: warehouse2)
PowerBank.create!(serial_number: 'PB0011', station: station1)
PowerBank.create!(serial_number: 'PB0012', station: station2)
puts "Power banks created"

