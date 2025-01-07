# Clear Linux Containers Unit test and Security test

These are the collections of the Clear Linux Containers Unit test and Security test.
The Unit tests and Security tests are implementing by separate [BATS](https://github.com/sstephenson/bats) scripts.
Both Unit test and Security test will be run as a part of CI pre-test before the corresponding dockerfiles submit. 
The dockerfiles are from [page](https://github.com/clearlinux/dockerfiles). The CI is hosting in [github actions](https://github.com/clearlinux/dockerfiles/blob/master/.github/workflows/test.yml).

To run the tests, you can simple type "make tests", it will run all the test cases.
If you want to run specific Container test, just type "make SERVICE-NAME".
For example, "make valkey" to run tests for valkey.


