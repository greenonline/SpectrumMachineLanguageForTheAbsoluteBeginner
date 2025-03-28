#!/usr/local/bin/perl -w

=begin comment_TODO

TODO:

 - reduce number of globals
   - check for no globals: search for "main::" - there should be no occurences
 - usage from getopts
 - do_the_ascii_thing() should be called from main() 
   - similar to over_8(), and not from within do_the_string_thing()
 - check_over_8() should be called from main(), as should do_the_ascii_thing()
 - &blah (\@hexcode);

=end comment_TODO

=begin comment_old_usage

=head1 NAME

Hexextractor - Extract a hex dump from assembler listing

=head1 SYNOPSIS

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

=cut

=end comment_old_usage

=cut

##################################################################
#
# ### USAGE POD (start)
#
#                    - long getopts
#
##################################################################

#=begin commented_out_usage_long_getopts

=head1 NAME

hexextractor - Extract a hex dump from assembly listing

=head1 SYNOPSIS

hexextractor [options] [infile ... [outfile ...] ]

 Options:
   -ascii           show ASCII table 
   -blank           blank empty memory locations 
   -code            show hex dump 
   -debug           debug mode 
   -extra           read internal file 
   -help            brief help message
   -input           input file <filename>
   -location        show addresses 
   -man             full documentation 
   -output          output file <filename>
   -quiet           not verbose 
   -space           add spaces between hex bytes of code
   -talkative       talkative (i.e. verbose) 
   -upper           global uppercase 
   -upper_select    uppercase addresses/code <addresss|code|both>
   -verbose         verbose 
   -version         display version

 Examples:
   cat freeway_frog_full.asm | perl hexextractor.pl -ascii -code -location -space -blank -verbose -upper_select both
   perl hexextractor.pl -ascii -code -location -space -blank -verbose -upper_select both freeway_frog_full.asm
   perl hexextractor.pl -ascii -code -location -space -blank -verbose -upper_select both -output frogger.hex freeway_frog_full.asm
   perl hexextractor.pl -ascii -code -location -space -blank -verbose -upper_select both -extra

   perl hexextractor.pl -help
   perl hexextractor.pl -version


=head1 OPTIONS

=over 8

=item B<-ascii>

Show ASCII table.

=item B<-blank>

Blank empty memory locations.
Supress???

=item B<-code>

Show hex dump.

=item B<-debug>

Set debug mode.

=item B<-e>

Read the internal ASM document (if present) - no need to use external input file.

=item B<-help>

Print a brief help message and exits.

=item B<-input>

Specify input file.

=item B<-location>

Show addresses.

=item B<-man>

Prints the manual page and exits.

=item B<-output>

Specify output file.

=item B<-quiet>

Disable verbose mode.

=item B<-space>

Add spaces between hex bytes of code.
Supress???

=item B<-talkative>

Talkative (i.e. verbose) mode.

=item B<-upper>

Use uppercase for all hexadecimal.

=item B<-upper_select>

Specify <address|code|both> to use uppercase for hexadecimal.

=item B<-verbose>

Set verbose mode.

=item B<-version>

Display version.

=back

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

However, you could use this script on any assembly listing that *strictly* follows the two same formats as the freeway frog assembly listing.

Format #1:

    aaaa xxxxxxxx ddddd lllllll iiiiiii iiiiiiiiiiiiiiiiiii ;ccccccccc... 
      4 s  8     s   5 s    7  s   7   s         1         s;

Format #2:

    xx[ xx[ xx[ xx[ xx[ xx[ xx[ xx]]]]]]] 
     2 s 2 s 2 s 2 s 2 s 2 s 2 s 2

=cut

#=end commented_out_usage_long_getopts

#=cut

##################################################################
#
# ### USAGE POD (end)
#
#                    - long getopts
#
##################################################################



##################################################################
#
# ### USAGE POD (start)
#
# For 'abcdehlmsuvwx' - short getopts
#
##################################################################

=begin commented_out_usage_short_getopts

=head1 NAME

hexextractor - Extract a hex dump from assembly listing

=head1 SYNOPSIS

hexextractor [abcdehi:lmo:stuvwx] [infile ... [outfile ...] ]

 Options:
   -a               show ASCII table
   -b               blank empty memory locations
   -c               show hex dump
   -d               debug mode
   -e               read internal file
   -h               brief help message
   -i               input file
   -l               show addresses
   -m               full documentation
   -o               output file
   -s               add spaces between hex bytes of code
   -t               talkative (i.e. verbose)
   -u               global uppercase
   -v               display version
   -w               uppercase addresses
   -x               uppercase code

 Examples:
   cat freeway_frog_full.asm | perl hexextractor.pl -abcls
   perl hexextractor.pl -alcxwbsv -i in.asm -o out.hex
   perl hexextractor.pl -alcxwbsv freeway_frog_full.asm freeway_frog.hex
   cat freeway_frog_full.asm | perl hexextractor.pl -alcxwbs -o frogger.hex
   perl hexextractor.pl -alcxwbse

   perl hexextractor.pl -h
   perl hexextractor.pl -v



=head1 OPTIONS

=over 8

=item B<-a>

Show ASCII table.

=item B<-b>

Blank empty memory locations.
Supress???

=item B<-c>

Show hex dump.

=item B<-d>

Set debug mode.

=item B<-e>

