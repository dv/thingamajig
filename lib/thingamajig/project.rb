class Thingamajig
  class Project < OsaObject
    include Container

    def self.find_by(name:)
      Thingamajig::Project.new(Thingamajig.new.osa_object.projects[name])
    end

    def create_todo!(name, notes)
      Thingamajig::Todo.new @osa_object.make(new: :to_do, with_properties: {name: name, notes: notes})
    end

    def inspect
      "#<Thingamajig::Project '#{name}'>"
    end
  end
end
