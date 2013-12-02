class Job < ActiveRecord::Base
  belongs_to :model
  belongs_to :master, class_name: 'User', foreign_key: 'master_id'
  attr_accessor :model_name
  validates :model_id, :master_id, :serial, presence: true
  scope :by_creation, order('created_at desc')
  scope :done, where(status: true)
  scope :undone, where(status: false)
  scope :by_master, lambda { |user| where(master_id: user.id) }

  def self.filter(params)
    date_from = (params[:filter_date_from].blank?) ? nil : params[:filter_date_from].to_datetime.beginning_of_day
    date_to = (params[:filter_date_to].blank?) ? nil : params[:filter_date_to].to_datetime.end_of_day
    status = (params[:filter_status].blank?) ? nil : params[:filter_status] == 'true'
    guarantee = (params[:filter_guarantee].blank?) ? nil : params[:filter_guarantee] == 'true'
    master = (params[:filter_master].blank?) ? nil : User.find(params[:filter_master])
    column = (params[:filter_text_column].blank?) ? nil : params[:filter_text_column]
    text = (params[:filter_text].blank?) ? nil : params[:filter_text]
    jobs = Job.scoped
    jobs = jobs.where(income_date: date_from..date_to) if date_from and date_to
    jobs = jobs.where(status: status) unless status.nil?
    jobs = jobs.where(guarantee: guarantee) unless guarantee.nil?
    jobs = jobs.where(master_id: master) unless master.nil?
    jobs = jobs.where("#{column} LIKE ?", "%#{text}%") if column and text
    jobs
  end

  def is_done?
    status
  end

  def is_undone?
    !status
  end

end
