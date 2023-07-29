# Asp.net WebAPI clean architecture

## Introduction

In Clean Architecture, as mentioned in the flutter md, the goal is to create a well-organized and maintainable software system by following separation of concerns and dependency inversion principles. So each layer will have its own responsibilities.

## Core Layer

In the core layer of ASP.NET Clean Architecture, we have the following components:

### Entities

Entities represent the business objects of the application. This is similar to that in the flutter app. Same objects are now represented as C# classes
These entities are at the heart of the business logic and are independent of any specific framework or infrastructure concerns.

### Abstraction of Repositories

The core layer defines interfaces for repositories. These repository interfaces act as contracts that specify the operations that can be performed on the entities. The core layer does not contain any implementation details of the repositories, allowing them to be implemented in the infrastructure layer.

### Implementation of Use Cases

Use cases are the application-specific requirements that represent various actions or operations that the application can perform. The core layer contains the implementation of these use cases, which orchestrate the interactions between entities and repositories to achieve specific goals.

## Infrastructure Layer

In the infrastructure layer of ASP.NET Clean Architecture, we have the following components:

### Implementation of Repositories

The infrastructure layer contains the actual implementations of the repository interfaces defined in the core layer. These implementations interact with data sources such as databases, web services, or file systems, to retrieve and persist data.

### Services

The infrastructure layer may also contain various services required for the application, such as email services, logging services (jwt authentication), or external integrations.

## Presentation Layer

The presentation layer is responsible for handling user interactions and rendering the user interface. In ASP.NET Clean Architecture, we typically use controllers as the entry point to the application. These controllers call the use cases defined in the core layer to process user requests and return appropriate responses.


## Example: Signup user

We have three types of users that can signup
All call the same API endpoint, but each has its own signup case.
Lets take the first type of user.


### Core Layer

#### Abstractions of Repos and Services:

``` C#
public interface GenrateToken{
    public String generateToken(String email);
    public String? checkTokenInfo(String email);
}
```

This service is responsible for creating and validating tokens

``` C#
public interface UserRepositoryInt{
    User.User? getUserByEmail(String email);
    User.User createUser(String name, String email, String number, String password, int userType);
}
```

These are some of the functions(not all are shown since we don't need them in this example) that the repo should implement.
It should check for a user with a given email and also create a user with data given.

#### Implementation of the usecase

``` C#
public AuthResult signupUser(UserForm data){
    if(_userRepo.getUserByEmail(email: data.Email) != null) return new AuthResult{Success = false};
    UserBaseForm user = _userRepo.createPerson(
            firstName: data.FirstName,
            lastName: data.LastName,
            email: data.Email,
            password: data.Password,
            number: data.Number,
            userType: data.UserType,
            isMale: data.IsMale,
            birthday: data.Birthday);
    String token = _generateToken.generateToken(data.Email);
    return new AuthResult{User = user, Success = true, Token = token};

}
```

This usecase has a repository(user repository) to check if an email is already registered and to create a user if not.
It also has a service(generate token service) which generates the authentication token required from the user to access
other API endpoints.


### Infrastructure Layer

This has the implementation for the previously mentioned abstract classes.

### Presentation Layer

The following function in the controller, first checks for the type of user we need to create then serializes the needed data to
send to the use case. The controller deals with the failure cases (which here are that the email is already registered), and it returns the suitable
response.

``` C#
[HttpPost("post")]
public IActionResult Register([FromBody] JsonElement json){
    int UserType = json.GetProperty("userType").GetInt32();
    string jsonString = json.ToString();
    AuthResult result;

    if(UserType == 1){
        GymForm data = JsonSerializer.Deserialize<GymForm>(jsonString)!;
        result = _loginUseCase.signup(data);
    }else if(UserType == 2){
        TrainerForm data = JsonSerializer.Deserialize<TrainerForm>(jsonString)!;
        result = _loginUseCase.signup(data);
    }else{
        UserForm data = JsonSerializer.Deserialize<UserForm>(jsonString)!;
        result = _loginUseCase.signup(data);
    }

    // email already exists in database
    if(!result.Success) return Conflict();

    return Ok(result);
}
```