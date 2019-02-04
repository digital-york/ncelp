# Generated via
#  `rails generate hyrax:work Resource`
module Hyrax
  # Generated controller for Resource
  class ResourcesController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::Resource

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::ResourcePresenter
  end
end
