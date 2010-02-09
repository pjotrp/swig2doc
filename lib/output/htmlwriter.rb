
class HtmlWriter

  def initialize(tree)
    @tree = tree
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
    @tree.each do | mod |
      mod.functions.sort.each do | func |
        print mod.name,':',func.name,"\n"
      end
    end
  end
end
