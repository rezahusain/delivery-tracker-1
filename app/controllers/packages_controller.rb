class PackagesController < ApplicationController
  def index
    matching_packages = Package.all

    @list_of_unreceived_packages = Package.where({:is_received => :false}).order({:created_at => :desc})
    @list_of_received_packages = Package.where({:is_received => :true}).order({:created_at => :desc})

    render({ :template => "packages/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_packages = Package.where({ :id => the_id })

    @the_package = matching_packages.at(0)

    render({ :template => "packages/show" })
  end

  def create
    the_package = Package.new
    the_package.description = params.fetch("query_description")
    the_package.arrives_on = params.fetch("query_arrives_on")
    the_package.details = params.fetch("query_details")
    the_package.is_received = false

    if the_package.valid?
      the_package.save
      redirect_to("/packages", { :notice => "Package created successfully." })
    else
      redirect_to("/packages", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.description = params.fetch("query_description")
    the_package.arrives_on = params.fetch("query_arrives_on")
    the_package.details = params.fetch("query_details")
    the_package.is_received = true

    if the_package.valid?
      the_package.save
      redirect_to("/packages/#{the_package.id}", { :notice => "Package updated successfully."} )
    else
      redirect_to("/packages/#{the_package.id}", { :alert => the_package.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_package = Package.where({ :id => the_id }).at(0)

    the_package.destroy

    redirect_to("/packages", { :notice => "Package deleted successfully."} )
  end
end
