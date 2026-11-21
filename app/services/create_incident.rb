class CreateIncident
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    incident = Incident.build(@params)
    unless incident.valid?
      return {
        status_code: 422,
        error: incident.errors.full_messages.join(", ")
      }
    end
    notification_details
    begin
      incident.save!
      
    rescue ActiveRecord::RecordNotUnique

      {

      }
    
    end

  end

  private
  def notification_details
    case @params[:severity]
    when 'INFO'
      {
        notification_channel: nil
      }
    when 'WARNING'
      {
        status: 'TRIGGERED',
        callId: nil,
        error: "below threshold",
        notification_status: nil
      }
    when 'CRITICAL'
      schedule_a_call
    end
  end

  def schedule_a_call
    body: {
      "to": SERVICE_IDS[@params[:serviceId]],
      "message": "#{@params[:severity]}: #{@params[:title]} on #{@params[:serviceId]}"
    }
    res = HttpClient.new(base_url: MOCKURL).post('mock', body)
    if res[:success]
      {
        status: 'TRIGGERED',
        callId: nil,
        error: "below threshold",
        notification_status: nil
      }
  end

end