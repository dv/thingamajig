class Thingamajig
  class List < OsaObject
    class << self
      def find_by(name:)
        Thingamajig::List.new(Thingamajig.new.osa_object.lists[name])
      end

      def inbox
        find_by(name: "Inbox")
      end

      def today
        find_by(name: "Today")
      end

      def anytime
        find_by(name: "Anytime")
      end

      def upcoming
        find_by(name: "Upcoming")
      end

      def someday
        find_by(name: "Someday")
      end

      def logbook
        find_by(name: "Logbook")
      end

      def trash
        find_by(name: "Trash")
      end

      # Projects scheduled for the future, not in an area ("later projects") in sidebar
      def later_projects
        Thingamajig::List.new(Thingamajig.new.osa_object.lists.ID("THMLonelyLaterProjectsListSource"))
      end
    end

    def inspect
      "#<Thingamajig::List '#{name}'>"
    end
  end
end


