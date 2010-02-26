
class HtmlWriter

  def initialize(tree)
    @tree = tree
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
    @tree.each_module do | m |
      m.each_func do | func |
        print swigmodule.name,':',func.name,"\n"
      end
    end
  end
end
