RSpec.describe User, type: :entity do
  it "can be initialized with attributes" do
    user = User.new(email: "johndoe@example.com", github_token: "2Y8Sj3kklJcJxxVO797wFpVGpIbuQmvc", category: "master")
    expect(user.email).to eq("johndoe@example.com")
    expect(user.github_token).to eq("2Y8Sj3kklJcJxxVO797wFpVGpIbuQmvc")
    expect(user.category).to eq("master")
  end
end
