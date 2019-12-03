class ExampleController < ApplicationController

  require "json"
  require "ibm_watson/visual_recognition_v3"
  include IBMWatson

  protect_from_forgery

  def top
  end

  def upload
  end

  @@visual_recognition = VisualRecognitionV3.new(
    version: "2018-03-19",
    iam_apikey: ENV["APIKEY"]
  )

  #文字認識
  def ddd
  end

  #食べ物認識
  def aaa
    if request.post?
      @count=Count.find(1).count
      Count.update(count:@count+1)
      File.binwrite("public/images/test#{@count}.jpg",params[:image].read)
      @image="/images/test#{@count}.jpg"
      File.open("#{Rails.root}/public#{@image}") do |images_file|
        classes = @@visual_recognition.classify(images_file: images_file,classifier_ids:["food"],accept_language: ["ja"])
        @aaa= JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
      end
    end
  end

  #ナンデモ認識
  def bbb
    if request.post?
      @count=Count.find(1).count
      Count.update(count:@count+1)
      File.binwrite("public/images/test#{@count}.jpg",params[:image].read)
      @image="/images/test#{@count}.jpg"
      File.open("#{Rails.root}/public#{@image}") do |images_file|
        classes = @@visual_recognition.classify(images_file: images_file,accept_language: ["ja"])
        @bbb= JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
      end
    end
  end

  #顔認識
  def ccc
    if request.post?
      @count=Count.find(1).count
      Count.update(count:@count+1)
      File.binwrite("public/images/test#{@count}.jpg",params[:image].read)
      @image="/images/test#{@count}.jpg"
      File.open("#{Rails.root}/public#{@image}") do |images_file|
        # faces = @@visual_recognition.detect_faces(images_file: images_file)
        # @ccc=JSON.parse(JSON.pretty_generate(faces.result))["images"][0]["faces"][0]
        classes = @@visual_recognition.classify(images_file: images_file,classifier_ids:["royal_162940933"])
        @json=JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
        @ccc= @json[0]
      end
    end
  end

  def test
  end
end
