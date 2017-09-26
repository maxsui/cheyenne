module SearchHelper
  def search_form(&block)
    render 'helpers/search', &block
  end
end
