#!/usr/bin/env bats
# *-*- Mode: sh; c-basic-offset: 8; indent-tabs-mode: nil -*-*

load ../utils

#
# * Array search and substitution
#
@test "array search and substitution" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "echo Lorem | ruby testcase/arraysearchandsubstitute.rb | grep REDACTED"
}

#
# * Attribute accessor
#
@test "attribute accessor" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/attaccessor.rb | grep Dennis"
}

#
# * Call lamda
#
@test "call lamda" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/calllambda.rb
}

#
# * Case statement
#
@test "case statement" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "echo English | ruby testcase/casestatement.rb | grep Hello!"
}

#
# * Class Account
#
@test "class acount" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/classaccount.rb
}

#
# * Class inheritance
#
@test "class inheritance" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/classinheritance.rb | grep Meow"
}

#
# * Basic Class
#
@test "basi class" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/class.rb
}

#
# * Static functions
#
@test "static functions" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/classscopemethodfunction.rb | grep -E 'eric.*you'"
}

#
# * Code Block
#
@test "code block" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/codeblock.rb
}

#
# * Collect Method
#
@test "collect method" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/collectmethod.rb | grep -E '*\!$'"
}

#
# * Convert string to symbols
#
@test "convert string to symbols" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/convertstringstosymbols.rb
}

#
# * Convert symbol to string
#
@test "convert symbol to string" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/convertsymbolstostrings.rb | grep 'hello world'"
}

#
# * Private global variable 
#
@test "private global variable" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/globalprivatevariable.rb &>/dev/stdout | grep 'private method'"
}

#
# * Hash Histogram
#
@test "hash histogram" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "echo 'this is a test of the test' | ruby testcase/hashhistogram.rb"
}

#
# * Hash Iteration
#
@test "hash iteration" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/hashiteration.rb
}

#
# * Hash lockup symbol vs string
#
@test "hash lockup symbol vs string" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/hashlookupsymbolvsstring.rb
}

#
# * Include
#
@test "include" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/include.rb
}

#
# * Lamda method sort
#
@test "lamda method sort" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/lambdamethodsort.rb
}

#
# * Method Capitalize
#
@test "method capitalize" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/methodcapitalize.rb | grep -vE '^(r|j)'"
}

#
# * Method Greeter
#
@test "method greeter" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/methodgreeter.rb | grep 'hello jared nice to meet you!'"
}

#
# * Prime number calculator
#
@test "method greeter" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/methodprimenumbercalculator.rb
}

#
# * Module
#
@test "module" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/modules.rb
}

#
# * Module
#
@test "module" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/multipleinheritance.rb
}

#
# * Private Method
#
@test "private method" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "ruby testcase/privatemethod.rb &> /dev/stdout | grep 'private method'"
}

#
# * Procedure
#
@test "Procedure" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/procs.rb
}

#
# * Selective Hash
#
@test "selective hash" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/selectivehash.rb
}

#
# * Sort and organize array
#
@test "sort and organize array" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/sortandorganizearray.rb
}

#
# * Sort array by alphabet
#
@test "sort array by alphabet" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/soryarraybyalphabet.rb
}

#
# * String interpolation
#
@test "string interpolation" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/stringinterpolation.rb
}

#
# * String interpolation
#
@test "string interpolation" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby bash -c "echo 'this what it is' | ruby testcase/substituion.rb | grep -v 's'"
}

#
# * Variable scope
#
@test "variable scope" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/variablescope.rb
}

#
# * Variable scope
#
@test "variable scope" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/variablescope.rb
}

#
# * Virtual computer (scope variables)
#
@test "virtual computer (scope variables)" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/virtualcomputer.rb
}

#
# * Yield block lamda
#
@test "yeald block lamda" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/yieldblocklambda.rb
}

#
# * Yielding with parameters
#
@test "yealding with parameters" {
    docker run --rm -v "$PWD":/src -w /src clearlinux/ruby ruby testcase/yieldingwithparameters.rb
}

