require File.expand_path '../spec_helper.rb', __FILE__
require 'json'
describe "My Sinatra Application" do
  describe 'not working ogp parse api' do
    context 'urlが正しくない時' do
      before do
        get '/?url=hogefuga'
      end
      it 'internal server error' do
        expect(last_response.status).to eq 422
      end
      it 'valid message' do
        suppose = {
          'error' => '正しい形式のURLを入力してください'
        }
        body = JSON.parse(last_response.body)
        expect(body).to eq suppose
      end
    end
  end

  describe 'not working ogp parse api' do
    context 'urlが未指定の時' do
      before do
        get '/'
      end
      it 'internal server error' do
        expect(last_response.status).to eq 422
      end
      it 'valid message' do
        suppose = {
          'error' => 'URLを設定してください'
        }
        body = JSON.parse(last_response.body)
        expect(body).to eq suppose
      end
    end
  end

  describe 'end point not found' do
    before do
      get '/sushi'
    end
    it 'it works' do
      expect(last_response.status).to eq 404
    end
  end
  describe 'works ogp parse api' do
    before do
      get '/?url=http://ogp.me'
    end
    it 'it works' do
      expect(last_response.status).to eq 200
    end
    it 'valid json' do
      suppose = {
        "title"=>"Open Graph protocol",
        "description"=>"The Open Graph protocol enables any web page to become a rich object in a social graph.",
        "image"=>"https://ogp.me/logo.png",
        "url"=>"http://ogp.me"
      }
      body = JSON.parse(last_response.body)
      expect(body).to eq suppose
    end
  end
end
