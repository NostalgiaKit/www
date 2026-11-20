class ExportsController < ApplicationController
  include ProjectScoped

  def show
    # TODO: send_data Sb3::Exporter.new(@project, ref: params[:ref] || "HEAD").call,
    #   filename: "#{@project.slug}.sb3", type: "application/x.scratch.sb3"
    head :not_implemented
  end
end
