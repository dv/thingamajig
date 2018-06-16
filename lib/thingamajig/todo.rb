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

    def activation_date=(new_activation_date)
      if completed? || canceled?
        self.completion_date = nil
      end

      osa_object.schedule(for: new_activation_date)
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
