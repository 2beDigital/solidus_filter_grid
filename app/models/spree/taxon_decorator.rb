Spree::Taxon.class_eval do

  def applicable_filters
    fs = []
    fs << Spree::Core::ProductFilters.price_between if Spree::Core::ProductFilters.respond_to?(:price_between)
    fs << Spree::Core::ProductFilters.brand_filter if Spree::Core::ProductFilters.respond_to?(:brand_filter)
    fs << Spree::Core::ProductFilters.all_taxons if Spree::Core::ProductFilters.respond_to?(:all_taxons)
    # fs << Spree::Core::ProductFilters.size_filter if Spree::Core::ProductFilters.respond_to?(:size_filter)
    # fs << Spree::Core::ProductFilters.color_filter if Spree::Core::ProductFilters.respond_to?(:color_filter)
    # fs << Spree::Core::ProductFilters.with_option if Spree::Core::ProductFilters.respond_to?(:with_option)
    # fs << Spree::Core::ProductFilters.with_property if Spree::Core::ProductFilters.respond_to?(:with_property)
    # fs << Spree::Core::ProductFilters.price_filter if Spree::Core::ProductFilters.respond_to?(:price_filter)
    # fs << Spree::Core::ProductFilters.selective_brand_filter if Spree::Core::ProductFilters.respond_to?(:selective_brand_filter)
    # fs << Spree::Core::ProductFilters.taxons_below if Spree::Core::ProductFilters.respond_to?(:taxon_belows)
    fs
  end  


end
