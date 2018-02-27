@symple
Feature: Testing examples/exclusive

  Background:
    * Given command "crystal run examples/exclusive.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-exclusive.tmp"}'

  Scenario: -a -c
    * Given option "-a -c"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then a maps to true
    * Then c maps to true

  Scenario: -a -b
    * Given option "-a -b"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Exclusive keys:  a b"
    * Then stdout is ""

  Scenario: -c -d
    * Given option "-c -d"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Exclusive keys:  c d e"
    * Then stdout is ""

  Scenario: -e -d
    * Given option "-e -d"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Exclusive keys:  c d e"
    * Then stdout is ""
