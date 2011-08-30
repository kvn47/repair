require 'spec_helper'

describe "models/show.html.erb" do
  before(:each) do
    @model = assign(:model, stub_model(Model,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
