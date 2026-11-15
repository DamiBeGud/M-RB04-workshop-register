class WorkshopsController < ApplicationController
  before_action :authenticate
  def create
    row=Workshop.create!(code:Input.id(params[:code]),capacity:Input.amount(params[:capacity],100));render json:serialize(row),status: :created
  end
  def show = render(json:serialize(Workshop.find_by!(code:params[:code])))
  def register
    attendee=Input.id(params[:attendee]);row=Workshop.find_by!(code:params[:code])
    row.with_lock {Input.capacity!(row.capacity,row.registrations.where(active:true).count);row.registrations.create!(attendee_ref:attendee,active:true)}
    render json:serialize(row),status: :created
  end
  def cancel
    attendee=Input.id(params[:attendee]);row=Workshop.find_by!(code:params[:code])
    row.with_lock do
      registration=row.registrations.find_by!(attendee_ref:attendee)
      raise Problem.new(409,'already_cancelled') unless registration.active
      registration.update!(active:false)
    end
    render json:serialize(row)
  end
  private
  def serialize(row)
    used=row.registrations.where(active:true).count;{code:row.code,capacity:row.capacity,registered:used,available:row.capacity-used}
  end
end
