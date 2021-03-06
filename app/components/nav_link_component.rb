# frozen_string_literal: true

class NavLinkComponent < ApplicationComponent
  # @param label [String]
  # @param link [String, Object]
  # @param options [Hash]
  def initialize(label:, link:, **options)
    @label   = label
    @link    = link
    @options = options
  end

  # @return [Boolean]
  def current?
    current_page?(@link)
  end

  # @return [String]
  def nav_link_class
    html_class = []

    html_class << 'nav-link'
    html_class << 'active' if current?
    html_class << @options[:class] if @options[:class]

    html_class.join(' ')
  end

  # @return [Hash]
  def nav_link_options
    options = @options

    options = options.merge('aria-current' => 'page') if current?

    options
  end
end
