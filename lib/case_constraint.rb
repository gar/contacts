class CaseConstraint
  def matches?(request)
    request.query_parameters.has_key?(:case_id)
  end
end
