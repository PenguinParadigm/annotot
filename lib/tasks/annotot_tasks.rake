require 'json'
require 'pathname'

namespace :annotot do
  desc 'Import annotation list from path'
  task :import_file, [:url_path] => :environment do |_t, args|
    path = Pathname.new(args.url_path)
    puts "Importing annotations from #{path}"
    anno_list = JSON.parse(File.read(path))
    puts "#{anno_list['resources'].length} resources found"
    touch_count = 0
    anno_list['resources'].map do |resource|
      uuid = resource['@id']
      selector = resource['on'].first['selector']
      canvas = resource['on'].first['full']

      ##
      # Annotation appears to be Mirador 2.6.0 compatible
      if resource['on'].first['@type'] == 'oa:SpecificResource' && selector['@type'] == 'oa:Choice'
        if selector['default']['@type'] == 'oa:FragmentSelector' && selector['item']['@type'] == 'oa:SvgSelector'
          touch_count += 1
        end
      end

      ##
      # Annotation needs to be updated to a single fragment selector
      if resource['on'].first['@type'] == 'oa:SpecificResource' && selector['@type'] == 'oa:FragmentSelector'
        new_on = "#{canvas}##{selector['value']}"
        resource['on'] = new_on
        touch_count += 1
      end

      ##
      # Annotation only has an SvgSelector and in an non-compliant format
      if selector['@type'] == 'oa:SvgSelector'
        item = selector.deep_dup
        # Fix missing quotes in SVG
        item['value'] = item['value'].gsub('xmlns=http://www.w3.org/2000/svg', 'xmlns="http://www.w3.org/2000/svg"')
        selector['@type'] = 'oa:Choice'
        selector['default'] = {
          '@type' => 'oa:FragmentSelector',
          'value' => 'xywh=0,0,0,0'
        }
        selector.delete('value')
        selector['item'] = item
        resource['on'].first['selector'] = selector.deep_dup
        touch_count += 1
      end

      anno_json = resource.to_json
      anno = Annotot::Annotation.find_or_create_by(uuid: uuid)
      anno.update!(
        canvas: canvas,
        data: anno_json
      )
    end
    puts "Updated #{touch_count} annotations"
  end
end
