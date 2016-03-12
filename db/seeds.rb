# Create users with their endpoints
jane = User.create!(name: 'Jane')
peter = User.create!(name: 'Peter')
luke = User.create!(name: 'Luke')

jane.user_numbers.create!(sip_endpoint: 'sip:janedesktop160311141639@phone.plivo.com')
jane.user_numbers.create!(sip_endpoint: 'sip:janemobile160311141606@phone.plivo.com')
peter.user_numbers.create!(sip_endpoint: 'sip:peterdesktop160311141706@phone.plivo.com')
luke.user_numbers.create!(sip_endpoint: 'sip:lukemobile160311141726@phone.plivo.com')

# Create company numbers
company_numbers = CompanyNumber.create!([
  { sip_endpoint: 'sip:mainoffice160311142018@phone.plivo.com' },
  { sip_endpoint: 'sip:salesnumber160311142036@phone.plivo.com' },
  { sip_endpoint: 'sip:supportnumber160311142058@phone.plivo.com' }
])

# Link users to company numbers
jane.company_numbers << company_numbers
peter.company_numbers << company_numbers.second
luke.company_numbers << company_numbers.last
