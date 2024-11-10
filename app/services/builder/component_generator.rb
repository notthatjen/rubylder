module Builder
  class ComponentGenerator
    def self.generate(name:, type:, properties:)
      # Generate the default component
      create_default_component(name, properties)

      # Generate the example component
      create_example_component(name, properties)

      true
    rescue => e
      Rails.logger.error("Component generation failed: #{e.message}")
      false
    end

    private

    def self.create_default_component(name, properties)
      template = <<~RUBY
        # frozen_string_literal: true

        class Components::Default::#{name} < Components::Base
          props #{properties}

          def view_template(&)
            # Component implementation
          end
        end
      RUBY

      File.write(Rails.root.join("app/components/default/#{name.underscore}.rb"), template)
    end

    def self.create_example_component(name, properties)
      template = <<~RUBY
        # frozen_string_literal: true

        class Components::Example::#{name} < Components::Base
          def view_template
            # Example implementation
          end
        end
      RUBY

      File.write(Rails.root.join("app/components/example/#{name.underscore}.rb"), template)
    end
  end
end
