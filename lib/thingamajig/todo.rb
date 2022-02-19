class Thingamajig
  class Todo < OsaObject
    def complete!
      self.status = :completed
    end

    def completed?
      self.status == :completed
    end

    def cancel!
      self.status = :canceled
    end

    def canceled?
      self.status == :canceled
    end

    def active? # meaning in "Today"
      activation_date && activation_date <= Date.today.to_time
    end

    # Use `activate!` to move to Today with today's date as the activation
    # date. This moving to Today list means it will also pop up at the top
    # of the Today list in the UI.
    #
    # This is different from using the `schedule` command which retains the
    # position in Today list from earlier.
    def activate!
      osa_object.move(to: Thingamajig::List.today.osa_object)
    end

    def deactivate!
      osa_object.move(to: Thingamajig::List.anytime.osa_object)
    end

    def activation_date=(new_activation_date)
      if completed? || canceled?
        self.completion_date = nil
      end

      if new_activation_date.present?
        osa_object.schedule(for: new_activation_date)
      else
        deactivate!
      end
    end

    # Adds a todo to the bottom of the project
    def project=(new_project)
      if new_project
        super(new_project.osa_object)
      else
        osa_object.project.delete
      end
    end

    def area=(new_area)
      if new_area
        super(new_area.osa_object)
      else
        osa_object.area.delete
      end
    end

    def inspect
      "#<Thingamajig::Todo '#{name}'>"
    end

    class << self
      def predicate_complete
        Appscript.its.status.eq(:completed)
      end

      def predicate_incomplete
        Appscript.its.status.ne(:completed)
      end

      def predicate_open
        Appscript.its.status.eq(:open)
      end

      def predicate_active
        Appscript.its.activation_date.le(Date.today)
      end

      def predicate_upcoming
        Appscript.its.activation_date.gt(Date.today)
      end

      def predicate_anytime
        Appscript.its.activation_date.eq(nil)
      end

      def completion_query(completion)
        raise "Cannot have `nil` completion, use either false or true" if completion.nil?

        if completion
          predicate_complete
        else
          predicate_incomplete
        end
      end
    end
  end
end
