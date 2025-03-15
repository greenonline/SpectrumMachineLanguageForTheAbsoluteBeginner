#!/usr/local/bin/perl -w


=head1 NAME

Hexextractor - Extract a hex dump from assembler listing

=head1 SYNOPSIS

    use My:: Hexextractor;
    my $object = My:: Hexextractor->new();
    print $object->as_string;

=head1 DESCRIPTION

Extracts a hex dump from assembler listing.

Written specifically for the full assembler/assembly listing of Freeway Frog (i.e. Frogger) from the book, Spectrum Machine Language for the Absolute Beginner, by William Tang (1982).

=cut

# ### Start of use 

use warnings;
use strict;

# ### End of use

# ### Start of globals

our $debug = 0;                             # Should be 0

our $address_SOL = "0000";                  # Address of start of hex buffer line
                                            # Always a factor of 8 (8 byte boundary)
our $template = "xx xx xx xx xx xx xx xx";  # Template of The boilerplate of the output
our $hexcode_line_buffer = $template;       # The boilerplate of the output
                                            # Insert hex over the xx
our $current_hexcode_line_buffer_byte = 1;  # Pointer to which byte in the buffer
                                            # From 1-8
our $address;                               # Address of current line read
our $hexcode_to_parse;                      # Hexcode of current line read
our $num_bytes;                             # Number of bytes of Hexcode in current line read
our @array;                                 # Will hold hex bytes of current line read

# ### End of globals

# ### End of main!

while(my $line = <>) {

  chomp $line;

  #if (/(?:^|\s)([0-9a-fA-F]{2}(?:\s|$))+/) {          # this only for <>
  #if ($line =~ /(?:^|\s)([0-9a-fA-F]{2}(?:\s|$))+/) { # picks every line!
  if ($line =~ /^\s*([0-9a-fA-F]{2}(?:\s|$))+/) {

    # Get the standard hex listing with address and hexcode 
    # Do the grep for a string of double digit hex numbers seperated by space

    print $line."\n" if $debug;
    my $this_line_of_hexcode = $line;
    # Remove any spaces
    $this_line_of_hexcode =~ s/ //g;
    # get number of bytes
    $num_bytes = length($this_line_of_hexcode)/2;
    print "$this_line_of_hexcode -> $num_bytes\n" if $main::debug;
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
      print  "Address: $address     Hex: $this_line_of_hexcode   # bytes: $num_bytes\n" if $debug;
      for(my $i = 0; $i < $num_bytes; ++$i) {
        print $array[$i]." " if $debug;
      }
      print "\n" if $debug;

      # Is address divisible by 8?
      # If so, assign to address_SOL and flag to print
      if (address_div_8($address)){
        reset_the_line();
      } else {
        # Check here for sudden address change
        check_for_address_change();
      }
      do_the_string_thing();
    }
  }
}
do_the_print();

# ### End of main!

=head1 SUBROUTINES

=over

=item to_hex()

Returns hex value of decimal.

=cut

sub to_hex
{
  my $num =shift;

  return sprintf '%X', $num;

}

=item check_for_address_change_simple()

Checks for drastic address change.
Simple version - logic does not work. Hex conversion issue?

=cut

sub check_for_address_change_simple
{
  # Check here for sudden address change
  if (hex($address) > (hex($address_SOL)+8) || hex($address) < hex($address_SOL)) {
    reset_the_line();
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
  print "tmp_addr: $tmp_address  :::: tmp_addr_SOL:  $tmp_address_SOL\n" if $main::debug;
  # Check to see if current address is out the line
  # ... i.e. out of the range of 8 addresses for this line
  if (($tmp_address > $tmp_address_SOL+8) || ($tmp_address < $tmp_address_SOL)) {
    reset_the_line();
  }
  # Check to see if current address is contiguous
  # ... i.e. follows the previous
  #if($main::address <> $main::address_SOL + $main::current_hexcode_line_buffer_byte ) {
  elsif($tmp_address != $tmp_address_SOL + $main::current_hexcode_line_buffer_byte - 1 ) {
    $main::current_hexcode_line_buffer_byte = $tmp_address - $tmp_address_SOL + 1;
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
  if (not $main::hexcode_line_buffer eq $template){
    blank_any_x();
    print "$main::address_SOL: $main::hexcode_line_buffer\n";
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
  $main::hexcode_line_buffer = $template;
  $main::current_hexcode_line_buffer_byte = 1;
}

=item reset_the_line()

Print and reset the hex line output buffer

=cut

sub reset_the_line
{
  do_the_print();

  # Reset the line
  reset_hexcode_output_buffer();   # Do in this order! -> #1
  set_next_address_SOL();          # Do in this order! -> #2
  #reset_hexcode_output_buffer();  # this resets any special byte pointer calcs.
}

=item set_next_address_SOL()

Set next start of line address, 
Get from address stated on current line

=cut

sub set_next_address_SOL
{
  # Find the first factor of 8 below current address
  my $first_factor_of_8 = $main::address;

  my $temp_first_factor_of_8 = hex($first_factor_of_8);

  while (not is_mod_8($temp_first_factor_of_8)) {
    $temp_first_factor_of_8--;
    $first_factor_of_8 = to_hex($temp_first_factor_of_8);
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
    print "$main::hexcode_line_buffer   :::  $main::current_hexcode_line_buffer_byte  :: $main::array[$index] -> @main::array\n" if $main::debug;
    substr($main::hexcode_line_buffer, ($main::current_hexcode_line_buffer_byte-1)*2+(1*($main::current_hexcode_line_buffer_byte-1)), 2) = $main::array[$index];
    $main::current_hexcode_line_buffer_byte = $main::current_hexcode_line_buffer_byte +1;
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

    reset_hexcode_output_buffer();   # Do in this order! -> #1
    calc_next_address_SOL();         # Do in this order! -> #2
  }
}

=item calc_next_address_SOL()

Calculate next start of line address, 

=cut

sub calc_next_address_SOL
{
  my $next_address = hex($main::address_SOL) + 8;
  $main::address_SOL = to_hex($next_address);
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


