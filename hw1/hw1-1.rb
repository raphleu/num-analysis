/%
The reason this breaks is that ruby stores big numbers with more precision.
This is similar to the BigInteger class of Java, but doesn't require importation.

The float loses precision (even though Ruby stores float with double precision)
so it's unable to capture the entire number in a float.

Our assumption is x+3 mod x should be greater than zero since x+3 is greater than x.
%/

x=10000000000000000000000

puts (x.to_f + 3) % x

puts (x + 3) % x