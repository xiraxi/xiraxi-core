class XiraxiCore::MenuItem

  attr_reader :parent, :children

  def initialize(parent)
    @parent = parent
  end

  # Append a child to this item. @child can be a XiraxiCore::MenuItem subclass
  # or an instance.
  def add(child)
    @children ||= []

    if child.class == Class
      @children << child.new(self)
    else
      @children << child
    end
  end

  # Check if the node is selected. If there are children, the item is selected
  # when any of its childs is selected
  def selected?(controller)
    if @children.blank?
      path(controller) == controller.request.current_uri
    else
      @children.any? {|c| c.selected?(controller) }
    end
  end

  # Check if the user can see this menu item
  def visible?(controller)
    true
  end

  # Return the text to be shown in the web. You should use t() to
  # internationalize the output
  def label
    raise NotImplementedError, "Subclasses have to implement #label"
  end

  # Returns a string or a hash to the URL associated to this item
  def path(controller)
    raise NotImplementedError, "Subclasses have to implement #path"
  end

  # Iterates over all the inmediate children
  def each_child(&block)
    @children.each(&block) if @children
  end

  private
    def t(*args) # :nodoc:
      # Useful to be used inside #label
      I18n.t(*args)
    end

end
