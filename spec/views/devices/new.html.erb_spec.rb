require 'spec_helper'

describe "devices/new.html.erb" do
  before(:each) do
    assign(:device, stub_model(Device,
      :model_id => 1,
      :serial => "MyString"
    ).as_new_record)
  end

  it "renders new device form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => devices_path, :method => "post" do
      assert_select "input#device_model_id", :name => "device[model_id]"
      assert_select "input#device_serial", :name => "device[serial]"
    end
  end
end
