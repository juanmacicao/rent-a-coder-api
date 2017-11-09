class OfferSerializer < ActiveModel::Serializer
  attributes :cost, :estimated_time, :candidate

  def candidate
    CandidateSerializer.new(object.user)
  end
end
