json.set! '@context', 'http://iiif.io/api/presentation/2/context.json'
json.set! '@id', request.original_url
json.set! '@type', 'sc:AnnotationList'
json.resources(@annotations.map { |a| JSON.parse(a.data) })
