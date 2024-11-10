# frozen_string_literal: true

class Components::Base < Phlex::HTML
  include Components

  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::ContentFor

  attr_reader :attrs, :variant

  def initialize(**user_attrs)
    @attrs = mix(default_attrs, user_attrs)
    @variant = attrs[:variant]
    set_props
  end

  def after_template
    if parent_view &&self.is_a?(Components::Base) && !self.is_a?(Views::Base)
      parent_view.component_classes << self.class unless parent_view.component_classes.include?(self.class)
    end
    nil
  end

  def parent_view
    @parent_view ||= find_parent_view_container(self)
  end

  def find_parent_view_container(parent)
    return if parent.nil?
    parent.is_a?(Views::Base) ? parent : find_parent_view_container(parent.instance_variable_get(:@_parent))
  end

  def set_props
    new_props = self.class.props_definition
    attrs.each do |key, value|
      if self.class.props_definition.key?(key)
        new_props[key] = value
        @attrs.delete(key)
      end
    end
    @props = OpenStruct.new(new_props)
  end

  def props
    @props
  end

  def generate_id(prefix = nil)
    prefix = "#{prefix}-" if prefix
    "#{prefix}#{SecureRandom.uuid}"
  end

  def generate_fn_name(prefix = nil)
    "#{prefix}#{SecureRandom.uuid}".camelize
  end

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  private
    def default_attrs
      {}
    end


  class << self
    def script_template
      nil
    end

    def props(**properties)
      @props_definition = properties
    end

    def props_definition
      @props_definition || {}
    end
  end
end
