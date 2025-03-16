#!/usr/local/bin/perl -w


=head1 NAME

Hexextractor - Extract a hex dump from assembler listing

=head1 SYNOPSIS

    cat freeway_frog_full.asm | perl hexextractor.pl

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

=cut

# ### Start of use 

use warnings;
use strict;

# ### End of use

# ### Start of globals

use constant {
    DEBUG => 0,                             # Should be 0

    DO_ASCII => 1,                          # Enable additional ascii character dump
    DO_CAPS => 1,                           # Enable upper case hex
    DO_ADDRESS => 1,                        # Enable upper case hex for addresses
    DO_CODE => 1,                           # Enable upper case hex for code
    MOD_8 => 0,                             # Find nearest lowest mod 8 address
    ADD_8 => 1,                             # Increment address by 8

    HEX_TEMPLATE => "xx xx xx xx xx xx xx xx", 
                                            # Boilerplate of the output
    ASCII_TEMPLATE => "........",           # Boilerplate of the ascii output
};

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

# ### End of globals

# ### End of main!

while(my $line = <>) {

  chomp $line;

  if ($line =~ /^\s*([0-9a-fA-F]{2}(?:\s|$))+/) {

    # Get the standard hex listing with address and hexcode 
    # Do the grep for a string of double digit hex numbers seperated by space

    print $line."\n" if DEBUG;
    my $this_line_of_hexcode = $line;
    # Remove any spaces
    $this_line_of_hexcode =~ s/ //g;
    # get number of bytes
    $num_bytes = length($this_line_of_hexcode)/2;
    print "$this_line_of_hexcode -> $num_bytes\n" if DEBUG;
    # get the bytes
    $hexcode_to_parse = $this_line_of_hexcode;

    parse_the_hex();
    do_the_string_thing();
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

      parse_the_hex();

      if (DEBUG) {
        print  "Addr: $address  Hex: $this_line_of_hexcode  # bytes: $num_bytes\n";
        for(my $i = 0; $i < $num_bytes; ++$i) {
          print $array[$i]." ";
        }
        print "\n";
      }

      # Is address divisible by 8?
      # If so, assign to address_SOL and flag to print
      if (address_div_8($address)){
        reset_the_lines(MOD_8);
      } else {
        # Check here for sudden address change
        check_for_address_change();
      }
      do_the_string_thing();
    }
  }
}
do_the_print();

exit 0;

# ### End of main!

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

  if (DO_CAPS) {
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

  if (DO_CAPS and DO_ADDRESS) {
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

  if (DO_CAPS and DO_CODE) {
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
    reset_the_lines(MOD_8);
  }
}

=item check_for_address_change()

Checks for drastic address change

=cut

sub check_for_address_change
{
  # Check here for sudden address change
  my $tmp_address = hex($main::address);
  my $tmp_address_SOL = hex($main::address_SOL);
  print "tmp_addr: $tmp_address  :::: tmp_addr_SOL:  $tmp_address_SOL\n" if DEBUG;
  # Check to see if current address is out the line
  # ... i.e. out of the range of 8 addresses for this line
  if (($tmp_address > $tmp_address_SOL+8) || ($tmp_address < $tmp_address_SOL)) {
    reset_the_lines(MOD_8);
  }
  # Check to see if current address is contiguous
  # ... i.e. follows the previous
  #if($main::address <> $main::address_SOL + $main::current_hexcode_line_buffer_byte ) {
  elsif($tmp_address != $tmp_address_SOL + $main::current_hexcode_line_buffer_byte - 1 ) {
    $main::current_hexcode_line_buffer_byte = $tmp_address - $tmp_address_SOL + 1;
    $main::current_ascii_line_buffer_byte = $tmp_address - $tmp_address_SOL + 1 if DO_ASCII;
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
  # Print previous line (if not totally blank)
  if (not $main::hexcode_line_buffer eq HEX_TEMPLATE){
    blank_any_x();
    if (not DO_ASCII) {
      print "$main::address_SOL: $main::hexcode_line_buffer\n";
    } else {
      print "$main::address_SOL: $main::hexcode_line_buffer  $main::ascii_line_buffer\n";
      #print "$main::address_SOL: $main::hexcode_line_buffer  ".print_ascii_line()."\n";
    }
  }
}

=item parse_the_hex()

Parse the current line's hex code block and extract the bytes into @array

=cut

sub parse_the_hex
{
  for(my $i = 0; $i < $main::num_bytes; ++$i) {
    # from https://stackoverflow.com/a/19502459/4424636
    $main::array[$i] = substr($main::hexcode_to_parse, 0, 2);    # returns the string before 2
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

=item reset_the_lines()

Print and reset the hex line output buffer.

A unified reset of the line buffers (ascii and hex). 

Pass 1 to calculate start of line address (+8).
Pass 0 to use the address of the current assembler line to determine nearest mod 8.

=cut

sub reset_the_lines
{
  my $do_calc = shift;
  reset_ascii_output_buffer() if DO_ASCII;     # Do in this order! -> #1
  reset_hexcode_output_buffer();   # Do in this order! -> #1
  if ($do_calc){
    calc_next_address_SOL();         # Do in this order! -> #2
  } else {
    set_next_address_SOL();          # Do in this order! -> #2
  }
}

=item set_next_address_SOL()

Set next start of line address, 
Get from address stated on current line.
Work out the closest mod 8 line number.
This is the exceptional way to update the start of line number,
working from a broken sequence, 
using the address of the start of the new sequence.

=cut

sub set_next_address_SOL
{
  # Find the first factor of 8 below current address
  # Convert to the global case being used
  #my $first_factor_of_8 = to_hex(hex($main::address));
  my $first_factor_of_8 = address_to_hex(hex($main::address));

  my $temp_first_factor_of_8 = hex($first_factor_of_8);

  while (not is_mod_8($temp_first_factor_of_8)) {
    $temp_first_factor_of_8--;
    #$first_factor_of_8 = to_hex($temp_first_factor_of_8);
    $first_factor_of_8 = address_to_hex($temp_first_factor_of_8);
  }

  $main::address_SOL = $first_factor_of_8;
  my $temp_address = hex($main::address);
  #$main::current_hexcode_line_buffer_byte = hex($main::address) - $temp_first_factor_of_8;
  $main::current_hexcode_line_buffer_byte = $temp_address - $temp_first_factor_of_8 + 1;

  # Original method - wrong address at start of line
  #$main::address_SOL = $main::address;
}

=item do_the_string_thing()

Fill out the hex line output buffer
Replace the "x" place markers with the hex code for the bytes

=cut

sub do_the_string_thing
{
  for (my $index = 0; $index < $main::num_bytes; $index++) {
    print "$main::hexcode_line_buffer   :::  $main::current_hexcode_line_buffer_byte  :: $main::array[$index] -> @main::array\n" if DEBUG;

    # Substitute the 2 digit hex number into the buffer,
    # at the correct location.
    # Convert to the global case being used
    #substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = to_hex(hex($main::array[$index]));
    substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = code_to_hex(hex($main::array[$index]));
    $main::current_hexcode_line_buffer_byte = $main::current_hexcode_line_buffer_byte +1;

    do_the_ascii_thing($main::array[$index]) if DO_ASCII;

    check_over_8();
  }
}

=item check_over_8()

Is the current line buffer byte over 8? 
If so, then new line.

=cut

sub check_over_8
{
  if ($main::current_hexcode_line_buffer_byte > 8) {
    do_the_print();

    # Reset the line
    reset_the_lines(ADD_8);
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
  #$main::address_SOL = to_hex($next_address);
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


