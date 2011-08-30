require 'spec_helper'

describe "devices/index.html.erb" do
  before(:each) do
    assign(:devices, [
      stub_model(Device,
        :model_id => 1,
        :serial => "Serial"
      ),
      stub_model(Device,
        :model_id => 1,
        :serial => "Serial"
      )
    ])
  end

  it "renders a list of devices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Serial".to_s, :count => 2
  end
end
