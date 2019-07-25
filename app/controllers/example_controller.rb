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

  #文字認証
  def ddd
  end

  #食べ物認証
  def aaa

    File.binwrite("public/images/test.jpg",params[:image].read)
    @image="/images/test.jpg"
    File.open("#{Rails.root}/public#{@image}") do |images_file|
      classes = @@visual_recognition.classify(
        images_file: images_file,
        classifier_ids:["food"],
        accept_language: ["ja"]
      )
      @aaa= JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
    end
  end

  #なんでも認証
  def bbb

    File.binwrite("public/images/test.jpg",params[:image].read)
    @image="/images/test.jpg"
    File.open("#{Rails.root}/public#{@image}") do |images_file|
      classes = @@visual_recognition.classify(
        images_file: images_file,
        #classifier_ids:["text"],
        accept_language: ["ja"]
      )
      @bbb= JSON.parse(JSON.pretty_generate(classes.result))["images"][0]["classifiers"][0]["classes"]
    end
  end

  #食べ物認証
  def ccc

    File.binwrite("public/images/test.jpg",params[:image].read)
    @image="/images/test.jpg"
    File.open("#{Rails.root}/public#{@image}") do |images_file|
      faces = @@visual_recognition.detect_faces(
        images_file: images_file
      )
      @ccc=JSON.parse(JSON.pretty_generate(faces.result))["images"][0]["faces"][0]
    end
  end

end
