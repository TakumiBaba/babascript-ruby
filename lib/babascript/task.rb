module Babascript
  class Task
    attr_reader :status
    attr_accessor :id
    attr_accessor :to

    def initialize(@to, @body, @params={})
      @id = @create_id
    end

    def start
      @status = :processing
    end

    def complete
      @status = :completed
    end

    def cancel
      @status = :canceled
    end

    private
    def create_id
      SecureRandom.uuid
    end
  end
end
