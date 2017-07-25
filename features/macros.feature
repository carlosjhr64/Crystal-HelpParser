@macros
Feature: Testing examples/macros

  Background:
    * Given command "crystal run examples/macros.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: --age=5 --weight=7.25 dog a  b   c
    * Given option "--age=5 --weight=7.25 dog a   b    c"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "Pet: dog Age: 5 Weight: 7.25 More: a,b,c"

  Scenario: ints 1 2 3 4 5
    * Given option "ints 1 2 3 4 5"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "Many Total: 15"

  Scenario: floats 0.1 0.2 0.3 0.4 0.5
    * Given option "floats 0.1 0.2 0.3 0.4 0.5"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "Much Total: 1.5"
