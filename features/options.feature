@options
Feature: Testing examples/options

  Background:
    * Given command "crystal run examples/options.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is '{"0":"crystal-run-options.tmp"}'

  Scenario: -s
    * Given option "-s"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to true
    * Then long maps to nil
    * Then q maps to nil
    * Then quiet maps to nil
    * Then default maps to nil

  Scenario: --long
    * Given option "--long"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to true
    * Then q maps to nil
    * Then quiet maps to nil
    * Then default maps to nil

  Scenario: -q
    * Given option "-q"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then q maps to true
    * Then quiet maps to true
    * Then default maps to nil

  Scenario: --quiet
    * Given option "--quiet"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then q maps to true
    * Then quiet maps to true
    * Then default maps to nil

  Scenario: --quiet=please
    * Given option "--quiet=please"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then q maps to true
    * Then quiet => please
    * Then default maps to nil

  Scenario: --default
    * Given option "--default"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then q maps to nil
    * Then quiet maps to nil
    * Then default => ok

  Scenario: --default=maybe
    * Given option "--default=maybe"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then s maps to nil
    * Then long maps to nil
    * Then q maps to nil
    * Then quiet maps to nil
    * Then default => maybe

  Scenario: -w
    * Given option "-w"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then w maps to true
    * Then wut => WUT


  Scenario: --wut
    * Given option "--wut"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then w maps to true
    * Then wut => WUT


  Scenario: --wut=OK
    * Given option "--wut=OK"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then w maps to true
    * Then wut => OK
