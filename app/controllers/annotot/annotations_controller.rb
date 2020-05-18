require_dependency "annotot/application_controller"

module Annotot
  class AnnotationsController < ApplicationController
    before_action :set_annotation, only: %i[update destroy show]

    # GET /annotations
    def index
      @annotations = Annotation.where(canvas: annotation_search_params)
    end

    # GET /annotations
    def show; end

    # Get /annotations/lists
    def lists
      @annotations = Annotation.where(canvas: annotation_search_params)
    end

    # Get /annotations/pages
    def pages
      @annotations = Annotation.where(canvas: annotation_search_params)
    end

    # POST /annotations
    def create
      @annotation = Annotation.new(annotation_params)

      if @annotation.save
        render json: @annotation.data
      else
        render status: :bad_request, json: {
          message: 'An annotation could not be created'
        }
      end
    end

    # PATCH/PUT /annotations/1
    def update
      if @annotation.update(annotation_params)
        render status: :ok, json: @annotation.data
      else
        render status: :bad_request, json: {
          message: 'Annotation could not be updated.',
          status: :bad_request
        }
      end
    end

    # DELETE /annotations/1
    def destroy
      @annotation.destroy
      render status: :ok, json: {
        message: 'Annotation was successfully destroyed.'
      }
    end

    private

    def set_annotation
      @annotation = Annotot::Annotation.retrieve_by_id_or_uuid(
        CGI.unescape(params[:id])
      )
      raise ActiveRecord::RecordNotFound unless @annotation.present?
    end

    def annotation_params
      params.require(:annotation).permit(:uuid, :data, :canvas)
    end

    def annotation_search_params
      CGI.unescape(params.require(:uri))
    end
  end
end
