json.set! '@context', 'http://iiif.io/api/presentation/3/context.json'
json.set! 'id', request.original_url
json.set! 'type', 'AnnotationPage'
json.items(@annotations.map { |a| JSON.parse(a.data) })
