@readme
Feature: Testing examples/readme

  Background:
    * Given command "crystal run examples/readme.cr --"

  Scenario: Plain
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Please match usage."
    * Then stdout is ""

  Scenario: -v
    * Given option "-v"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "5.1.1"

  Scenario: --version
    * Given option "--version"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then stdout is "5.1.1"

  Scenario: -h
    * Given option "-h"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "The Awesome Command."

  Scenario: --help
    * Given option "--help"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then header is "The Awesome Command."

  Scenario: First Usage
  # hash # => {0_u8 => "awesome",
  #            's' => true,
  #            "name" => "Joe",
  #            'a' => true,
  #            1_u8 => "one",
  #            2_u8 => "two",
  #            3_u8 => "three",
  #            "args" => ["one", "two", "three"],
  #            "long" => true,
  #            "number" => "5",
  #            "value" => "1.23",
  #            "all" => "y"}
  # options.name # => "Joe"
  # options.args # => ["one", "two", "three"]
  # options.value # => 1.23
  # options.number? # => 5
  # options.bool? # => false
  # options.b? # => false
    * Given option "-s --name=Joe --number --value -a one two three"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "7d1ef3d365cd15f5281d816eccd0227f"

  Scenario: Second Usage
  # hash # => {0_u8 => "awesome", 'V' => true, 1_u8 => "Joe", "arg" => "Joe"}
  # options.number? # => nil
  # options.bool? # => false
  # options.b? # => false
    * Given option "-V Joe"
    * When we run command
    * Then exit status is "0"
    * Then stderr is ""
    * Then digest is "ad6bbb25406605edd7c1c8a836d082b2"

  Scenario: -s --long synonyms
    * Given option "-s --long synonyms"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Redundant:  s long"
    * Then stdout is ""

  Scenario: --name=joe uncapped name
    * Given option "--name=joe uncapped name"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "--name=joe !~ NAME=/^[A-Z][a-z]+$/"
    * Then stdout is ""

  Scenario: --name missing
    * Given option "--name missing"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "--name !~ NAME=/^[A-Z][a-z]+$/"
    * Then stdout is ""

  Scenario: --number=BAD number
    * Given option "--number=BAD number"
    * When we run command
    * Then exit status is "64"
    * Then stderr is "Not an Integer:  number"
