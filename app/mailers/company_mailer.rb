class CompanyMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: "<Bob The Importer> importingengine9000@craft.co"

  def imported(ids)
    @companies = Company.where(id: ids).order(:id)
    @csv = @companies.to_csv
    attachments["import_#{Time.now.strftime('%D %R')}.csv"] = {:mime_type => 'application/csv',
                                   :content => @csv }
    mail(to: 'mark@craft.co,ilya@craft.co', subject: 'The import has been finished')
  end
end
