@typed_options
Feature: Testing examples/typed_options

  Background:
    * Given command "crystal run examples/typed_options.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-typed_options.tmp"}'

  Scenario: --float
    * Given option "--float"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Need a FLOAT: float"
    * Then stdout is ""

  Scenario: --float=1.23
    * Given option "--float=1.23"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then float => 1.23

  Scenario: --number=1.23
    * Given option "--number=1.23"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Not a NUMBER: number"
    * Then stdout is ""

  Scenario: --number=456
    * Given option "--number=456"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then number => 456

  Scenario: --number
    * Given option "--number"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then number => 123

  Scenario: --name
    * Given option "--name"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then name => Guy
    * Then n maps to true

  Scenario: -n
    * Given option "-n"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then name => Guy
    * Then n maps to true

  Scenario: --name=Gal
    * Given option "--name=Gal"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then name => Gal
    * Then n maps to true
