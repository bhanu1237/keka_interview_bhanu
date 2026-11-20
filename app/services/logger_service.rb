class LoggerService
  class << self
    def info(log)
      Rails.logger.info("[LoggerService] #{log}")
    end

    def debug(log)
      Rails.logger.debug("[LoggerService] #{log}")
    end

    def error(log)
      Rails.logger.error("[LoggerService] #{log}")
    end
  end
end
