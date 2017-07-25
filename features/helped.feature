@helped
Feature: Testing examples/helped

  Background:
    * Given command "crystal run examples/helped.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-helped.tmp"}'

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
    * Then v maps to true

  Scenario: --version=Absent
    * Given option "--version=Absent"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then version => Absent
