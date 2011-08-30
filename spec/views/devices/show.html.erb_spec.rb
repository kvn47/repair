require 'spec_helper'

describe "devices/show.html.erb" do
  before(:each) do
    @device = assign(:device, stub_model(Device,
      :model_id => 1,
      :serial => "Serial"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Serial/)
  end
end
