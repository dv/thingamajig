require "rb-scpt"
require "thingamajig/version"
require "thingamajig/osa_object"
require "thingamajig/area"
require "thingamajig/project"
require "thingamajig/todo"

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
