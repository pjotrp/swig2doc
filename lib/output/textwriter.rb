# Swig2doc textual writer
#

class TextWriter

  def initialize(tree)
    @tree = tree
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
    @tree.each_module do | m |
      fn = path + '/' + m.name + '.txt'
      File.open(fn,"w") do | f |
        m.each_description do | descr |
          f.print descr.detailed
        end
        m.each_mapped_func do | func |
          f.print m.name,':',func.name,"\n"
        end
        m.each_unmapped_func do | func |
          f.print m.name,':',func.name," (unmapped)\n"
        end
      end
    end
  end
end
