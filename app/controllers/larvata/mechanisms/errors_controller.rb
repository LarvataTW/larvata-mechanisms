class Larvata::Mechanisms::ErrorsController < ApplicationController
  layout "larvata/mechanisms/errors"

  before_action :handle_exception
  before_action :log_exception_messages

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end

  private

  def handle_exception
    @exception = request.env["action_dispatch.exception"]
    @exception_wrapper = ActionDispatch::ExceptionWrapper.new(request.env['action_dispatch.backtrace_cleaner'], @exception)
    @trace = @exception_wrapper.application_trace
  end

  def log_exception_messages
    logger.error "exception：#{@exception}，paramters：#{request.params}，application trace：#{@trace.join('；')}"
  end
end
