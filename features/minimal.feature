@minimal
Feature: Testing examples/minimal

  Background:
    * Given command "crystal run examples/minimal.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-minimal.tmp"}'

  Scenario: -s
    * Given option "-s"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then long maps to nil
    * Then 1 maps to nil

  Scenario: --long
    * Given option "--long"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then long maps to true
    * Then s maps to nil
    * Then 1 maps to nil

  Scenario: -s --long
    * Given option "-s --long"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then long maps to true
    * Then 1 maps to nil

  Scenario: --long -s
    * Given option "--long -s"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then long maps to true
    * Then 1 maps to nil

  Scenario: --long=LONG
    * Given option "--long=LONG"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long => LONG
    * Then 1 maps to nil

  Scenario: argument
    * Given option "argument"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then 1 => argument

  Scenario: arguments
    * Given option "argument1 argument2"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then 1 => argument1
    * Then 2 => argument2

  Scenario: arguments
    * Given option "-s --long=LONG argument1 argument2"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then long => LONG
    * Then 1 => argument1
    * Then 2 => argument2

  # This just test the multiple short flags
  Scenario: -flags
    * Given option "-flags"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then f maps to true
    * Then l maps to true
    * Then a maps to true
    * Then g maps to true
    * Then s maps to true
