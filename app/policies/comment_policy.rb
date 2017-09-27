class CommentPolicy < ApplicationPolicy

  def edit?
    user && user == record.author && created_less_15_min_ago?(record)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  private

  def created_less_15_min_ago?(record)
    TimeDifference.between(DateTime.now, record.created_at).in_minutes < 15
  end
end
