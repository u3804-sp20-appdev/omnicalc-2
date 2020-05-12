class VisionController < ApplicationController
  require "google/cloud/vision"

  def form
    @detector = params.fetch(:detector)

    if @detector.in?(
        [
          "crop_hints",
          "document_text",
          "face",
          "image_properties",
          "label",
          "landmark",
          "logo",
          "object_localization",
          "product_search",
          "safe_search",
          "text",
          "web",
        ]
      )
      annotator_method = "#{@detector}_detection"
      
      @heading = annotator_method.titleize
    else
      redirect_to("/")
    end
  end

  def magic
    uploaded_file = params.fetch("the_image")

    detector = params.fetch(:detector)

    @annotator_method = "#{detector}_detection"

    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    results = image_annotator.send(@annotator_method, { :image => File.open(uploaded_file) })

    @responses = results.responses
    @heading = @annotator_method.titleize
    @form_path = "/vision/#{detector}"
  end
end
