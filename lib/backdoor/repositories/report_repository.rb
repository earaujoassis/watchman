class ReportRepository < Hanami::Repository
  associations do
    belongs_to :server
  end

  def find(uuid)
    reports.where(uuid: uuid).first
  end

  def update_body(report, body_file)
    report = self.find(report.uuid)
    self.update(report.id, { body: Sequel.blob(body_file.read) })
  end

  def find_with_server(uuid)
    aggregate(:server).where(uuid: uuid).map_to(Report).one
  end
end
