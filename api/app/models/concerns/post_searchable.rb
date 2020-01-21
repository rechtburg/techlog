module PostSearchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    index_name "es_post_#{Rails.env}"

    # mapping setting
    settings do
      mappings dynamic: 'false' do
        indexes :id,          type: 'integer'
        indexes :title,       type: 'text', analyzer: 'kuromoji'
        indexes :body,        type: 'text', analyzer: 'kuromoji'
      end
    end

    # generate doc info to index by definition of mapping
    def as_indexed_json(*)
      attributes
        .symbolize_keys
        .slice(:id, :title, :body)
    end
  end

  class_methods do
    def create_index!
      client = __elasticsearch__.client
      client.indices.delete index: self.index_name rescue nil
      client.indices.create(index: self.index_name,
                            body: {
                                settings: self.settings.to_hash,
                                mappings: self.mappings.to_hash
                            })
    end

    def es_search(query)
      __elasticsearch__.search({
        query: {
          multi_match: {
            fields: %w(title body),
            type: 'cross_fields',
            query: query,
            operator: 'and'
          }
        }
      })
    end
  end
end