Read the internal ASM document (if present) - no need to use external input file.

=item B<-h>

Print a brief help message and exits.

=item B<-i>

Specify input file.

=item B<-l>

Show addresses.

=item B<-m>

Prints the manual page and exits.

=item B<-o>

Specify output file.

=item B<-s>

Add spaces between hex bytes of code.
Supress???

=item B<-t>

Talkative (i.e. verbose) mode.

=item B<-u>

Use uppercase for all hexadecimal.

=item B<-v>

Display version.

=item B<-w>

Use uppercase for hexadecimal addresses.

=item B<-x>

Use uppercase for hexadecimal code bytes.

=back

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

However, you could use this script on any assembly listing that *strictly* follows the two same formats as the freeway frog assembly listing.

Format #1:

    aaaa xxxxxxxx ddddd lllllll iiiiiii iiiiiiiiiiiiiiiiiii ;ccccccccc... 
      4 s  8     s   5 s    7  s   7   s         1         s;

Format #2:

    xx[ xx[ xx[ xx[ xx[ xx[ xx[ xx]]]]]]] 
     2 s 2 s 2 s 2 s 2 s 2 s 2 s 2

=cut

=end commented_out_usage_short_getopts

=cut

##################################################################
#
# ### USAGE POD (end)
#
# For 'abcdehlmsuvwx' - short getopts
#
##################################################################



##################################################################
#
# ### Start of use 
#
##################################################################

use warnings;
use strict;

#use Getopt::Std;
use Getopt::Long;
use Pod::Usage;

##################################################################
#
# ### End of use
#
##################################################################

##################################################################
#
# ### Start of prototypes
#
##################################################################

sub print_ascii_line ();
sub do_the_ascii_thing ($);
sub to_ascii ($);
sub to_hex ($);
sub address_to_hex ($);
sub code_to_hex ($);
sub check_for_address_change ($$);
sub blank_any_x();
sub do_the_print ($$$);
sub parse_the_hex ($);
#sub reset_hexcode_output_buffer ();
#sub reset_ascii_output_buffer ();
sub reset_output_buffers ();
sub reset_the_line ($);
sub set_next_address_SOL ($);
sub do_the_string_thing ($$$$$);
sub check_over_8 ($$$$);
sub calc_next_address_SOL ();
sub address_div_8 ($);
sub is_mod_8 ($);
sub help_mess ();
sub version_mess ();

#

sub hander_ascii ();
sub hander_blank ();
sub hander_code ();
sub handler_debug ();
sub handler_extra ();
sub handler_input ($$);
sub handler_location ();
sub handler_output ($$);
sub handler_space ();
sub handler_upper ();
sub handler_upper_select ();

##################################################################
#
# ### End of prototypes
#
##################################################################

##################################################################
#
# ### Start of constants
#
##################################################################

=head1 CONSTANTS

Note: Set to zero to enable command line parameters.

=over

=item DEBUG

Should be 0.

=item VERBOSE

Should be 0.

=item DO_ASCII_SHOW

Enable additional ascii character dump.

=item DO_CAPS

Enable upper case hex.

=item DO_ADDRESS_CAPS

Enable upper case hex for addresses.

=item DO_CODE_CAPS

Enable upper case hex for code.

=item DO_ADDRESS_SHOW

Show addresses.

=item DO_CODE_SHOW

Show code.

=item DO_SPACES

Enable spaces between bytes of code.

=item DO_BLANK

Enable blanking of the template markers for empty memory locations.

=item MOD_8

Internal flag for readability.
Find nearest lowest mod 8 address.

=item ADD_8

Internal flag for readability.
Increment address by 8.

=item HEX_TEMPLATE

Boilerplate of the hex output.

=item ASCII_TEMPLATE

Boilerplate of the ASCII output.

=back

=cut

use constant {
    DEBUG => 0,                             # Should be 0
    VERBOSE => 0,                           # Should be 0
    DO_ASCII_SHOW => 0,                     # Enable additional ascii character dump
    DO_CAPS => 0,                           # Enable upper case hex
    DO_ADDRESS_CAPS => 0,                   # Enable upper case hex for addresses
    DO_CODE_CAPS => 0,                      # Enable upper case hex for code
    DO_ADDRESS_SHOW => 0,                   # Enable addresses
    DO_CODE_SHOW => 0,                      # Enable code
    DO_SPACES => 0,                         # Enable spaces between bytes of code
    DO_BLANK => 0,                          # Enable blanking of the template markers...
                                            # ... for empty memory locations.
    MOD_8 => 0,                             # Find nearest lowest mod 8 address
    ADD_8 => 1,                             # Increment address by 8
    HEX_TEMPLATE => "xx xx xx xx xx xx xx xx", 
                                            # Boilerplate of the hex output
    ASCII_TEMPLATE => "........",           # Boilerplate of the ascii output
};

use constant { true => 1, false => 0 };

use constant { VERSION => 0.92 };

##################################################################
#
# ### End of constants
#
##################################################################


##################################################################
#
# ### Start of globals
#
##################################################################

our $address_SOL = "0000";                  # Address of start of hex buffer line
                                            # Always a factor of 8 (8 byte boundary)
our $hexcode_line_buffer = HEX_TEMPLATE;    # The boilerplate of the output
                                            # Insert hex over the xx
