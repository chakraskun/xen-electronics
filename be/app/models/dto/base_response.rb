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

    def self.created(message:'Created', data: nil)
      result = {
        status: 'CREATED',
        code: 201,
        message: message
      }
      result[:data] = data if data.present?
      result
    end

    def self.unprocessable_entity(message: 'Unprocessable Entity')
      {
        status: 'UNPROCESSABLE_ENTITY',
        code: 422,
        message: message
      }
    end

    def self.bad_request(message: 'Bad Request')
      {
        status: 'BAD_REQUEST',
        code: 400,
        message: message
      }
    end

    def self.internal_server_error(message: 'Internal Server Error')
      {
        status: 'INTERNAL_SERVER_ERROR',
        code: 500,
        message: message
      }
    end

    def self.deleted(message:'deleted', data: nil, meta: nil)
      result = {
        status: 'OK',
        code: 200,
        message: message
      }
      result
    end
  end
end
