# Flutter Clean Architecture

## Introduction

Flutter Clean Architecture emphasizes separation of concerns and maintainability in Flutter applications. It follows the SOLID principles (dependency injection and polymorphism) and aims to create a scalable and testable codebase. In this document, we'll explore the different layers of Clean Architecture and their roles and then follow up with examples.

## Layers

### 1. Data Layer

The Data Layer in Flutter Clean Architecture is responsible for managing data retrieval and data sources. It acts as an intermediary between the Domain Layer and external data sources, providing an abstract and clean API for the Domain Layer to interact with data without being aware of the specific data sources. Data could be gotten locally, or by an API endpoint; however, the domain layer has no idea where this data is coming from. Its only concern is that it gets the data it needs.

#### Models

Models in the Data Layer are simple classes that represent the business objects of the application (users-messages-chats...). They should contain only the essential properties and methods relevant to the application's business logic. Models should be independent of any data sources or external APIs.
They extend the entities adding methods to convert from and to JSON. 

#### Data Sources

Data Sources in the Data Layer are responsible for interacting with external APIs or databases to fetch and store data. They handle the network requests and transformations to convert the data from external sources into the apps Models. As mentioned before, there are different datasources like local and external APIs.

#### Repositories

Repositories in the Data Layer implement the abstract classes defined in the Domain Layer. They act as a bridge between the Data Layer and the Domain Layer, providing data to the Domain Layer without exposing the underlying data sources.

By organizing the Data Layer in this way, the business logic in the Domain Layer remains decoupled from the implementation details of the data sources. This separation allows for easier testing, maintenance, and scalability of the application. Additionally, if you need to change the data source (e.g., switching from a remote API to a local database), you can do so without affecting the rest of the application.


### 2. Domain Layer

The Domain Layer in Flutter Clean Architecture contains the core business logic of the application. It is responsible for defining the entities, repositories, and use cases that represent the application's specific needs.

#### Entities

Entities in the Domain Layer are pure Dart classes that represent the core business objects of the application. They encapsulate the state and behavior of these objects, allowing the application to work with them without being concerned about the underlying data sources or how they are stored.
Meaning the UI will handle these objects without concern about their data source.

#### Repositories

Repositories in the Domain Layer define the contracts (abstractions) that the actual repository implementations in the Data Layer must follow. They provide a clean and abstract API for the use cases to interact with data, without having any knowledge of the data sources themselves.

The use of repositories allows for separation of concerns, as the use cases do not need to be aware of the data source details. Dependency injection is used after the implementation of each repository. This makes testing easier and allows to easily change the implementation of a repository without affecting the app.

#### Use Cases

Use Cases in the Domain Layer represent specific application needs or user scenarios. They encapsulate the business logic for these use cases and orchestrate the interactions between entities and repositories.

Use Cases are app-specific and can represent various operations like authentication, data fetching, or data manipulation. They provide a way to implement specific features of the application in a clean and modular manner.

By organizing the Domain Layer in this way, the application's core logic remains independent of any specific data sources or user interfaces. This modularity enables the application to evolve and adapt to changes more easily.

The clean separation between the Domain Layer and Data Layer also enables the use of Dependency Injection, allowing for different implementations of repositories to be swapped out without affecting the Domain Layer's code.


### 3. Presentation Layer

The Presentation Layer in Flutter Clean Architecture is responsible for handling the User Interface (UI) and managing the interaction between the UI and the Domain Layer. It includes the UI components, such as widgets, pages, and screens, as well as the GetX controllers that handle state management and communicate with the Use Cases.

#### GetX Controllers

GetX Controllers in the Presentation Layer serve as the bridge between the UI and the Domain Layer. They manage the state of the UI, handle user interactions, and call the appropriate Use Cases from the Domain Layer to fetch or manipulate data. Note that any state management library can be used at this layer.

##### Use Cases Interaction

The GetX Controllers in the Presentation Layer interact with the Use Cases from the Domain Layer to request specific data or perform operations. For example, a GetX Controller for a user profile page might call the Use Case responsible for fetching user data from the repository.

By decoupling the Presentation Layer from the Use Cases and the Domain Layer, we achieve a high level of separation of concerns. This separation allows for easier testing, maintainability, and scalability of the application.

##### Handling Failures

In the Presentation Layer, it's crucial to handle various types of failures that can occur during data fetching or user interactions. Failures can include network errors, server errors, or validation errors.

In this project, we used a concept with functional programing where the usecase either returns a failutre of a certain type or a success type with the needed data. The presentation layer deals with all possible returning failures.

## Project Structure

### 1. Constants:

Contains the following:
 - Api endpoints which are the endpoints where we send our requests
 - routes which contains the application route names and structure
 - theme which has both a dark and light theme for the app

### 2. Core:

Which contains all three layers of the clean architecture that will be used more than once, they're common for many pages

### 3. Features:

Each feature (login - signup - sending messages - chats...) has its own three layers and their implementations

### 4. Dependency Injection:

In the injection.dart we inject all services and repositories with the needed implementations.


Lets check some examples for the [chat app with clean architecture](flutter-clean-examples.md)
