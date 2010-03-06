
# $:.unshift '/var/lib/gems/1.8/gems/libxml-ruby-1.1.3/lib/'

require 'libxml'
require 'input/xmleasyreader'
require 'cobj/TexInfo/TexInfocmodule'

class TexInfoXMLParser

  attr_reader :reader, :language, :modulename

  include LibXML

  # Prepare and open a TexInfogen XML file
  def initialize fn
    print XML::LIBXML_VERSION
    print " LibXML TexInfo reads #{fn}\n"
    @fn = fn
    @language = 'C'
    @modulename = nil
    @reader = XMLEasyReader.new(fn)
  end

  # Tell if this is a TexInfo document - this has to be called before 
  # any other reads!
  def texinfo?
    @reader.get_element.name == 'texinfo'
  end

  # Parse the TexInfo XML and turn the information into a simple object list
  def parse
    objectlist = []
    xml = @reader.xml
    if !TexInfogen?
      raise "#{@fn} is not a TexInfo XML document!"
    end
    xml.read
    @reader.each_element_tree("memberdef","sectiondef",nil) do | type, tree |
      # assert it is a function
      if @reader.get_attributes['kind'] == 'function'
        # parse the member DOM tree
        h = parse_memberdef(tree)
        h['kind'] = 'function'
        objectlist.push h
      end
    end
    raise "global:briefdescription missing" if !@reader.get_element('briefdescription')
    short = xml.expand.to_s
    raise "global:detaileddescription missing" if !@reader.get_element('detaileddescription')
    detailed = xml.expand.to_s
    objectlist.push('kind' => 'global', 'briefdescription' => short,
      'detaileddescription' => detailed)
    objectlist
  end

  # Parse the source code and return set of objects for the module
  def cobjs
    objectlist = parse
    TexInfoCModule.new(@modulename,objectlist)
  end

  def parse_memberdef(tree)
    h = {}
    # print tree.to_s,"\n"
    tree.each_element do | e |
      name = e.name
      case name
        when 'type' 
          h[name] = e.child.to_s
        when 'name'
          h[name] = e.child.to_s
        when 'briefdescription'
          h[name] = e.children.to_s
        when 'detaileddescription'
          h[name] = e.children.to_s
        when 'location'
          h['file'] = e['file']
          h['line'] = e['line'].to_i
          h['bodyfile'] = e['bodyfile']
          h['bodystart'] = e['bodystart'].to_i
          h['bodyend'] = e['bodyend'].to_i
      end
    end
    h
  end
end


