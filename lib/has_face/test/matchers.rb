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
              validator.attributes.include?(@expected)
          end

        end

        def failure_message
          "expected #{@actual.inspect} to validate has face for #{@expected.inspect}"
        end

        def negative_failure_message
          "expected #{@actual.inspect} to validate has face for #{@expected.inspect}"
        end

      end

      def validate_has_face_for(expected, options = {})
        ValidateHasFaceFor.new(expected, options)
      end

    end
  end
end
