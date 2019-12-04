class ExampleController < ApplicationController
  ["json","ibm_watson/visual_recognition_v3"].map{|lib|require lib}
  include IBMWatson
  protect_from_forgery
  @@visual_recognition = VisualRecognitionV3.new( version: "2018-03-19", iam_apikey: ENV["APIKEY"] )

  before_action->{ set_image(["food"],["ja"]) }, only: [:aaa]  #共通部分をまとめる
  before_action->{ set_image(["default"],["ja"]) }, only: [:bbb]
  before_action->{ set_image(["royal_162940933"],["en"]) }, only: [:ccc]

  [:top, :upload, :aaa, :bbb, :ccc, :ddd, :test].map{|method|define_method(method){}}
  #トップ画面、アップロード画面、食べ物認識、なんでも認識、顔認識、文字認識、テスト画面　それぞれのメソッドを一括定義

  define_method(:set_image) do |classifier, lang|  #メソッドごとに分類器と言語が違うためそれを引数にする
    if request.post?
      @count=Count.find(1).count
      Count.update(count:@count+1)
      File.binwrite("public/images/test#{@count}.jpg",params[:image].read)
      @image="/images/test#{@count}.jpg"
      File.open("#{Rails.root}/public#{@image}") do |images_file|
        classes = @@visual_recognition.classify(images_file:images_file, classifier_ids:classifier, accept_language:lang)
        @json= JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
      end
    end
  end
end
