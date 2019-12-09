class ExampleController < ApplicationController
  ["json","ibm_watson/visual_recognition_v3"].map{|lib|require lib}
  include IBMWatson
  protect_from_forgery
  @@visual_recognition = VisualRecognitionV3.new(version: "2018-03-19", iam_apikey: ENV["APIKEY"])
  #どの関数からでもアクセスできるクラス変数
  {aaa:["food","ja"], bbb:["default","ja"], ccc:["royal_162940933","en"]}.map{|k,v|before_action->{set_image([v[0]],[v[1]])}, only:[k]}
  #メソッドそれぞれに引数(分類機名と言語)を渡す（key:関数名, value:2つの引数）(引数はそれぞれ配列型にしなければならないのに注意)
  [:top, :upload, :aaa, :bbb, :ccc, :ddd, :test].map{|method|define_method(method){}}
  #トップ画面、アップロード画面、食べ物認識、なんでも認識、顔認識、文字認識、テスト画面の順にそれぞれのメソッドを一括定義
  define_method(:set_image) do |classifier, lang|  #メソッドごとに分類器と言語が違うためそれを関数の引数にする
    if request.post?
      @count = Count.find(1).count
      Count.update(count:@count+1)
      @image = "/images/test#{@count}.jpg"
      File.binwrite("public#{@image}",params[:image].read)
      File.open("#{Rails.root}/public#{@image}") do |images_file|
        classes = @@visual_recognition.classify(images_file:images_file, classifier_ids:classifier, accept_language:lang)
        @json = JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
      end
    end
  end
end
