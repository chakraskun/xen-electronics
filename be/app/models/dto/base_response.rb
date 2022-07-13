# frozen_string_literal: true

module Dto
  class BaseResponse < Base
    def self.ok(message:'Ok', data: nil, meta: nil)
      result = {
        status: 'OK',
        code: 200,
        message: message
      }
      if data.present? || data.is_a?(Array)
        result[:data] = data
      end
      result[:meta] = meta if meta.present?

      result
    end

    def self.bad_request(message: 'Bad Request')
      {
        status: 'BAD_REQUEST',
        code: 400,
        message: message
      }
    end
  end
end
