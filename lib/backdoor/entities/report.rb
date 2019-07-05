class Report < Hanami::Entity
  def serialize
    {
      id: self.uuid,
      subject: self.subject,
      updated_at: self.updated_at,
      body_available: !self.body.nil?
    }
  end
end
