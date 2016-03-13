class CallsController < ApplicationController
  before_action :set_call, only: [:show, :destroy]

  # GET /calls
  def index
    @calls = Call.order(id: :desc).includes(:voicemail).includes(:company_number).includes(:user_number)
  end

  # GET /calls/1
  def show
  end

  # DELETE /calls/1
  def destroy
    @call.destroy
    redirect_to calls_url, notice: 'Call was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_call
    @call = Call.find(params[:id])
  end
end
