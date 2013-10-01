# Refinery uses the will_paginate gem for pagination, while Spree uses Kaminari.
# Unfortunately, these two gems are incompatible. To work around this:
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per_page(num)
          if (n = num.to_i) <= 0
            self
          else
            limit(n).offset(offset_value / limit_value * n)
          end
        end

        def total_pages
          (total_count.to_f / limit_value).ceil
        end

        alias_method :per, :per_page
        alias_method :num_pages, :total_pages
        alias_method :total_count, :total_entries

      end
    end
  end
end