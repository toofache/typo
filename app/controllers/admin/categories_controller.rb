class Admin::CategoriesController < Admin::BaseController
  cache_sweeper :blog_sweeper

  def index; redirect_to :action => 'new' ; end
#def edit; new_or_edit;  end

  def edit
    if request.post?
      create_or_save
    else
      new_or_edit
    end
  end

  def new 
    respond_to do |format|
      format.html { new_or_edit }
      format.js { 
        @category = Category.new
      }
    end
  end

  def destroy
    @record = Category.find(params[:id])
    return(render 'admin/shared/destroy') unless request.post?

    @record.destroy
    redirect_to :action => 'new'
  end

  private

  def new_or_edit
    @categories = Category.find(:all)
    if not params[:id].to_s.empty?
      @category = Category.find(params[:id])
    end
    render 'new'
  end

  def create_or_save
    if params[:id].to_s.empty?
      @category = Category.new(params[:category])
      new_category = true
    else
      @category = Category.find(params[:id])
      @category.attributes = params[:category]
      new_category = false
    end
    respond_to do |format|
      format.html { save_category }
      format.js do 
        @category.save
        @article = Article.new
        @article.categories << @category
        return render(:partial => 'admin/content/categories')
      end
    end
  end

  def save_category
    if @category.save!
      flash[:notice] = _('Category was successfully saved.')
    else
      flash[:error] = _('Category could not be saved.')
    end
    redirect_to :action => 'new'
  end
end
