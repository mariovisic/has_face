module HasFace
  module Test
    module Matchers

      class ValidateHasFaceFor

        def initialize(expected, options)
          @expected = expected
          @options  = options
        end

        def matches?(actual)
          @actual = actual

          @actual.class.validators.any? do |validator|
            validator.is_a?(HasFace::Validator) && \
              validator.attributes.include?(@expected) && \
              has_correct_allow_blank(validator) && \
              has_correct_allow_nil(validator)
          end

        end

        def failure_message
          "expected #{@actual.class.to_s} to validate has face for #{@expected.inspect} #{with_options_message}"
        end

        def negative_failure_message
          "expected #{@actual.class.to_s} not to validate has face for #{@expected.inspect} #{with_options_message}"
        end

        def has_correct_allow_blank(validator)
          return true if @options[:allow_blank].nil?
          validator.instance_variable_get('@allow_blank') == @options[:allow_blank]
        end

        def has_correct_allow_nil(validator)
          return true if @options[:allow_nil].nil?
          validator.instance_variable_get('@allow_nil') == @options[:allow_nil]
        end

        def with_options_message
          if @options.present?
            "with options #{@options.inspect}"
          end
        end

      end

      def validate_has_face_for(expected, options = {})
        ValidateHasFaceFor.new(expected, options)
      end

    end
  end
end
