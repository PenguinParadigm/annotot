require 'json'
require 'pathname'

namespace :annotot do
  desc 'Import annotation list from path'
  task :import_file, [:url_path] => :environment do |_t, args|
    path = Pathname.new(args.url_path)
    puts "Importing annotations from #{path}"
    anno_list = JSON.parse(File.read(path))
    puts "#{anno_list['resources'].length} resources found"
    anno_list['resources'].map do |resource|
      anno_json = resource.to_json
      uuid = resource['@id']
      anno = Annotot::Annotation.find_or_create_by(uuid: uuid)
      anno.update(
        canvas: resource['on'].first['full'],
        data: anno_json
      )
    end
  end
end
