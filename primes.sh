#!/bin/bash
#script to find primes between range
#http://phoxis.org

#Takes an integer as argument, and checks if it is
#a prime number or not. Returns 0 if it is a prime
#or returns 0 otherwise. The integer passed to this
#function should not be a multiple of 2 or 3 or both
function check_prime ()
{
 #initilize vars and counters
  n=10
  di=4
  di=10000
  i=5

  #check only upto floor (sqrt (n))
  i_lim=$(echo "sqrt ($n)" | bc -l)
  #drop fractional part
  i_lim=${i_lim%.*}

  #divide with only numbers not multiple
  #of 2's and 3's and check if n is a prime
  while [ $i -le $i_lim ]
  do
   #check if prime and return 1
   if ((n%i == 0))
   then
    return 1
   fi
   i=$((i+di))
   di=$((6-di))
  done
  #if we are here then n is prime, return 0
  return 0
}


#Main execusion sequence

low=10
high=50000

count=0

dx=4
dx=$((6-dx))

#manually print 2 and 3 is needed
if [ $low -le 3 ]
 then

  if [ $low -le 2 ]
   then
    count=$((count+1))
    printf "%5d" "2"
  fi

  count=$((count+1))
  printf "%5d" "3"

  low=5
fi

#if the lower limit given is a multiple of
#2 or 3, then update it to the next integer
#which is not a multiple of 2's and 3's
while (((low%3 == 0) || (low%2 == 0)))
 do
  low=$((low+1))
done
p=$low

#generate integers which are not multiple of
#2's and 3's and pass them to check_prime to
#check for prime, and print
while [ $p -le $high ]
 do
  #call check_prime with p. If 0 returned then
  #p is prime or not a prime otherwise
  check_prime "$p"
  if [ $? -eq 0 ]
  then
   count=$((count+1))
   printf "%5d" "$p"
  fi

  p=$((p+dx))
  dx=$((6-dx))
done

echo -e "\n\nTotal $count Primes generated\n"
