
# $:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'
require 'input/xmleasyreader'
require 'cobj/cmodule'

class DoxyXMLParser

  attr_reader :reader, :language, :modulename

  include LibXML

  # Prepare and open a Doxygen XML file
  def initialize fn
    print XML::LIBXML_VERSION
    print " LibXML Doxygen reads #{fn}\n"
    @fn = fn
    @language = 'C'
    @reader = XMLEasyReader.new(fn)
  end

  # Tell if this is a Doxy document - this has to be called before 
  # any other reads!
  def doxygen?
    @reader.get_element.name == 'doxygen'
  end

  # Parse the Doxy XML and turn the information into a simple object list
  def parse
    objectlist = []
    xml = @reader.xml
    if !doxygen?
      raise "#{@fn} is not a Doxy XML document!"
    end
    reader.each_element_tree("memberdef") do | type, tree |
      # parse_member(tree)
    end
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cmodule
    objectlist = parse
    # CModule.new(@modulename,objectlist)
  end

  def parse_memberdef(tree)
  end
end


