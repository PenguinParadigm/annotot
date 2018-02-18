require_dependency "annotot/application_controller"

module Annotot
  class AnnotationsController < ApplicationController
    before_action :set_annotation, only: %i[update destroy]

    # GET /annotations
    def index
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
      @annotation = Annotation.find_by(id: params[:id]) || Annotation.find_by(uuid: params[:id])
      raise ActiveRecord::RecordNotFound unless @annotation.present?
    end

    def annotation_params
      params.require(:annotation).permit(:uuid, :data, :canvas)
    end

    def annotation_search_params
      params.require(:uri)
    end
  end
end
