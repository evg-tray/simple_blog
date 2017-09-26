class PostPolicy < ApplicationPolicy

  def edit?
    user && user == record.author
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
