class RecipesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @recipes = if params[:keywords]
                 Recipe.where('name ilike ? OR contributor ilike ?',"%#{params[:keywords]}%", "%#{params[:keywords]}%")
               else
                 Recipe.all
               end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(params.require(:recipe).permit(:name,:instructions,:contributor))
    @recipe.save
    render 'show', status: 201
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update_attributes(params.require(:recipe).permit(:name,:instructions,:contributor))
    head :no_content
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    head :no_content
  end
end