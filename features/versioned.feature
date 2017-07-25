@versioned
Feature: Testing examples/versioned

  Background:
    * Given command "crystal run examples/versioned.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-versioned.tmp"}'

  Scenario: -v
    * Given option "-v"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '1.2.3'

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '1.2.3'

  Scenario: -h
    * Given option "-h"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then h maps to true

  Scenario: --help=Absent
    * Given option "--help=Absent"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then help => Absent
