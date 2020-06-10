class Harakiri
  include Interactor

  def call
    Rails.logger.info "Self sacrificing so workers's memory can be released"

    Sidekiq::ProcessSet.new.each(&:stop!)
    # Wait some arbitrary amount of seconds to avoid Worker processing next job
    sleep 5

    Rails.logger.info 'Harakiri applied'
  end
end
