class Thingamajig
  class OsaObject
    attr :osa_object

    def initialize(osa_object)
      @osa_object = osa_object
    end

    # Open in GUI
    def show
      osa_object.show
    end

    def method_missing(method_name, *arguments, &block)
      valid_property, getter_or_setter, property =
        parse_method_name(method_name)

      if valid_property
        if getter_or_setter == :getter
          get_and_parse(osa_object.public_send(property))
        else
          osa_object.public_send(property).set(arguments.first)
        end
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      parse_method_name(method_name).first || super
    end

    def to_h
      osa_object.properties_.get
    end
    alias_method :properties, :to_h

    private

    def parse_method_name(method_name)
      method_name = String(method_name)

      getter_or_setter, property =
        if method_name.end_with?("=")
          [:setter, method_name[0..-2]]
        else
          [:getter, method_name]
        end

      [properties.keys.include?(property.to_sym), getter_or_setter, property]
    end

    # OSA returns `:missing_value` for empty fields
    def get_and_parse(osa_object)
      result = osa_object.get

      if result == :missing_value
        nil
      else
        result
      end
    end
  end
end
