# frozen_string_literal: true

class Views::Base < Components::Base
  # The ApplicationView is an abstract class for all your views.
  attr_accessor :params, :after_script, :component_classes

  def initialize(params: {}, **attrs)
    @params = params
    @component_classes = []
    super(**attrs)
  end

  def after_script
    @after_script ||= []
  end

  def layout = Components::Layouts::Application

  def around_template
    render layout.new do # pass title, etc
      super
    end
  end

  def after_template
    script do
      safe after_scripts
    end
  end

  def after_scripts
    component_classes.map { |component_class| component_class.script_template }.compact.join("\n")
  end

  # def page_info
  #   PageInfo.new(
  #     title: page_title
  #   )
  # end

  # def page_title
  #   "Default Title"
  # end
  # By default, it inherits from `ApplicationComponent`, but you
  # can change that to `Phlex::HTML` if you want to keep views and
  # components independent.
end
