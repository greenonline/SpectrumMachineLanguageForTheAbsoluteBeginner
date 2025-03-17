#!/usr/local/bin/perl -w

=head1 TODO

 - getopts - long
 - reduce number of globals
 - usage from getopts
 - Check for no globals: search for "main::" - there should be no occurences
 - do_the_ascii_thing() should be called from main() (similar to over_8()), and not from within do_the_string_thing()
 - check_over_8() whether should be called from main(), as should do_the_ascii_thing()
 - help_mess() and version_mess() for getopts
 - sub blah($$)
 - &blah (\@hexcode);
 - current hex and ascii pointers will always have the same value!!!


=head1 NAME

Hexextractor - Extract a hex dump from assembler listing

=head1 SYNOPSIS

    cat freeway_frog_full.asm | perl hexextractor.pl -abcls

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

=cut

##################################################################
#
# ### Start of use 
#
##################################################################

use warnings;
use strict;

use Getopt::Std;
#use Getopt::Long;
use Pod::Usage;

##################################################################
#
# ### End of use
#
##################################################################

##################################################################
#
# ### Start of globals
#
##################################################################

=head1 CONSTANTS

Note: Set to zero to enable command line parameters.

=over

=item DEBUG

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

our $address_SOL = "0000";                  # Address of start of hex buffer line
                                            # Always a factor of 8 (8 byte boundary)
our $hexcode_line_buffer = HEX_TEMPLATE;    # The boilerplate of the output
                                            # Insert hex over the xx
our $current_hexcode_line_buffer_byte = 1;  # Pointer to which byte in the buffer
                                            # From 1-8
our $address;                               # Address of current line read
our $hexcode_to_parse;                      # Hexcode of current line read
our $num_bytes;                             # # of bytes of hexcode in current line read
our @array;                                 # Will hold hex bytes of current line read
our $ascii_line_buffer = ASCII_TEMPLATE;    # The boilerplate of the output
our $current_ascii_line_buffer_byte = 1;    # Pointer to which byte in the buffer

our $opt_a;
our $opt_b;
our $opt_c;
our $opt_d;
our $opt_h;
our $opt_l;
our $opt_m;
our $opt_s;
our $opt_u;
our $opt_v;
our $opt_w;
our $opt_x;

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


my $man = 0;
my $help = 0;

#GetOptions('help|?' => \$help, man => \$man) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitval => 0, -verbose => 2) if $man;

# From https://stackoverflow.com/q/35508007/4424636 - start

=pod

my %opt = ();

GetOptions(
  \%opt,
  'help|h|?',
  'dbtype=s',
  'mode=s'  ,
  'file=s@' ,
  'qaname=s',
) || pod2usage(1);

_validate_inputs(%opt);

=cut

# From https://stackoverflow.com/q/35508007/4424636 - end

# From docs - short

$Getopt::Std::STANDARD_HELP_VERSION = true;
getopts('abcdhlmsuvwx');  # Options as above
#getopts('abcdhlmsuvwx', \my %opts);  # Options as above, values in %opts
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


while(my $line = <>) {

  chomp $line;

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
    do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
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
      do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
    }
  }
  # Can't do it here (yet), as it depends on ifs... even an elsif won't help
  # ... not all lines require a string_thing (if no data found)
  #do_the_string_thing();
  #do_the_string_thing($num_bytes, $current_hexcode_line_buffer_byte, $hexcode_line_buffer, $address_SOL, $ascii_line_buffer);
}

do_the_print($hexcode_line_buffer, $address_SOL, $ascii_line_buffer);

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

sub print_ascii_line
{
  return $main::ascii_line_buffer;
}

=item do_the_ascii_thing()

Populates the ASCII buffer line with characters.

=cut

sub do_the_ascii_thing
{
  my $num = shift;

  if (hex($num)>32 and hex($num)<128) {
    substr($main::ascii_line_buffer, $main::current_ascii_line_buffer_byte-1, 1) = to_ascii(hex($num)); # deletes the substring in offset 0-2
  }
  $main::current_ascii_line_buffer_byte++;

}

=item to_ascii()

Returns ASCII value of decimal.

=cut

sub to_ascii
{
  my $num = shift;

  return chr($num);
}

=item to_hex()

Returns hex value of decimal.

=cut

