
class HtmlWriter

  def initialize(tree)
    @tree = tree
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
    @tree.each_module do | m |
      p m.name
      m.each_func do | func |
        print m.name,':',func.name,"\n"
      end
    end
  end
end