#our $current_hexcode_line_buffer_byte = 1;  # Pointer to which byte in the hex buffer
                                            # From 1-8
our $address;                               # Address of current line read
our $hexcode_to_parse;                      # Hexcode of current line read
our $num_bytes;                             # # of bytes of hexcode in current line read
our @array;                                 # Will hold hex bytes of current line read
our $ascii_line_buffer = ASCII_TEMPLATE;    # The boilerplate of the output
#our $current_ascii_line_buffer_byte = 1;    # Pointer to which byte in the ascii buffer

our $current_buffer_byte = 1;               # Pointer to which byte in the buffer(s)

our $opt_a;
our $opt_b;
our $opt_c;
our $opt_d;
our $opt_e;
our $opt_h;
our $opt_i;
our $opt_l;
our $opt_m;
our $opt_o;
our $opt_s;
our $opt_t;
our $opt_u;
our $opt_v;
our $opt_w;
our $opt_x;

our $infile  = "in.asm";                    # freeway_frog_full.asm
our $outfile = "out.hex";                   # freeway_frog_full.hex

our $fhi;                                   # in file handle
our $fho;                                   # out file handle

##################################################################
#
# ### End of globals
#
##################################################################

##################################################################
#
# ### Start of usage
#
##################################################################

#=begin commented_out_long_getopts_code

##################################################################
#
# ### Get Opt Long
#
##################################################################

## From https://perldoc.perl.org/Getopt::Long - thread safety
#my $man = 0;
#my $help = 0;
#
##GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
#pod2usage(1) if $help;
#pod2usage(-exitval => 0, -verbose => 2) if $man;


## From https://stackoverflow.com/q/35508007/4424636 - start
#
#my %opt = ();
#
#GetOptions(
#  \%opt,
#  'help|h|?',
#  'dbtype=s',
#  'mode=s'  ,
#  'file=s@' ,
#  'qaname=s',
#) || pod2usage(1);
#
#_validate_inputs(%opt);

# From https://stackoverflow.com/q/35508007/4424636 - end


## or from https://stackoverflow.com/a/11422904/4424636
#my ($input, $output);
#GetOptions('input=s' => \$input,'output=s' => \$output) or die;
#
#open my $fh, '<', $input or die;
#
#while ( <$fh> ) { 
#    ## Process file.
#}

# From docs long
my $ascii = '';         # option variable with default value (false)
my $blank = '';         # option variable with default value (false)
my $code = '';          # option variable with default value (false)
my $debug = '';         # option variable with default value (false)
my $extra = '';         # option variable with default value (false)
my $help = '';          # option variable with default value (false)
my $location = '';      # option variable with default value (false)
my $man = '';           # option variable with default value (false)
my $space = '';         # option variable with default value (false)
my $talkative = '';     # option variable with default value (false)
my $upper = '';         # option variable with default value (false)
my $upper_select = '';  # option variable with default value (false)
my $verbose = '';       # option variable with default value (false)
my $version = '';       # option variable with default value (false)

GetOptions ('ascii|a'           => \&handler_ascii, 
            'blank|b'           => \&handler_blank, 
            'code|c'            => \&handler_code, 
            'debug|d'           => \&handler_debug, 
            'extra|e'           => \&handler_extra, 
            'help|h'            => \$help, 
            'input|i=s'         => \&handler_input, 
            'location|l'        => \&handler_location, 
            'man|m'             => \$man, 
            'output|o=s'        => \&handler_output, 
            'quiet|q'           => sub { $verbose = 0 }, 
            'space|s'           => \&handler_space, 
            'talkative|t'       => \$talkative, 
            'upper|u'           => \&handler_upper, 
            'upper_select|x=s'  => \&handler_upper_select, 
            'verbose!'        => \$verbose, 
            'version|v'         => \$version
           )  or die "Usage: $0 --from NAME\n";

=begin commented_out_unified_non_handler_code

if ($input or $ARGV[0]) {
  if ($input) {
    print "i=$input\n" if DEBUG or $opt_d;
    print "Filename to read: $input\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $infile = $input;
  } elsif ($ARGV[0]) {
    print "Filename to read: $ARGV[0]\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $infile = $ARGV[0];
  } else {
    print "Unknown file error", die $!;
  }
  open $fhi, '<', $infile or die $!;

} elsif ($opt_e) {
  print "Filename to read: Internal DATA\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $fhi = \*DATA;
} else {
  # Just use STDIN
  # From https://stackoverflow.com/a/29167251/4424636
  $fhi = \*STDIN;
  print "Reading from STDIN\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
}

if ($output or $ARGV[1]) {
  if ($output) {
    print "o=$output\n" if DEBUG or $opt_d;
    print "Filename to write: $output\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $outfile = $output;
  } else {
    print "Filename to write: $ARGV[1]\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $outfile = $ARGV[1];
  }
  open $fho, '>', $outfile or die $!;

} else {
  # Just use STDOUT
  # From https://stackoverflow.com/a/29167251/4424636
  $fho = \*STDOUT;
  print "Writing to STDOUT\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
}

=end commented_out_unified_non_handler_code

=cut

#=end commented_out_long_getopts_code

#=cut

=begin commented_out_short_getopts_code

##################################################################
#
# ### Get Opt Short
#
##################################################################


# From docs - short

