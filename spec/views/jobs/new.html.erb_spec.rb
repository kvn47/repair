require 'spec_helper'

describe "jobs/new.html.erb" do
  before(:each) do
    assign(:job, stub_model(Job,
      :device_id => 1,
      :status => false,
      :comment => "MyText",
      :price => "9.99",
      :master_id => 1,
      :customer_fio => "MyString",
      :guarantee => false
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_device_id", :name => "job[device_id]"
      assert_select "input#job_status", :name => "job[status]"
      assert_select "textarea#job_comment", :name => "job[comment]"
      assert_select "input#job_price", :name => "job[price]"
      assert_select "input#job_master_id", :name => "job[master_id]"
      assert_select "input#job_customer_fio", :name => "job[customer_fio]"
      assert_select "input#job_guarantee", :name => "job[guarantee]"
    end
  end
end
