module Agilix
  module Buzz
    module Commands
      module Manifest
        def update_manifest_data(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( manifest ), optional_params: %i( ), options: items )
          end
          authenticated_bulk_post cmd: 'updatemanifestdata', root_node: "manifests", body: options
        end

        def put_items(items = [])
          options = items.map do |item|
            argument_cleaner(required_params: %i( items ), optional_params: %i( ), options: items )
          end
          authenticated_bulk_post cmd: 'putitems', root_node: "manifests", body: options
        end
      end
    end
  end
end