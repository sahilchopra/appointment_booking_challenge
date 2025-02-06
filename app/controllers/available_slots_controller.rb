class AvailableSlotsController < ApplicationController
  def index
    unless valid_request?(params)
      render json: { error: "Invalid request parameters" }, status: 422 and return
    end

    available_slots = AvailabilityService::Find.new(
      date: params[:date],
      products: params[:products],
      language: params[:language],
      rating: params[:rating]
    ).call

    render json: available_slots
  end

  private

  def valid_request?(params)
    params[:date].present? &&
      params[:products].is_a?(Array) && params[:products].all? { |p| SalesManager::VALID_PRODUCTS.include?(p) } &&
      SalesManager::VALID_LANGUAGES.include?(params[:language]) &&
      SalesManager::VALID_CUSTOMER_RATINGS.include?(params[:rating])
  end
end
