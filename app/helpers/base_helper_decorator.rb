Spree::BaseHelper.module_eval do
	def can_show_filters?
    return (current_page?(products_path) && !params[:keywords]) || (!@taxon.nil? && (current_page?("/t/#{@taxon.permalink}") || current_page?("/#{locale.to_s}/t/#{@taxon.permalink}")) && (@taxon.description.blank? || @taxon.description.present? && @taxon.products.present? && @taxon.description.length < 1000 ))
  end
end