Contributing Guidelines
=======================

Principle of the test cases
----------------------------

Focusing on basic tests on docker environment, may covering below:
* Quick and light, not performance test
* Check the basic functionality
* Check the ports exported
* Check the parameters passed could be recognized
* Check the ownership permission if necessary
* No dependencies for each test cases

One note of the "no dependencies" means it is suggested to keep the
container lifecycle within each test case. This could be done through
either of the way:
* Start the container, do something, stop/close the container in each
test case.
* use BAT "setup" and "teardown" hooks.

How to add test cases
------------------------------------

The test cases are for the micro services already added in the Actions CI.
So for any micro service name defined in the matrix.node of .github/workflows/
tests.yml, the same name directory could be added in the directory "tests".
And the same name BAT script in the new added directory will be executed for
each PR/commits. For example, redis.
* First, the redis name is added in the matrix.node.
```
   matrix:
     node: ["redis"]
```

* Second, create the "redis" directory and BAT script under tests
```
   dockerfiles
    └── tests
        └── redis
            └── redis.bats
```

* Last, develop the redis BAT test cases in "redis.bats" following the above
principles.