$Getopt::Std::STANDARD_HELP_VERSION = true;
getopts('abcdhi:lmo:suvwx');  # Options as above
#getopts('abcdhi:lmo:suvwx', \my %opts);  # Options as above, values in %opts
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

if ($opt_h) {
  help_mess();
  exit(0);
}
if ($opt_v) {
  version_mess();
  exit(0);
}

=begin commented_out_shortopts_non_handler_code

if ($opt_i or $ARGV[0]) {
  if ($opt_i) {
    #&handler_input();

    print "i=$opt_i\n" if DEBUG or $opt_d;
    print "Filename to read: $opt_i\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
    $infile = $opt_i;
  } elsif ($ARGV[0]) {
    print "Filename to read: $ARGV[0]\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
    $infile = $ARGV[0];
  } else {
    print "Unknown file error", die $!;
  }
  open $fhi, '<', $infile or die $!;
} elsif ($opt_e) {
  #&handler_extra();

  print "Filename to read: Internal DATA\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $fhi = \*DATA;
} else {
  # Just use STDIN
  # From https://stackoverflow.com/a/29167251/4424636
  $fhi = \*STDIN;
  print "Reading from STDIN\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
}


#if ($opt_i) {
#  print "i=$opt_i\n" if DEBUG or $opt_d;
#  print "Filename to read: $opt_i\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
#  $infile = $opt_i;
#
#  open $fhi, '<', $infile or die $!;
#
#} else {
#  # Just use STDIN
#  # From https://stackoverflow.com/a/29167251/4424636
#  $fhi = \*STDIN;
#  print "Reading from STDIN\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
#}


if ($opt_o or $ARGV[1]) {
  if ($opt_o) {
    #&handler_output();

    print "o=$opt_o\n" if DEBUG or $opt_d;
    print "Filename to write: $opt_o\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
    $outfile = $opt_o;
  } else {
    print "Filename to write: $ARGV[1]\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
    $outfile = $ARGV[1];
  }
  open $fho, '>', $outfile or die $!;

} else {
  # Just use STDOUT
  # From https://stackoverflow.com/a/29167251/4424636
  $fho = \*STDOUT;
  print "Writing to STDOUT\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
}


#if ($opt_o) {
#  print "o=$opt_o\n" if DEBUG or $opt_d;
#  print "Filename to write: $opt_o\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
#  $outfile = $opt_o;
#
#  open $fho, '>', $outfile or die $!;
#
#} else {
#  # Just use STDOUT
#  # From https://stackoverflow.com/a/29167251/4424636
#  $fho = \*STDOUT;
#  print "Writing to STDOUT\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
#}

=end commented_out_shortopts_non_handler_code

=cut

=begin commented_out_shortopts_handler_code

if ($opt_i) {
  &handler_input("$opt_i",$opt_i);
}

if ($opt_o) {
  &handler_output("$opt_i",$opt_o);
}

if ($opt_e) {
  &handler_extra();
}

=end commented_out_shortopts_handler_code

=cut

=end commented_out_short_getopts_code

=cut

##################################################################
#
# ### Pure @ARGV stuff
#
##################################################################

#=begin comment_out_argv

# Need to check for $fhi and $fho already set

if ($ARGV[0] and !$fhi) {
  print "In ARGV[0]\n" if DEBUG or $opt_d;
  print "Filename to read: $ARGV[0]\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
  $infile = $ARGV[0];

  open $fhi, '<', $infile or die $!;

#} else {
} elsif (!$fhi) {
  print "In ARGV[0] else\n" if DEBUG or $opt_d;
  # Just use STDIN
  # From https://stackoverflow.com/a/29167251/4424636
  $fhi = \*STDIN;
  print "Writing to STDIN\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
}

if ($ARGV[1] and !$fho) {
  print "In ARGV[1] if\n" if DEBUG or $opt_d;
  print "Filename to write: $ARGV[1]\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
  $outfile = $ARGV[1];

  open $fho, '>', $outfile or die $!;

#} else {
} elsif (!$fho) {
  print "In ARGV[1] else\n" if DEBUG or $opt_d;
  # Just use STDOUT
  # From https://stackoverflow.com/a/29167251/4424636
  $fho = \*STDOUT;
  print "Writing to STDOUT\n" if DEBUG or $opt_d or VERBOSE or $opt_t;
}

#=end comment_out_argv

#=cut


##################################################################
#
# ### End of usage
#
##################################################################


##################################################################
#
# ### Start of main!
#
##################################################################

  print "In main\n" if DEBUG or $opt_d;

my $line;

