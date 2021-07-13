module UseCases
  # Base for all other UseCases to implement
  class Base
    attr_reader :result

    def initialize(*args)
      return if args.empty?

      arguments = args.reduce({}) { |p, c| p.merge(c) }
      method(__method__).parameters.each do |_t, name|
        instance_variable_set("@#{name}", arguments[name])
      end
      @errors = []
    end

    def error(message:, producer: nil)
      producer_name = producer.nil? ? 'Unknown' : producer.class.name

      @errors << { producer: producer_name, message: message }
    end

    def valid?
      @errors = []
      run_validations
      @errors.empty?
    end

    def load(data)
      data.deep_transform_keys { |k| k.underscore.to_sym }
    end

    def success?
      @errors.empty?
    end

    def prepare; end

    def run; end

    def execute
      return self unless valid?

      @errors = []
      @result = nil
      prepare
      @errors = []
      @result = run
      self
    end
  end
end
