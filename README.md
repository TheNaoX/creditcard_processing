# Basic Credit Card Processing

## Programming Language Choice: Ruby

I chose [Ruby](https://www.ruby-lang.org/en/) as the programming language for this code challenge because it's the programming lanaguage in which I have the most experience and I enjoy working the most.

It's Object-Oriented implementation allows me to structure the code as business driven entities that will allow the program to execute while having a good design.

Additionally I chose [RSpec](https://rspec.info/) for testing because its expressive driven DSL enables to write and descriptive tests.

## How to Install

**Pre-requisites**

Make sure you have installed Ruby 3.1.2, [official install guides](https://www.ruby-lang.org/en/documentation/installation/).

**Clone the Repository**

```
git clone https://github.com/TheNaoX/creditcard_processing.git
```

**Install the dependencies with**

```
bundle install
```

## How to run the program

The executable script lives in the `bin` directory, pass the name of the file as the first argument

```
bin/creditcard_processing input.txt
```

Or pass the contents of the file as STDIN as follows:


```
bin/creditcard_processing < input.txt
```

## Overview & Architecture

The code is organized similar to a traditional Ruby Project, with the `lib/` folder being where the source code exists, the `bin/` folder being where we define our executables and the `spec/` folder is where the tests live.

Within the `lib/` we defined the top-level namespace module called `CreditcardProcessing` which will encapsulate the and will serve as the namespace for the code that executes the different commands from the input.


### Storage

The project use in-memory storage for runtime operations, all the code related to how the storage is structured lives within the `storage/` namespace where we can find different types of objects.

**Repositories**

* `Repositories::Accounts` - The repository where we add and get accounts by name
* `Repositories::CreditCard` - The repository where we store and get the Account's CreditCard's


**Models**

* `Account` - Represents the entity of the account holder, at the moment its only its name
  * It has one `CreditCard` associated by `name`
* `CreditCard` - Represents the entity of a credit card, alongside with its balance and limit
  * It has the ability perform charges and credits on itself
  * It validates the `card_number` by calling the `CardValidator` which implements the Luhn 10 algorithm check
  * Upon charging, if the charge amount exceeds the `limit`, it will raise an exception to decline the transaction

**Validators**

* `CardValidator` - Implements the Luhn 10 check and returns `true`/`false` for a given `card_number`

### Commands

The `commands/` folder represents the commands that can be executing from the `input` stream/file provided to the program.

* `Add` - Performs the following steps for account creation
  * Create an `Account` record for the `Repositories::AccountsRepositories`
  * Create a `CreditCard` record for the `Repositories::CreditCardsRepositories`
* `Charge` - Finds an `Account` by name and charges its associated `CreditCard`
  * If an account does not have a credit card because it wasn't valid, it won't attempt to perform a charge
* `Credit` - Finds an `Account` and credits the associated `CreditCard`

These commands do not know how each operation is made, but rather act as a bridge between the input commands and `Account` and `CreditCard` entities that encapsulate the bussiness logic to _validate_, _charge_ and _credit_ the `Account`.

### Top-Level Namespace

* `Generator` - It receives a single command, detects the operating keyword (Add, Charge, Credit) and creates a `command` object with the values from the constructor to be executed by the caller.
* `Runner` - It receives the full text input, and iterates through every line and uses the `Generator` to generate each command to execute, and executes it.
* `Logger` - Standard ruby [Logger](https://ruby-doc.org/core-3.1.2/Logger.html) instance, so that we can use it to log different outputs during the execution process.

### Main Program

* `CreditcardProcessing` - acts as an interface for the CLI script
  * `#run` - receives the `input` and calls `Runner` to perform all the Credit Card transactions
  * `#accounts` - returns the list of `Accounts` from the repository, sorted by `name` ascending


### Executable Script

The script lives within the `bin` folder, and it's sole purpose is to manage IO and call the `CreditcardProcessing.run` method with the `input` to perform the transactions, and print every account's balance by calling the `CreditcardProcessing.accounts` method
