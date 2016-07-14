module Spree
  module Core
    module ProductFilters

      # Size scope
      Spree::Product.add_search_scope :size_any do |*opts|
        option_values = []
        opts.each {|x| option_values << Spree::OptionValue.find_by_presentation(x).id }
        conds = "#{Product.table_name}.id in (select product_id from #{Variant.table_name} v left join spree_option_values_variants ov on ov.variant_id = v.id where ov.option_value_id in (?))", option_values
        Spree::Product.where(conds)
      end

      # Size filter
      def ProductFilters.size_filter

        sizes = Spree::OptionValue.where(:option_type_id => Spree::OptionType.find_by_name!("tshirt-size")).order("position").map(&:presentation).compact.uniq
        { 
          name: :size,
          scope: :size_any,
          conds: nil,
          labels: sizes.map { |k| [k, k] }
        }

      end

      # Color scope
      Spree::Product.add_search_scope :color_any do |*opts|
        option_values = []
        opts.each {|x| option_values << Spree::OptionValue.find_by_presentation(x).id }
        conds = "#{Product.table_name}.id in (select product_id from #{Variant.table_name} v left join spree_option_values_variants ov on ov.variant_id = v.id where ov.option_value_id in (?))", option_values
        Spree::Product.where(conds)
      end

      # Color filter
      def ProductFilters.color_filter

        colors = Spree::OptionValue.where(:option_type_id => Spree::OptionType.find_by_name!("tshirt-color")).order("position").map(&:presentation).compact.uniq
        { 
          name: :colour,
          scope: :color_any,
          conds: nil,
          labels: colors.map { |k| [k, k] }
        }

      end

      Spree::Product.add_search_scope :price_between_any do |*opts|  
        opts = opts[0].split(',')
        low = opts[0].to_f
        high = opts[1].to_f
        Spree::Product.joins(:master => :default_price).where(Price.table_name => { :amount => low..high })
      end

      def ProductFilters.price_between
        {
          name:   :price_between,
          scope:  :price_between_any,
          min: 0,
          max: 1000,
          step:5,
          conds:  nil,
          labels: 'label'
        }
      end

      # brand filter
      Spree::Product.add_search_scope :brand_any do |*opts|
        conds = opts.map {|o| ProductFilters.brand_filter[:conds][o]}.reject { |c| c.nil? }
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        Spree::Product.with_property('brand').where(scope)
      end

      def ProductFilters.brand_filter
        brand_property = Spree::Property.find_by(name: 'brand')
        brands = brand_property ? Spree::ProductProperty.where(property_id: brand_property.id).pluck(:value).uniq.map(&:to_s) : []
        pp = Spree::ProductProperty.arel_table
        conds = Hash[*brands.map { |b| [b, pp[:value].eq(b)] }.flatten]
        {
          name:   :brand,
          scope:  :brand_any,
          conds:  conds,
          labels: (brands.sort).map { |k| [k, k] }
        }
      end

      Spree::Product.add_search_scope :selective_brand_any do |*opts|
        Spree::Product.brand_any(*opts)
      end

      def ProductFilters.selective_brand_filter(taxon = nil)
        taxon ||= Spree::Taxonomy.first.root
        brand_property = Spree::Property.find_by(name: 'brand')
        scope = Spree::ProductProperty.where(property: brand_property).
          joins(product: :taxons).
          where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
        brands = scope.pluck(:value).uniq
        {
          name:   'Applicable Brands',
          scope:  :selective_brand_any,
          labels: brands.sort.map { |k| [k, k] }
        }
      end

      def ProductFilters.taxons_below(taxon)
        return Spree::Core::ProductFilters.all_taxons.distinct(:name) if taxon.nil?
        {
          name:   'Taxons under ' + taxon.name,
          scope:  :taxons_id_in_tree_any,
          labels: taxon.children.sort_by(&:position).map { |t| [t.name, t.id] },
          conds:  nil
        }
      end

    
      def ProductFilters.all_taxons
        taxons = Spree::Taxonomy.all.distinct(:name).map { |t| [t.root] + t.root.descendants }.flatten
        {
          name:   :all_taxons,
          scope:  :taxons_id_equals_any,
          labels: taxons.sort_by(&:name).map { |t| [t.name, t.id] },
          conds:  nil # not needed
        }
      end

      Spree::Product.add_search_scope :with_option_any do |*opts|
        option_types = OptionType.table_name
        joins(:option_types).where("#{option_types}.name in (?)", opts )
      end

      def ProductFilters.with_option
        options = Spree::OptionType.all
        {
          name:   :options,
          scope:  :with_option_any,
          conds:  nil,
          labels: options.sort_by(&:name).map { |t| [t.name, t.name] }
        }
      end

      Spree::Product.add_search_scope :with_property_any do |*opts|
        properties = Property.table_name
        property = opts.each do |t| t.to_i end
        joins(:properties).where("#{properties}.id in (?)", property)
      end

      def ProductFilters.with_property
        properties = Spree::ProductProperty.all.distinct
        {
          name:   :property,
          scope:  :with_property_any,
          conds:  nil,
          labels: properties.sort_by(&:value).map { |t| [t.value, t.id] }
        }
      end

    end
  end
end