@symple
Feature: Testing examples/simple

  Background:
    * Given command "crystal run examples/simple.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-simple.tmp"}'

  Scenario: -sn ok good
    * Given option "-sn ok good"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then n maps to true
    * Then number => 1
    * Then args is [ok,good]

  Scenario: -q not good
    * Given option "-q not good"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: -s --long synonyms
    * Given option "-s --long"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Redundant:  s long"
    * Then stdout is ""
