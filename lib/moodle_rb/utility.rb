module MoodleRb
  module Utility
    def query_hash(function, token)
      {
        :wsfunction => function,
        :moodlewsrestformat => 'json',
        :wstoken => token
      }
    end

    # The Moodle API requires array arguments to be in this format
    def api_array(*array)
      {}.tap do |h|
        array.flatten.each_with_index do |x, i|
          h[i] = x
        end
      end
    end

    def key_value_query_format(hash)
      {}.tap do |h|
        hash.each_with_index do |key_value_array, i|
          h[i] = {}
          h[i][:key] = key_value_array[0]
          h[i][:value] = key_value_array[1]
        end
      end
    end

    def check_for_errors(response)
      return unless error_response?(response)
      raise MoodleError.new(response.parsed_response.presence || response.response.inspect)
    end

    private

    def error_response?(response)
      response && response.parsed_response.is_a?(Hash) &&
        response.parsed_response.has_key?('exception')
    end
  end
end
