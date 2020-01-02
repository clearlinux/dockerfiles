HOSTNAME := $(shell hostname -f)
SUBDIR = $(shell ls -d */)

test_units := $(patsubst %/,%,$(SUBDIR))

all:
	@echo "use 'make tests' to run all tests'"
	@echo "use 'make TEST' to run individual test: ${test_units}"

.PHONY: $(test_units)
$(test_units): 
	cd $@; bats -t $@.bats; bats -t $@-security.bats

.NOTPARALLEL: tests
tests: $(test_units)
