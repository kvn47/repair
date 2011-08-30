require 'spec_helper'

describe "devices/edit.html.erb" do
  before(:each) do
    @device = assign(:device, stub_model(Device,
      :model_id => 1,
      :serial => "MyString"
    ))
  end

  it "renders the edit device form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => devices_path(@device), :method => "post" do
      assert_select "input#device_model_id", :name => "device[model_id]"
      assert_select "input#device_serial", :name => "device[serial]"
    end
  end
end
