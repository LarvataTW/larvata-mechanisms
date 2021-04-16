module Larvata::Mechanisms::Concerns::Models::Attachment
  extend ActiveSupport::Concern

  included do
    belongs_to :attachable, polymorphic: true, optional: true
  end
end