class Thingamajig
  class Area < OsaObject
    def self.find_by(name:)
      Thingamajig::Area.new(Thingamajig.new.osa_object.areas[name])
    end

    # an Area's To Do list actually contains Projects & Todos, that's
    # why we need some extra filtering
    def todos(filter = nil)
      query = todos_query
      query = query.and(filter) if filter

      osa_object.to_dos[query].get.map do |osa_todo|
        Thingamajig::Todo.new osa_todo
      end
    end

    def projects(filter = nil)
      query = projects_query
      query = query.and(filter) if filter

      osa_object.to_dos[query].get.map do |osa_project|
        Thingamajig::Project.new osa_project
      end
    end

    def inspect
      "#<Thingamajig::Area '#{name}'>"
    end

    private

    def projects_query
      Appscript.its.class_.eq(:project)
    end

    def todos_query
      Appscript.its.class_.ne(:project)
    end
  end
end
