class RulesController < ApplicationController
  def index
    @rule = policy_scope(Rule)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
