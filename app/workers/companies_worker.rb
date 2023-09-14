class CompaniesWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)

    begin
      company.scrape_data!
    rescue => exception
      ExceptionNotifier.notify_exception(exception)
    end
  end
end
