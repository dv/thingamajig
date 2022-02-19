require "rb-scpt"
require "thingamajig/version"
require "thingamajig/osa_object"
require "thingamajig/modules/container"

require "thingamajig/area"
require "thingamajig/list"
require "thingamajig/todo"
require "thingamajig/project"


class Thingamajig
  attr :app

  def osa_object
    app
  end

  def initialize
    @app ||= Appscript.app("Things3")
  end

  def projects
    app.projects.get.map do |osa_project|
      Thingamajig::Project.new(osa_project)
    end
  end
end
