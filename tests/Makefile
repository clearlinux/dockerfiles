HOSTNAME := $(shell hostname -f)
SUBDIR = $(shell ls -d */)

test_units := $(patsubst %/,%,$(SUBDIR))

all:
	@echo "use 'make tests' to run all tests'"
	@echo "use 'make TEST' to run individual test: ${test_units}"

.PHONY: $(test_units)
$(test_units): 
	sh exec.sh $@

.NOTPARALLEL: tests
tests: $(test_units)
