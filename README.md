# Annotot
[![Build Status](https://travis-ci.org/mejackreed/annotot.svg?branch=master)](https://travis-ci.org/mejackreed/annotot)

Need to persist annotations quick and easily? Annotot, the original mini annotation API is for you. Don't annotate, annotot instead.

h/t [@eefahy](https://github.com/eefahy) for the inspiration and name

![](annotot.png)

This logo, "Annotot", is a derivative of "[Sweet Potato Tator Tots](https://www.flickr.com/photos/flyfarther79/6270223411/)" by [Lisa Brettschneider](https://www.flickr.com/photos/flyfarther79/) used under [CC BY-NC 2.0](https://creativecommons.org/licenses/by-nc/2.0/). "Annotot" is also licensed under [CC BY-NC 2.0](https://creativecommons.org/licenses/by-nc/2.0/).

## Usage

Annotot provides a simple RESTful endpoint for persisting annotations. Just configure your client to work with its endpoint.

For Mirador integration, you can use the provided `AnnototEndpoint`:

```javascript
// Within Mirador creation options
...
annotationEndpoint: {
  name: 'Annotot',
  module: 'AnnototEndpoint',
  options: {
    endpoint: 'https://www.annotot.biz/annotot/annotations'
  }
},
...
```

If you want to configure Annotot to receive annotations from external sources make sure that you enable CORs in the Rails application. This can be done using [rack-cors](https://github.com/cyu/rack-cors).

## API

Annotot by default mounts itself at `/`. Though [this can be changed](http://guides.rubyonrails.org/engines.html#mounting-the-engine). All API endpoints are relative to its mount location.

| Path / Url | HTTP Verb | Path | Controller#Action |
| --- | --- | --- | --- |
| [annotations_path](#annotationspath) | GET | /annotations(.:format) | annotot/annotations#index {:format=>:json} |
| | POST | /annotations(.:format) | annotot/annotations#create {:format=>:json} |
| [lists_annotations_path](#listsannotationspath) | GET | /annotations/lists(.:format) | annotot/annotations#lists {:format=>:json} |
| [annotation_path](#annotationpath) | PATCH | /annotations/:id(.:format) | annotot/annotations#update {:format=>:json} |
| | PUT | /annotations/:id(.:format) |  annotot/annotations#update {:format=>:json}
| | DELETE | /annotations/:id(.:format) |  annotot/annotations#destroy {:format=>:json}

---

### annotations_path
`GET` - Return annotations for a given canvas

Parameters:

| Name | Required? | Description |
| --- | --- | --- |
| uri | yes | Canvas uri for which to return annotations

`POST` -  Create a new annotation

Parameters:

| Name | Required? | Description |
| --- | --- | --- |
| annotation | yes | object containing creation parameters
| annotation.uuid | no | uuid for annotation
| annotation.data | no | annotation body data as string
| annotation.canvas | no | canvas to place the annotation on

---

### lists_annotations_path
`GET` - Return an AnnotationList of annotations for a given canvas

Parameters:

| Name | Required? | Description |
| --- | --- | --- |
| uri | yes | Canvas uri for which to return annotations

---

### annotation_path
`PATCH`, `PUT` - Update an annotation

Parameters:

| Name | Required? | Description |
| --- | --- | --- |
| id | yes | Canvas uri or Rails ActiveRecord id for annotation to update
| annotation | yes | object containing creation parameters
| annotation.uuid | no | uuid for annotation
| annotation.data | no | annotation body data as string
| annotation.canvas | no | canvas to place the annotation on

`DELETE` - Delete an annotation

Parameters:

| Name | Required? | Description |
| --- | --- | --- |
| id | yes | Canvas uri or Rails ActiveRecord id for annotation to delete


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'annotot'
```

And then execute:
```bash
$ bundle install
```

Install the gem:
```bash
$ rails g annotot:install
```

If you are serving both Mirador and Annotot in the same application, the integration will be easier. You can just require the `annotot_endpoint.js` file.

```javascript
//= require annotot/annotot_endpoint
```

## License
The gem is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).
