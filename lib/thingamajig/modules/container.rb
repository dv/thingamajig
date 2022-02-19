module Thingamajig::Container
  # Some containers have todos and projects in one list
  def items(filter = nil)
    result_reference =
      if filter
        osa_object.to_dos[filter]
      else
        osa_object.to_dos
      end

    results = result_reference.get

    wrap_collection(results)
  end

  def todos(filter = nil)
    query = todos_query
    query = query.and(filter) if filter

    items(query)
  end

  def projects(filter = nil)
    query = projects_query
    query = query.and(filter) if filter

    items(query)
  end

  private

  def wrap_item(item)
    item_class = item.class_.get

    case item_class
    when :to_do, :selected_to_do
      Thingamajig::Todo.new(item)
    when :project
      Thingamajig::Project.new(item)
    when :area
      Thingamajig::Area.new(item)
    when :list
      Thingamajig::List.new(item)
    else
      raise "Don't know what #{item_class} is."
    end
  end

  def wrap_collection(collection)
    collection.map do |item|
      wrap_item(item)
    end
  end

  def projects_query
    Appscript.its.class_.eq(:project)
  end

  def todos_query
    Appscript.its.class_.ne(:project)
  end
end
