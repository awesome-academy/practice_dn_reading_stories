class CategoriesController < ApplicationController
    def show
        @category = Category.find_by(id: params[:id])
        if @category
            @stories = @category.stories.order_by_created_at.paginate(page: params[:page])
        else
            flash[:danger] = "Can't find this category name!!" 
            redirect_to root_path
        end
    end
    
end
