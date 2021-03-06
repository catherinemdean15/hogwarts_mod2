require 'rails_helper'

RSpec.describe 'Students index page' do
  before :each do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagrid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
    @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
    @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

    ProfessorStudent.create(student_id: @harry.id, professor_id: @snape.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @hagrid.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @hagrid.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @longbottom.id, professor_id: @snape.id)

  end

  it "displays each student in the system with number of professors" do
    visit '/students'

    expect(page).to have_content(@harry.name)
    expect(page).to have_content(@harry.professors.count)
    expect(page).to have_content(@malfoy.name)
    expect(page).to have_content(@malfoy.professors.count)
    expect(page).to have_content(@longbottom.name)
    expect(page).to have_content(@longbottom.professors.count)
  end

  it "displays students alphabetically" do
    visit "/students"

      expect(page.all('#name')[0]).to have_content("Draco Malfoy")
      expect(page.all('#name')[1]).to have_content("Harry Potter")
      expect(page.all('#name')[2]).to have_content("Neville Longbottom")
  end
end