sub to_hex
{
  my $num =shift;

  if (DO_CAPS or $opt_u or $opt_w or $opt_x) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item address_to_hex()

Returns hex value of decimal.

=cut

sub address_to_hex
{
  my $num =shift;

  if (DO_CAPS or DO_ADDRESS_CAPS or $opt_u or $opt_w) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item code_to_hex()

Returns hex value of decimal.

=cut

sub code_to_hex
{
  my $num =shift;

  if (DO_CAPS or DO_CODE_CAPS or $opt_u or $opt_x) {
    return sprintf '%02X', $num;
  } else {
    return sprintf '%02x', $num;
  }
}

=item check_for_address_change_simple()

Checks for drastic address change.
Simple version - logic does not work. Hex conversion issue?

=cut

sub check_for_address_change_simple
{
  # Check here for sudden address change
  if (hex($address) > (hex($address_SOL)+8) || hex($address) < hex($address_SOL)) {
    reset_the_line(MOD_8);
  }
}

=item check_for_address_change()

Checks for drastic address change

=cut

sub check_for_address_change
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
  elsif($decimal_address != $decimal_address_SOL + $main::current_hexcode_line_buffer_byte - 1 ) {
    # We have a non-sequential address
    # ... but are still within the range of 8 bytes...
    # ... so we are on the same line.
    $main::current_hexcode_line_buffer_byte = $decimal_address - $decimal_address_SOL + 1;
    $main::current_ascii_line_buffer_byte   = $decimal_address - $decimal_address_SOL + 1 if DO_ASCII_SHOW or $opt_a;
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

sub blank_any_x
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

=item do_the_print()

Print the start of line address and the hex line output buffer

=cut

sub do_the_print
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
      print "$addr_SOL: ";
    } 
    if (DO_CODE_SHOW or $opt_c) {
      print "$hexcode_line_buf";
    } 
    if (DO_ASCII_SHOW or $opt_a) {
      print "  $ascii_line_buf";
      #print print_ascii_line();
    }
    # If we have printed anything, then new line - else don't bother filling the screen
    if (DO_ADDRESS_SHOW or $opt_l or DO_CODE_SHOW or $opt_c or DO_ASCII_SHOW or $opt_a) {
      print "\n";
    }
  }
}

=item parse_the_hex()

Parse the current line's hex code block and extract the bytes into @array

=cut

sub parse_the_hex
{
  my $num_byte = shift;

  for(my $i = 0; $i < $num_byte; ++$i) {
    # from https://stackoverflow.com/a/19502459/4424636
    $main::array[$i] = substr($main::hexcode_to_parse, 0, 2);    # returns chars 0, 1
    substr($main::hexcode_to_parse, 0, 2) = ""; # deletes the substring in offset 0-1
  }
}

=item reset_hexcode_output_buffer()

Reset both the hex line output buffer and current byte counter

=cut

sub reset_hexcode_output_buffer
{
  $main::hexcode_line_buffer = HEX_TEMPLATE;
  $main::current_hexcode_line_buffer_byte = 1;
}

=item reset_ascii_output_buffer()

Reset both the hex line output buffer and current byte counter

=cut

sub reset_ascii_output_buffer
{
  $main::ascii_line_buffer = ASCII_TEMPLATE;
  $main::current_ascii_line_buffer_byte = 1;
}

=item reset_the_line()

Print and reset the hex line output buffer.

A unified reset of the line buffers (ascii and hex). 

Pass 1 to calculate start of line address (+8).
Pass 0 to use the address of the current assembler line to determine nearest mod 8.

=cut

sub reset_the_line
{
  my $do_calc = shift;

  do_the_print($main::hexcode_line_buffer, $main::address_SOL, $main::ascii_line_buffer);


  reset_ascii_output_buffer() if DO_ASCII_SHOW or $opt_a;     # Do in this order! -> #1
  reset_hexcode_output_buffer();                              # Do in this order! -> #1
  if ($do_calc){
    calc_next_address_SOL();                                  # Do in this order! -> #2
  } else {
    set_next_address_SOL($main::address);                     # Do in this order! -> #2
  }
}

=item set_next_address_SOL()

Set next start of line address, 
Get from address stated on current input line.
Work out the closest mod 8 line number.
This is the exceptional way to update the start of line number,
working from a broken sequence, 
using the address of the start of the new sequence.

=cut

sub set_next_address_SOL
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
  $main::current_hexcode_line_buffer_byte = $decimal_current_address - $decimal_first_factor_of_8 + 1;
}

=item do_the_string_thing()

Fill out the hex line output buffer
Replace the "x" place markers with the hex code for the bytes

=cut

