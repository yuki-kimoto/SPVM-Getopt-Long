package SPVM::Getopt::Long;

our $VERSION = "0.001";

1;

=head1 Name

SPVM::Getopt::Long - Parsing Command Line Options

=head1 Description

The Getopt::Long class of L<SPVM> has methods to parse command line options.

=head1 Usage

  use Getopt::Long;
  use Hash;
  
  my $argv = CommandLineInfo->ARGV;
  
  my $values_h = Hash->new(
    data => "file.dat",
    length => 24,
    verbose => 0,
    numbers => new Int[0],
  );
  
  my $rule_strings = [
    "length=i",
    "file=s",
    "verbose"
    "number=i@",
  ];
  
  $argv = Getopt::Long->GetOptions($argv, $values_h, $rule_strings);

=head1 Class Methods

=head2 GetOptionsFromArray

C<static method GetOptionsFromArray : string[] ($argv : string[], $values_h : Hash, $rule_strings : string[]);>

Parses command line options $argv using the rules $rule_strings.

In arguments $argv, a string starting with C<--> or C<-> is interpreted as the start of an option name.

If the option name contains C<=>, the string after C<=> is the value of the option in the string, L<Int|SPVM::Int>, L<Double|SPVM::Double> types.

If the option name do not contains C<=>, the next string of $argv is the value of the option in the string, L<Int|SPVM::Int>, L<Double|SPVM::Double> types.

If C<@> is not given in the rule, the parsed value is set to $values_h with the primary option name.

If C<@> is given in the rule, the parsed value is added to $values_h with the primary option name at the end.

And returns a new command line arguments that parsed command line arguments are removed.

Rule Syntax (defined by yacc syntax):

  rule_string
    : option_names
    | option_names '=' type
    | option_names '=' type is_array
  
  options_names
    : options_names '|' option_name
    | option_name
  
  option_name
    : \w+
  
  is_array
    : '@'
  
  type
    : 's'
    | 'i'
    | 'f'

The first name of C<option_names> is the primary option name.

The type C<s> means the string type.

The type C<i> means the L<Int|SPVM::Int> type.

The type C<f> means the L<Double|SPVM::Double> type.

If a type is not given, the type is a boolean type. The set value is an L<Int|SPVM::Int> object with the value field set to 1.

Rule aExamples:
  
  "type=s"
  
  "length=i"
  
  "timeout=f"
  
  "length|l"
  
  "numbers=i@"

Command Line Arguments Examples:

  perl test.pl type=big --length=3 --verbose -l=6 --timeout=0.5 --numbers 3 --numbers 5

Note:

The case of option names is not ignored. C<--foo> is different from C<--FOO>.

Abbreviated names and full names are different. C<--foo> is different from C<--fo>.

The differnt order of options is differnt each other. C<--foo arg1 --bar arg2 arg3> is different from C<--foo --bar arg1 arg2 arg3>.

The C<--name=value> syntax is available. C<--foo=value> is the same as C<--foo value>.

=head1 Repository

L<SPVM::Getopt::Long - Github|https://github.com/yuki-kimoto/SPVM-Getopt-Long>

=head1 Author

Yuki Kimoto C<kimoto.yuki@gmail.com>

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License

