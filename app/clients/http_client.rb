
class HttpClient
  def initialize(base_url:, timeout: 10, open_timeout: 2)
    @conn = Faraday.new(url: base_url) do |f|
      f.request :json
      f.response :json, parser_options: { symbolize_names: true }
      f.options.timeout = timeout
      f.options.open_timeout = open_timeout
    end
  end

  def get(path, params = {})
    request { @conn.get(path, params) }
  end

  def post(path, body = {})
    request { @conn.post(path, body) }
  end

  private

  def request
    start_time = Time.now
    response = yield
    Rails.logger.info("Request took #{(Time.now - start_time)}s with status #{response.status}")

    {
      success: response.success?,
      status: response.status,
      data: response.body,
      error: nil
    }
  rescue Faraday::TimeoutError => e
    failure("timeout", e.message)
  rescue Faraday::ConnectionFailed => e
    failure("connection_failed", e.message)
  rescue Faraday::Error => e
    failure("http_error", e.message, e.response&.dig(:status))
  rescue StandardError => e
      Rails.logger.error(
        event: "http_client_unexpected_error",
        error: e.message
      )

    failure("unexpected_error", "An unexpected error occurred")
  end

  def failure(type, message, status = nil)
    {
      success: false,
      status: status,
      data: nil,
      error: {
        type: type,
        message: message
      }
    }
  end
end
