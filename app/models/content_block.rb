class ContentBlock < ActiveRecord::Base
  # The keys in this registry are "public" names for collaborator
  # objects, and the values are reserved names of ContentBlock
  # instances, which Hyrax uses as identifiers. Values also correspond
  # to names of messages that can be sent to the ContentBlock class to
  # return defined ContentBlock instances.
  NAME_REGISTRY = {
    marketing: :marketing_text,
    researcher: :featured_researcher,
    announcement: :announcement_text,
    about: :about_page,
    help: :help_page,
    terms: :terms_page,
    agreement: :agreement_page,
    cite: :cite_page,
    schemes_of_work: :schemes_of_work_page,
    all_collections: :all_collections_page,
    cookie_statements: :cookie_statements_page,
  }.freeze

  # NOTE: method defined outside the metaclass wrapper below because
  # `for` is a reserved word in Ruby.
  def self.for(key)
    key = key.respond_to?(:to_sym) ? key.to_sym : key
    raise ArgumentError, "#{key} is not a ContentBlock name" unless whitelisted?(key)
    ContentBlock.public_send(NAME_REGISTRY[key])
  end

  class << self
    def whitelisted?(key)
      NAME_REGISTRY.include?(key)
    end

    def marketing_text
      find_or_create_by(name: 'marketing_text')
    end

    def marketing_text=(value)
      marketing_text.update(value: value)
    end

    def announcement_text
      find_or_create_by(name: 'announcement_text')
    end

    def announcement_text=(value)
      announcement_text.update(value: value)
    end

    def featured_researcher
      find_or_create_by(name: 'featured_researcher')
    end

    def featured_researcher=(value)
      featured_researcher.update(value: value)
    end

    def about_page
      find_or_create_by(name: 'about_page')
    end

    def about_page=(value)
      about_page.update(value: value)
    end

    def agreement_page
      find_by(name: 'agreement_page') ||
        create(name: 'agreement_page', value: default_agreement_text)
    end

    def agreement_page=(value)
      agreement_page.update(value: value)
    end

    def help_page
      find_by(name: 'help_page') ||
        create(name: 'help_page', value: default_help_text)
    end

    def help_page=(value)
      help_page.update(value: value)
    end

    def terms_page
      find_by(name: 'terms_page') ||
        create(name: 'terms_page', value: default_terms_text)
    end

    def terms_page=(value)
      terms_page.update(value: value)
    end

    def cite_page
      find_by(name: 'cite_page') ||
        create(name: 'cite_page', value: default_cite_text)
    end

    def cite_page=(value)
      cite_page.update(value: value)
    end

    def schemes_of_work_page
      find_by(name: 'schemes_of_work_page') ||
        create(name: 'schemes_of_work_page', value: default_schemes_of_work_text)
    end

    def schemes_of_work_page=(value)
      shemes_of_work_page.update(value: value)
    end

    def all_collections_page
      find_by(name: 'all_collections_page') ||
        create(name: 'all_collections_page', value: default_all_collections_text)
    end

    def all_collections_page=(value)
      all_collections_page.update(value: value)
    end

    def cookie_statements_page
      find_by(name: 'cookie_statements_page') ||
          create(name: 'cookie_statements_page', value: default_cookie_statements_text)
    end

    def cookie_statements_page=(value)
      cookie_statements_page.update(value: value)
    end

    def default_agreement_text
      ERB.new(
        IO.read(
          Hyrax::Engine.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'agreement.html.erb')
        )
      ).result
    end

    def default_terms_text
      ERB.new(
        IO.read(
          Hyrax::Engine.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'terms.html.erb')
        )
      ).result
    end

    def default_help_text
      ERB.new(
        IO.read(
          Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'help.html.erb')
        )
      ).result
    end

    def default_cite_text
      ERB.new(
        IO.read(
          Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'cite.html.erb')
        )
      ).result
    end

    def default_schemes_of_work_text
      ERB.new(
        IO.read(
          Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'schemes_of_work.html.erb')
        )
      ).result
    end

    def default_all_collections_text
      ERB.new(
        IO.read(
          Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'all_collections.html.erb')
        )
      ).result
    end

    def default_cookie_statements_text
      ERB.new(
          IO.read(
              Rails.root.join('app', 'views', 'hyrax', 'content_blocks', 'templates', 'cookie_statements.html.erb')
          )
      ).result
    end
  end
end
