require 'rails_helper'

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = User.create!(name: "Larry", email: "larry@example.com", password: "larrylarry", password_confirmation: "larrylarry")
    user2 = User.create!(name: "Moe",   email: "moe@example.com", password: "larrylarry", password_confirmation: "larrylarry")
    user3 = User.create!(name: "Curly", email: "curly@example.com", password: "larrylarry", password_confirmation: "larrylarry")

    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

end