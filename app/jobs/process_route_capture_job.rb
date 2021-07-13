class ProcessRouteCaptureJob < ApplicationJob
  queue_as :default

  def perform(capture)
    return unless capture.may_process_start?

    uc = UseCases::ProcessRouteCapture.new(capture: capture)
    return unless uc.valid?

    capture.process_start!
    uc.execute
    capture.process_complete!
  end
end
