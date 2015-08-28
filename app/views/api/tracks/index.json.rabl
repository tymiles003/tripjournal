object false
node(false) { {type: 'FeatureCollection', features: @tracks.map { |t| JSON.parse(t.json) } } }