#while($line = <$fhi> and $opt_e and $line !~ /^__END__$/) {
#while(($line = <$fhi> ) !~ /^__END__$/) {
while( $line = <$fhi> ) {

  print "In main:while()\n" if DEBUG or $opt_d;

  chomp $line;

  last if $opt_e and $line =~ m/^__END__$/i;

  if ($line =~ /^\s*([0-9a-fA-F]{2}(?:\s|$))+/) {

    # Get the standard hex listing with address and hexcode 
    # Do the grep for a string of double digit hex numbers seperated by space

    print "OddBytes: ".$line."\n" if DEBUG or $opt_d;
    my $this_line_of_hexcode = $line;
    # Remove any spaces
    $this_line_of_hexcode =~ s/ //g;
    # get number of bytes
    $num_bytes = length($this_line_of_hexcode)/2;
    print "Current line: $this_line_of_hexcode -> Bytes: $num_bytes\n" if DEBUG or $opt_d;
    # get the bytes
    $hexcode_to_parse = $this_line_of_hexcode;

    parse_the_hex($num_bytes);
    #do_the_string_thing();
    #do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
    do_the_string_thing($num_bytes, $current_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
  } else {

    # Get the standard hex listing with address and hexcode 
    # Do the cut -f 2 -d ' ' freeway_frog_full.asm

    # Does line have 4 and then 2-8 digits?
    if ($line =~ /^([0-9a-fA-F]{4})\s{1}([0-9a-fA-F]{2,8})\s+/) {  

      # Checked for the standard hex listing format with address and hexcode 

      $address = $1;
      my $this_line_of_hexcode = $2;
      # get number of bytes
      $num_bytes = length($this_line_of_hexcode)/2;
      # get the bytes
      $hexcode_to_parse = $this_line_of_hexcode;

      parse_the_hex($num_bytes);

      if (DEBUG or $opt_d) {
        print  "Addr: $address  Hex: $this_line_of_hexcode  # bytes: $num_bytes\n";
        print  "The bytes: ";
        for(my $i = 0; $i < $num_bytes; ++$i) {
          print $array[$i]." ";
        }
        print "\n";
      }

      # Is address divisible by 8?
      # If so, assign to address_SOL and flag to print
      if (address_div_8($address)){
        reset_the_line(MOD_8);
      } else {
        # Check here for sudden address change
        #check_for_address_change();
        check_for_address_change($address, $address_SOL);
      }
      #do_the_string_thing();
      #do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
      do_the_string_thing($num_bytes, $current_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
    }
  }
  # Can't do it here (yet), as it depends on ifs... even an elsif won't help
  # ... not all lines require a string_thing (if no data found)
  #do_the_string_thing();
  #do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
}

do_the_print($hexcode_line_buffer, $address_SOL, $ascii_line_buffer);

if ($ARGV[0] or $opt_i) {
  close $fhi or die $!;
}
if ($ARGV[1] or $opt_o) {
  close $fho or die $!;
}

exit 0;

##################################################################
#
# ### End of main!
#
##################################################################


=head1 SUBROUTINES

=over

=item print_ascii_line()

Returns ASCII buffer line.

=cut

sub print_ascii_line ()
{
  return $main::ascii_line_buffer;
}

=item do_the_ascii_thing($)

Populates the ASCII buffer line with characters.

=cut

sub do_the_ascii_thing ($)
{
  my $num = shift;

  if (hex($num)>31 and hex($num)<127) {
    #substr($main::ascii_line_buffer, $main::current_ascii_line_buffer_byte-1, 1) = to_ascii(hex($num)); # deletes the substring in offset 0-2
    substr($main::ascii_line_buffer, $main::current_buffer_byte-1, 1) = to_ascii(hex($num)); # deletes the substring in offset 0-2
  }
  #$main::current_ascii_line_buffer_byte++;

}

=item to_ascii($)

Returns ASCII value of decimal.

=cut

sub to_ascii ($)
{
  my $num = shift;

  return chr($num);
}

=item to_hex($)

Returns hex value of decimal.

=cut

sub to_hex ($)
{
  my $num =shift;

  if (DO_CAPS or $opt_u or $opt_w or $opt_x) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item address_to_hex($)

Returns hex value of decimal.

=cut

sub address_to_hex ($)
{
  my $num =shift;

  if (DO_CAPS or DO_ADDRESS_CAPS or $opt_u or $opt_w) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item code_to_hex($)

Returns hex value of decimal.

=cut

sub code_to_hex ($)
{
  my $num =shift;

  if (DO_CAPS or DO_CODE_CAPS or $opt_u or $opt_x) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item check_for_address_change($$)

Checks for drastic address change

=cut

sub check_for_address_change ($$)
{

  my ( $decimal_address, $decimal_address_SOL ) = @_;
  $decimal_address = hex($decimal_address);
  $decimal_address_SOL = hex($decimal_address_SOL);

  # Check here for sudden address change
  #my $tmp_address = hex($main::address);
  #my $tmp_address_SOL = hex($main::address_SOL);
  print "Dec_Addr: $decimal_address  Dec_Addr_SOL:  $decimal_address_SOL\n" if DEBUG or $opt_d;
  # Check to see if current address is out the line
  # ... i.e. out of the range of 8 addresses for this line
  if (($decimal_address > $decimal_address_SOL+8) 
    || ($decimal_address < $decimal_address_SOL)) {
    reset_the_line(MOD_8);
  }
  # Check to see if current address is contiguous
  # ... i.e. follows the previous
  #if($main::address <> $main::address_SOL + $main::current_hexcode_line_buffer_byte ) {
  #elsif($decimal_address != $decimal_address_SOL + $main::current_hexcode_line_buffer_byte - 1 ) {
  elsif($decimal_address != $decimal_address_SOL + $main::current_buffer_byte - 1 ) {
    # We have a non-sequential address
    # ... but are still within the range of 8 bytes...
    # ... so we are on the same line.
    $main::current_buffer_byte = $decimal_address - $decimal_address_SOL + 1;
    #$main::current_hexcode_line_buffer_byte = $decimal_address - $decimal_address_SOL + 1;
    #$main::current_ascii_line_buffer_byte   = $decimal_address - $decimal_address_SOL + 1 if DO_ASCII_SHOW or $opt_a;
  } else {
    # We have a sequential address
    # Do nothing as increment is done in do_the_xxx_thing()
    #$main::current_hexcode_line_buffer_byte++;
    #$main::current_ascii_line_buffer_byte++ if DO_ASCII_SHOW or $opt_a;
  }
}

=item blank_any_x()

Replace any 'x' placemarkers for spaces in the hex line output buffer

=cut

sub blank_any_x()
{
  my $length = length($main::hexcode_line_buffer);

  # Go through and check each character position sequentially 
  # - easier than checking for pairs at weirdly spaced intervals
  for (my $i = 0; $i < $length; $i++) {
    my $substring = substr($main::hexcode_line_buffer, $i, 1);
    if ($substring eq "x") {
    #if ($main::hexcode_line_buffer[$1] eq "x") {
      substr($main::hexcode_line_buffer, $i, 1) = " "; # deletes the substring in offset 0-2
    }
  }
}

=item do_the_print($$$)

Print the start of line address and the hex line output buffer

=cut

sub do_the_print ($$$)
{
  my ( $hexcode_line_buf, $addr_SOL, $ascii_line_buf) = @_;

  # Print previous line (if not totally blank)
  #if (not $main::hexcode_line_buffer eq HEX_TEMPLATE){
  if (not $hexcode_line_buf eq HEX_TEMPLATE){
    # Blank out the 'xx' if required
    blank_any_x() if (DO_BLANK or $main::opt_b);
    # Set again to get changes from blank_any_x()
    $hexcode_line_buf = $main::hexcode_line_buffer;
    # Note: $hexcode_line_buf will not work as passed by reference, unless you set again after blank_any_x()
    # Remove spaces
    $hexcode_line_buf =~ s/ //g if not (DO_SPACES or $opt_s);
    # Pad end of line with spaces - field width 23 (8 x 2 = 16 + 7 spaces)
    $hexcode_line_buf = sprintf '%-23s', $hexcode_line_buf if not (DO_SPACES or $opt_s);
    if (DO_ADDRESS_SHOW or $opt_l) {
      print $main::fho "$addr_SOL: ";
    } 
    if (DO_CODE_SHOW or $opt_c) {
      print $main::fho "$hexcode_line_buf";
    } 
    if (DO_ASCII_SHOW or $opt_a) {
      print $main::fho "  $ascii_line_buf";
      #print print_ascii_line();
    }
    # If we have printed anything, then new line - else don't bother filling the screen
    if (DO_ADDRESS_SHOW or $opt_l or DO_CODE_SHOW or $opt_c or DO_ASCII_SHOW or $opt_a) {
      print $main::fho "\n";
    }
  }
}

=item parse_the_hex($)

Parse the current line's hex code block and extract the bytes into @array

=cut

sub parse_the_hex ($)
{
  my $num_byte = shift;

  for(my $i = 0; $i < $num_byte; ++$i) {
    # from https://stackoverflow.com/a/19502459/4424636
    $main::array[$i] = substr($main::hexcode_to_parse, 0, 2);    # returns chars 0, 1
    substr($main::hexcode_to_parse, 0, 2) = ""; # deletes the substring in offset 0-1
  }
}

#=item reset_hexcode_output_buffer()
#
#Reset both the hex line output buffer and current byte counter
#
#=cut
#
#sub reset_hexcode_output_buffer ()
#{
#  $main::hexcode_line_buffer = HEX_TEMPLATE;
#  $main::current_hexcode_line_buffer_byte = 1;
#}

#=item reset_ascii_output_buffer()
#
#Reset both the hex line output buffer and current byte counter
#
#=cut
#
#sub reset_ascii_output_buffer ()
#{
#  $main::ascii_line_buffer = ASCII_TEMPLATE;
#  $main::current_ascii_line_buffer_byte = 1;
#}

=item reset_output_buffers()

Reset both the hex line output buffer and current byte counter

=cut

sub reset_output_buffers ()
{
  $main::ascii_line_buffer = ASCII_TEMPLATE;
  $main::hexcode_line_buffer = HEX_TEMPLATE;
  $main::current_buffer_byte = 1;
}

=item reset_the_line($)

Print and reset the hex line output buffer.

A unified reset of the line buffers (ascii and hex). 

Pass 1 to calculate start of line address (+8).
Pass 0 to use the address of the current assembler line to determine nearest mod 8.

=cut

sub reset_the_line ($)
{
  my $do_calc = shift;

  do_the_print($main::hexcode_line_buffer, $main::address_SOL, $main::ascii_line_buffer);


  #reset_ascii_output_buffer() if DO_ASCII_SHOW or $opt_a;     # Do in this order! -> #1
  #reset_hexcode_output_buffer();                              # Do in this order! -> #1
  reset_output_buffers();
  if ($do_calc){
    calc_next_address_SOL();                                  # Do in this order! -> #2
  } else {
    set_next_address_SOL($main::address);                     # Do in this order! -> #2
  }
}

=item set_next_address_SOL($)

Set next start of line address, 
Get from address stated on current input line.
Work out the closest mod 8 line number.
This is the exceptional way to update the start of line number,
working from a broken sequence, 
using the address of the start of the new sequence.

=cut

sub set_next_address_SOL ($)
{

  my $current_address = shift;

  # Convert to the case being used for addresses
  my $first_factor_of_8 = address_to_hex(hex($current_address));

  # Get the decimal equivalent
  my $decimal_first_factor_of_8 = hex($first_factor_of_8);

  # Find the first factor of 8 below current address
  while (not is_mod_8($decimal_first_factor_of_8)) {
    $decimal_first_factor_of_8--;
    $first_factor_of_8 = address_to_hex($decimal_first_factor_of_8);
  }
  # Set start of line address with factor of 8 that was found
  $main::address_SOL = $first_factor_of_8;
  # Get the difference between start and current positions, in decimal
  my $decimal_current_address = hex($current_address);
  #$main::current_hexcode_line_buffer_byte = $decimal_current_address - $decimal_first_factor_of_8 + 1;
  $main::current_buffer_byte = $decimal_current_address - $decimal_first_factor_of_8 + 1;
}

=item do_the_string_thing($$$$$)

Fill out the hex line output buffer
Replace the "x" place markers with the hex code for the bytes

=cut

sub do_the_string_thing ($$$$$)
{
  my ( $num_byte, $current_hexcode_line_buf_byte, $hexcode_line_buf, $addr_SOL, $ascii_line_buf) = @_;

  for (my $index = 0; $index < $num_byte; $index++) {
    #print "Buf: $main::hexcode_line_buffer   Ptr: $main::current_hexcode_line_buffer_byte  Idx: $main::array[$index] -> @main::array\n" if DEBUG or $opt_d;
    print "Buf: $main::hexcode_line_buffer   Ptr: $main::current_buffer_byte  Idx: $main::array[$index] -> @main::array\n" if DEBUG or $opt_d;

    # Substitute the 2 digit hex number into the buffer,
    # at the correct location.
    # Convert to the global case being used
    # This ignores the case - don't use
    #substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = to_hex(hex($main::array[$index]));
    # This works!!!
    #substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    # Using unified buffer byte
    substr($main::hexcode_line_buffer, ($main::current_buffer_byte-1)*2+(1*($main::current_buffer_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    # This should work but misses out random characters
    #substr($main::hexcode_line_buffer, ($current_hexcode_line_buf_byte-1)*2+(1*($current_hexcode_line_buf_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    # This will not work as hexcode_line_buf passed by value, not reference
    #substr($hexcode_line_buf, ($current_hexcode_line_buf_byte-1)*2+(1*($current_hexcode_line_buf_byte-1)), 2) = code_to_hex(hex($main::array[$index]));

    # Increment buffer pointer
    #$main::current_hexcode_line_buffer_byte = $main::current_hexcode_line_buffer_byte +1;
    #$main::current_hexcode_line_buffer_byte++;
    # Use unified buffer byte pointer
    $main::current_buffer_byte++;
    # This will not work as current_hexcode_line_buf_byte passed by value, not reference
    #current_hexcode_line_buf_byte++ ;;

    # Call the ascii table filling routine
    # Should this be in main()???
    do_the_ascii_thing($main::array[$index]) if DO_ASCII_SHOW or $opt_a;

    # Check to see if pointer has reached end of line
    #check_over_8($main::current_hexcode_line_buffer_byte, $main::hexcode_line_buffer, $main::address_SOL, $main::ascii_line_buffer);
    # Use unified buffer byte pointer
    check_over_8($main::current_buffer_byte, $main::hexcode_line_buffer, $main::address_SOL, $main::ascii_line_buffer);
    # Can not send $current_hexcode_line_buf_byte as...
    # ... $main::current_hexcode_line_buffer_byte has changed!
    #check_over_8($current_hexcode_line_buf_byte, $hexcode_line_buf, $addr_SOL, $ascii_line_buf);
  }
}

=item check_over_8($$$$)

Is the current line buffer byte over 8? 
If so, then new line.

=cut

sub check_over_8 ($$$$)
{
  # This is best with passed arguments if it is at top level, and not inside do_the_string_thing() - why? Because otherwise, you end up passing down the same variables, down the chain, or giving up and just using $main::xxx half way up the chain. Besides, this function feels like it should be done in main().
  my ( $current_hexcode_line_buf_byte, $hexcode_line_buf, $addr_SOL, $ascii_line_buf) = @_;

  if ($current_hexcode_line_buf_byte > 8) {
    # Reset the line
    reset_the_line(ADD_8);
  }
}

=item calc_next_address_SOL()

Calculate next start of line address, 
by simply adding 8.
This is the usual way to update the start of line number,
for contiguous blocks of code.

=cut

sub calc_next_address_SOL ()
{
  my $next_address = hex($main::address_SOL) + 8;
  $main::address_SOL = address_to_hex($next_address);
}

=item address_div_8($)

Is the hex address divisible by 8? 
If so, then new line.

=cut

sub address_div_8 ($)
{
  my $a = shift;

  #print $a =~ s/\\x([0-9a-fA-F]{2})/chr hex $1/gre;
  my $decimal = hex($a);

  return is_mod_8($decimal);
}

=item is_mod_8($)

Is number divisible by 8?

=cut

sub is_mod_8 ($)
{
  # From https://stackoverflow.com/a/24944726/4424636
  my $number = shift;
  return not ($number % 8);   # Modulo arithmetic
}

=item help_mess()

Help message.

=cut

sub help_mess ()
{
  print "Usage:\n\n";
  print "    cat freeway_frog_full.asm | perl hexextractor.pl -abcls
    perl hexextractor.pl -alcxwbsv -i in.asm -o out.hex
    perl hexextractor.pl -alcxwbsv freeway_frog_full.asm freeway_frog.hex

    cat freeway_frog_full.asm | perl hexextractor.pl -alcxwbs -o frogger.hex
    cat freeway_frog_full.asm | perl hexextractor.pl -alcxwbs fraggle.hex

    perl hexextractor.pl -h
    perl hexextractor.pl -v
\n";

  print "hexextractor [abcdhi:lmo:stuvwx] [file ...]

 Options:
   -a               show ASCII table
   -b               blank empty memory locations
   -c               show hex dump
   -d               debug mode
   -h               brief help message
   -i               input file
   -l               show addresses
   -m               full documentation
   -o               output file
   -s               add spaces between hex bytes of code
   -t               talkative (i.e. verbose)
   -u               global uppercase
   -v               display version
   -w               uppercase addresses
   -x               uppercase code
";
}

=item version_mess()

Version message.

=cut

sub version_mess ()
{
  print VERSION."\n";
}

=item handler_ascii()

Handler for 'ascii' long opt.

=cut

sub handler_ascii ()
{
  $main::opt_a = 1;
}

=item handler_blank()

Handler for 'blank' long opt.

=cut

sub handler_blank ()
{
  $main::opt_b = 1;
}

=item handler_code()

Handler for 'code' long opt.

=cut

sub handler_code ()
{
  $main::opt_c = 1;
}

=item handler_debug()

Handler for 'debug' long opt.

=cut

sub handler_debug ()
{
  $main::opt_d = 1;
}

=item handler_extra()

Handler for 'extra' long opt.

=cut

sub handler_extra ()
{
  if (!$main::opt_e) {
    # This should work... as $extra has been "set" (to 1?) by getopts
    $main::opt_e = $extra;
    # but also equivalent to
    #$main::opt_e = 1;
  }

  # If we do the file handle here, instead of messy if

  # If the input filehandle isn't already set
  if (!$fhi){
    # First check to see if __DATA__ is present and full

    # How to check???

    print "Filename to read: Internal DATA\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    $fhi = \*DATA;
  }
}

=item handler_input($$)

Handler for 'input' long opt.

=cut

sub handler_input ($$)
{
  my ($input_name, $input) = @_;

  # If we do the file handle here, instead of messy if.

  # If the input filehandle isn't already set
  if (!$main::fhi){

    print "i=$input\n" if DEBUG or $opt_d;
    print "Filename to read: $input\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    #$infile = $input;

    #open $main::fhi, '<', $infile or die $!;
    open $main::fhi, '<', $input or die $!;
  }
}

=item handler_output($$)

Handler for 'output' long opt.

=cut

sub handler_output ($$)
{
  my ($output_name, $output) = @_;

  # If we do the file handle here, instead of messy if.

  # If the output filehandle isn't already set
  if (!$main::fho){

    print "o=$output\n" if DEBUG or $opt_d;
    print "Filename to write: $output\n" if DEBUG or $opt_d or VERBOSE or $verbose or $talkative;
    #$outfile = $output;

    #open $main::fho, '>', $outfile or die $!;
    open $main::fho, '>', $output or die $!;
  }
}

=item handler_location()

Handler for 'location' long opt.

=cut

sub handler_location ()
{
  $main::opt_l = 1;
}

=item handler_space()

Handler for 'space' long opt.

=cut

sub handler_space ()
{
  $main::opt_s = 1;
}

=item handler_upper()

Handler for 'upper' long opt.

=cut

sub handler_upper ()
{
  $main::opt_u = 1;
}

=item handler_upper_select()

Handler for 'upper_select' long opt.

=cut

sub handler_upper_select ()
{
  my ($opt_name, $opt_value) = @_;

  print "in upper_select: " if DEBUG or $opt_d;

  if ($opt_value eq "address") {
    $main::opt_w = 1; # Upper case addresses
    print "address \n" if DEBUG or $opt_d;
  } elsif ($opt_value eq "code") {
    $main::opt_x = 1; # Upper case code
    print "code\n" if DEBUG or $opt_d;
  } elsif ($opt_value eq "both") {
    $main::opt_w = 1; # Upper case addresses
    $main::opt_x = 1; # Upper case code
    print "both\n" if DEBUG or $opt_d;
  }
}

=back

=cut

__DATA__

# Put the assembler file in full here. Access via file handle hexextractor::DATA

__END__

=head1 REFERENCES

=pod

From [this answer](https://stackoverflow.com/a/63643864/4424636)

=cut

=begin text

(?:^|\s)([0-9a-fA-F]{2}(?:\s|$))+

=end text

=pod

Modify to

=cut

=begin text

^\s*([0-9a-fA-F]{2}(?:\s|$))+


=end text

=cut

=head1 NOT USED

=pod

 From [this answer](https://stackoverflow.com/a/26386262/4424636):

=cut

=begin text  

if ( my ( $timestamp, $chnl, $page ) = m/(.*):.*solo_video_channel_write(.*): queueing page (.*).*/ ) {

=end text

=cut


