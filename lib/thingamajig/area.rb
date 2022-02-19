class Thingamajig
  class Area < OsaObject
    include Container

    def self.find_by(name:)
      Thingamajig::Area.new(Thingamajig.new.osa_object.areas[name])
    end

    def inspect
      "#<Thingamajig::Area '#{name}'>"
    end
  end
end
