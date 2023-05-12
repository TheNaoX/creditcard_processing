# Basic Credit Card Processing

## Programming Language Choice: Ruby

I chose ruby as the programming language for this code challenge, because it's the programming lanaguage in which I have the most experience and I enjoy working the most.

It's Object-Oriented implementation allows me to structure the code as business driven entities that will allow the program to execute while having a good design.

Additionally I chose RSpec for testing because its expressive driven DSL allows to write and organize tests very well by different context scenarios.

## Overview & Architecture

The code is organized similar to a traditional Ruby Project, with the `lib/` folder being where the source code exists, the `bin/` folder being where we define our executables and the `spec/` folder is where the tests live.

Within the `lib/` we defined the top-level namespace module called `CreditcardProcessing` which will encapsulate the and will serve as the namespace for the code that executes the different commands from the input.


### Storage

The project use in-memory storage for runtime operations, all the code related to how the storage is structured lives within the `storage/` namespace where we can find different types of objects.

**Repositories**

* `Accounts` - The repository where we add and get accounts by name
* `CreditCard` - The repository where we store and get the Account's CreditCard's


**Models**

* `Account` - Represents the entity of the account holder, at the moment its only its name
  * It has one `CreditCard` associated by `name`
* `CreditCard` - Represents the entity of a credit card, alongside with its balance and limit
  * It has the ability perform charges and credits on itself
  * It validates the `card_number` by calling the `CardValidator` which implements the Luhn 10 algorithm check

**Validators**

* `CardValidator` - Implements the Luhn 10 check and returns `true`/`false` for a given `card_number`

### Commands

The `commands/` folder





## How to Install

## How to run the program
