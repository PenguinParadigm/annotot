require 'spec_helper'

RSpec.describe Annotot::Annotation do
  describe '.retrieve_by_id_or_uuid' do
    it 'looks up a non numeric only identifier by uuid' do
      expect(Annotot::Annotation).to receive(:find_by).with(uuid: '123ab')
      expect(described_class.retrieve_by_id_or_uuid('123ab'))
    end
    it 'looks up a numeric only identifier by id' do
      expect(Annotot::Annotation).to receive(:find_by).with(id: '123')
      expect(described_class.retrieve_by_id_or_uuid('123'))
    end
  end
end
