@versioned_helped
Feature: Testing examples/versioned_helped

  Background:
    * Given command "crystal run examples/versioned_helped.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-versioned_helped.tmp"}'

  Scenario: -h
    * Given option "-h"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '### The Help ###'

  Scenario: --help
    * Given option "--help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '### The Help ###'

  Scenario: -v
    * Given option "-v"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '1.2.3'

  Scenario: --version=Absent
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '1.2.3'
