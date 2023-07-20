module Agilix
  module Buzz
    module Commands
      module Manifest
        def update_manifest_data(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( entityid data ), optional_params: %i( ), options: item )
          end
          authenticated_bulk_post cmd: 'updatemanifestdata', root_node: 'manifest', body: options
        end

        def put_items(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( entityid itemid data ), optional_params: %i( ), options: item )
          end
          authenticated_bulk_post cmd: 'putitems', root_node: 'item',  body: options
        end
      end
    end
  end
end