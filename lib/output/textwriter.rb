# Swig2doc textual writer
#

require 'output/transform/doxytransform'

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
          doxyxml = DoxyTransform.new(descr.brief)
          f.print doxyxml.to_s
          doxyxml = DoxyTransform.new(descr.detailed)
          f.print doxyxml.to_s
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
