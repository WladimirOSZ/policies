10.times do
  p = Policy.create(
    policy_id: Faker::Number.number(digits: 5),
    issue_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
    coverage_end_date: Faker::Date.between(from: Date.today, to: 2.years.from_now)
  )

  Insured.create(
    name: Faker::Name.name,
    cpf: Faker::IDNumber.brazilian_citizen_number(formatted: true),
    policy_id: p.id
  )

  Vehicle.create(
    brand: Faker::Vehicle.manufacture,
    license_plate: Faker::Vehicle.license_plate,
    year: Faker::Vehicle.year,
    model: Faker::Vehicle.make_and_model,
    policy_id: p.id
  )

end

p "Created 10 new policies, insureds and vehicles."