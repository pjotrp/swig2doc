require 'erb'

class PodWriter

  def initialize tree
    @tree = tree
  end

  def write path
    Dir.mkdir(path) if !File.directory?(path)
    config = @tree.config
    @tree.each_module do | m |
      fn = path + '/' + m.name + '.pod'
      File.unlink(fn) if File.exist?(fn)
      fullname = "Biolib::"+m.name
      brief_descr = ""
      detailed_descr = ""
      m.each_description do | descr |
        doxyxml = DoxyTransform.new(descr.brief)
        brief_descr += doxyxml.to_s + "\n\n"
        doxyxml = DoxyTransform.new(descr.detailed)
        detailed_descr += doxyxml.to_s + "\n\n"
      end
      header_template = ERB.new <<-EOF

# <%= fn %>
# File generated by <%= config.copyright_msg %>


%perlcode %{
@EXPORT_OK = qw/
        <% m.each_mapped_func do |func| %> <%= func.name %>
        <% end %>
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

<%= fullname %> - <%= brief_descr.strip %>

=head1 SYNOPSIS

=head1 DESCRIPTION

<%= detailed_descr.strip %>

    use <%= fullname %> qw /:all/;

=head1 METHODS

The following functions are available for this module:

=over
<% m.each_mapped_func_descr do |func| %>
=item B< <%= func.to_perl %> >
<% descr = DoxyTransform.new(func.doxy_description).to_s %>
<%= descr %>
<% end %>
=back

The following functions are available for this module, but have no 
description:

=over
<% m.each_mapped_func_undescr do |func| %>
=item B< <%= func.to_perl %> >
<% descr = DoxyTransform.new(func.doxy_description).to_s %>
<%= descr %>
<% end %>
=back

=head1 UNMAPPED METHODS

The following functions have not (yet) been mapped to Perl:

=over

<% m.each_unmapped_func do |func| %>
=item B< <%= func.to_perl %> >
<% descr = DoxyTransform.new(func.doxy_description).to_s %>
<%= descr %>
(Note: this method is not available from Perl)
<% end %>
=back

=head1 AUTHORS

The original code ...

=head1 CONTACT

For more information on the Perl mapping of this module, please 
subscribe to the Biolib mailing list and post the questions there. See
L<http://biolib.open-bio.org/>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) (...)

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

POD generated by <%= config.copyright_msg %>

=cut


EOF
      $stderr.print "Writing #{fn}\n"
      File.open(fn,"w") do | f |
        f.print header_template.result(binding)
      end
    end
  end
end
