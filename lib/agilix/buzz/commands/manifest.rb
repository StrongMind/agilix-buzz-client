module Agilix
  module Buzz
    module Commands
      module Manifest
        def update_manifest_data(manifest_data)
          authenticated_post cmd: 'updatemanifestdata', manifestdata: manifest_data
        end
      end
    end
  end
end