module Larvata::Mechanisms::Modals::CloseOpenedHelper
  def close_opened_modal
    "opened_modal.modal('hide')".html_safe
  end
end
