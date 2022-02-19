class Thingamajig
  class Project < Todo
    include Container

    def self.find_by(name:)
      Thingamajig::Project.new(Thingamajig.new.osa_object.projects[name])
    end

    def create_todo!(name, notes)
      new_osa_object = osa_object.make(new: :to_do, with_properties: {name: name, notes: notes})

      Thingamajig::Todo.new(new_osa_object)
    end

    def inspect
      "#<Thingamajig::Project '#{name}'>"
    end
  end
end