sub do_the_string_thing
{
  my ( $num_byte, $current_hexcode_line_buf_byte, $hexcode_line_buf, $addr_SOL, $ascii_line_buf) = @_;

  for (my $index = 0; $index < $num_byte; $index++) {
    print "Buf: $main::hexcode_line_buffer   Ptr: $main::current_hexcode_line_buffer_byte  Idx: $main::array[$index] -> @main::array\n" if DEBUG or $opt_d;

    # Substitute the 2 digit hex number into the buffer,
    # at the correct location.
    # Convert to the global case being used
    # This ignores the case - don't use
    #substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = to_hex(hex($main::array[$index]));
    # This works!!!
    substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    # This should work but misses out random characters
    #substr($main::hexcode_line_buffer, ($current_hexcode_line_buf_byte-1)*2+(1*($current_hexcode_line_buf_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    # This will not work as hexcode_line_buf passed by value, not reference
    #substr($hexcode_line_buf, ($current_hexcode_line_buf_byte-1)*2+(1*($current_hexcode_line_buf_byte-1)), 2) = code_to_hex(hex($main::array[$index]));

    # Increment buffer pointer
    #$main::current_hexcode_line_buffer_byte = $main::current_hexcode_line_buffer_byte +1;
    $main::current_hexcode_line_buffer_byte++;
    # This will not work as current_hexcode_line_buf_byte passed by value, not reference
    #current_hexcode_line_buf_byte++ ;;

    # Call the ascii table filling routine
    # Should this be in main()???
    do_the_ascii_thing($main::array[$index]) if DO_ASCII_SHOW or $opt_a;

    # Check to see if pointer has reached end of line
    check_over_8($main::current_hexcode_line_buffer_byte, $main::hexcode_line_buffer, $main::address_SOL, $main::ascii_line_buffer);
    # Can not send $current_hexcode_line_buf_byte as...
    # ... $main::current_hexcode_line_buffer_byte has changed!
    #check_over_8($current_hexcode_line_buf_byte, $hexcode_line_buf, $addr_SOL, $ascii_line_buf);
  }
}

=item check_over_8()

Is the current line buffer byte over 8? 
If so, then new line.

=cut

sub check_over_8
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

sub calc_next_address_SOL
{
  my $next_address = hex($main::address_SOL) + 8;
  $main::address_SOL = address_to_hex($next_address);
}

=item address_div_8()

Is the hex address divisible by 8? 
If so, then new line.

=cut

sub address_div_8
{
  my $a = shift;

  #print $a =~ s/\\x([0-9a-fA-F]{2})/chr hex $1/gre;
  my $decimal = hex($a);

  return is_mod_8($decimal);
}


=item is_mod_8()

Is number divisible by 8?

=cut

sub is_mod_8 {
  # From https://stackoverflow.com/a/24944726/4424636
  my $number = shift;
  return not ($number % 8);   # Modulo arithmetic
}

=back

=cut

__END__

=head1 References:

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

=head1 Not used:

=pod

 From [this answer](https://stackoverflow.com/a/26386262/4424636):

=cut

=begin text  

if ( my ( $timestamp, $chnl, $page ) = m/(.*):.*solo_video_channel_write(.*): queueing page (.*).*/ ) {

=end text

=cut

##################################################################
#
# ### USAGE POD (start)
#
##################################################################

=head1 NAME

sample - Using Getopt::Long and Pod::Usage

=head1 SYNOPSIS

sample [options] [file ...]

 Options:
   -help            brief help message
   -man             full documentation

=head1 OPTIONS

=over 8

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and do something
useful with the contents thereof.

=cut

##################################################################
#
# ### USAGE POD (end)
#
##################################################################



##################################################################
#
# ### USAGE POD (start)
#
# For 'abcdhlmsuvwx' - short getopts
#
##################################################################

=head1 NAME

hexextrator - Extract a hex dump from assembly listing

=head1 SYNOPSIS

hexextrator [abcdhlmsuvwx] [file ...]

 Options:
   -a               show ASCII table
   -b               blank empty memory locations
   -c               show hex dump
   -d               debug mode
   -h               brief help message
   -l               show addresses
   -m               full documentation
   -s               add spaces between hex bytes of code
   -u               global uppercase
   -v               display version
   -w               uppercase addresses
   -x               uppercase code

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

=item B<-h>

Print a brief help message and exits.

=item B<-l>

Show addresses.

=item B<-m>

Prints the manual page and exits.

=item B<-s>

Add spaces between hex bytes of code.
Supress???

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

B<This program> will read the given input file(s) and do something
useful with the contents thereof.

=cut

##################################################################
#
# ### USAGE POD (end)
#
# For 'abcdhlmsuvwx' - short getopts
#
##################################################################


