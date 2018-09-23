@simple
Feature: Testing examples/typos

  Background:
    * Given command "crystal run examples/typos.cr --"

  Scenario: --number OK
    * Given option "--number OK"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then number maps to true
    * Then n maps to true
    * Then string => OK

  Scenario: --number
    * Given option "--number"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."

  Scenario: --numba OK
    * Given option "--numba OK"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Unrecognized:  numba"

  Scenario: --ab
    * Given option "--ab"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Unrecognized:  ab"

  Scenario: --abc
    * Given option "--abc"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then abc maps to true
    * Then a maps to true
