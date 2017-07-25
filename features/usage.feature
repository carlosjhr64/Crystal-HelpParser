@usage
Feature: Testing examples/usage

  Background:
    * Given command "crystal run examples/usage.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: a: abc
    * Given option "a: abc"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then 1 => a:
    * Then 2 => abc
    * Then a => abc

  Scenario: b: bee
    * Given option "b: bee"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then 1 => b:
    * Then 2 => bee
    * Then b => bee

  Scenario: q: ppp
    * Given option "q: ppp"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""
