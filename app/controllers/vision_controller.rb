class VisionController < ApplicationController
  require "google/cloud/vision"

  def process_web
    require "google/cloud/vision"
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    uploaded_data = params.fetch("the_image")
    a_file = File.open(uploaded_data)
    vision_api_results = image_annotator.web_detection({ :image => a_file })
    @responses = vision_api_results.responses
    @first_result = vision_api_results.responses.at(0)

    render("vision/processed_web.html.erb")
  end

  def process_text
    # Run image through Google::Cloud::Vision::ImageAnnotator
    require "google/cloud/vision"
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new
    uploaded_data = params.fetch("the_image")
    submitted_file_to_annotate = File.open(uploaded_data)
    vision_api_results = image_annotator.text_detection({ :image => submitted_file_to_annotate })
    @responses = vision_api_results.responses
    @first_result = vision_api_results.responses.at(0)

    # Save image locally
    submitted_file_to_save = File.open(uploaded_data)
    @new_local_file_name = "public/images/#{uploaded_data.original_filename}"
    File.open(@new_local_file_name, 'w') do |file| 
      file.write(submitted_file_to_save.read)
    end 

    p "1 -- @a_file"
    p submitted_file_to_annotate
    p "2 -- @uploaded_data"
    p uploaded_data
    p "------"

    # Values hard-coded for testing.  Need to include actual values returned by Google Crop Hints API (or other API)
    @top = "0px" 
    @right = "470px" 
    @bottom = "319px"
    @left = "150px"

    p @first_result

    render("vision/processed_text.html.erb")
  end

  def a_text 
    render("vision/text.html.erb")
  end

  def a_web 
    render("vision/web.html.erb")
  end

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
