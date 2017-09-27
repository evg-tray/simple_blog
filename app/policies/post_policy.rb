class PostPolicy < ApplicationPolicy

  def show?
    record.public || user == record.author
  end

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
