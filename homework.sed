# Name: YOUR NAME
# Date: Month Day, Year

# Programming Paradigms
# Regular Expression Primer

# Put each of your regular expressions under the headings below.  The file
# input.txt will be used for grading.  Your script should produce the same
# output as you see in output.txt.  You may test your script using sed:
# $ sed -n -E -f homework.sed input.txt
# Note that question 1 is already answered for you as an example.

# question 1
/do+g/p

# question 2
sed -En '/(cat){5,7}/p' input.txt

# question 3
sed -En '/^(cat)/p' input.txt

# question 4
sed -En '/[^a-zA-Z\d\s:]*(mouse)[^a-zA-Z\s]*/p' input.txt

# question 5
sed -En 's/coward/hero/p' input.txt

# question 6
sed -En '/^[[:alpha:]]+\s\(?[[:digit:]]/p' input.txt
