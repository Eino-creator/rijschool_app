# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetCourseCosts
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.getCourseCosts().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetCourseCostsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getCourseCosts();
GetCourseCostsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.getCourseCosts().ref();
ref.execute();

ref.subscribe(...);
```


### GetLesson
#### Required Arguments
```dart
String id = ...;
ConnectorConnector.instance.getLesson(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetLessonData, GetLessonVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getLesson(
  id: id,
);
GetLessonData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ConnectorConnector.instance.getLesson(
  id: id,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetLessonsByDay
#### Required Arguments
```dart
Timestamp startDate = ...;
Timestamp endDate = ...;
ConnectorConnector.instance.getLessonsByDay(
  startDate: startDate,
  endDate: endDate,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetLessonsByDayData, GetLessonsByDayVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getLessonsByDay(
  startDate: startDate,
  endDate: endDate,
);
GetLessonsByDayData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
Timestamp startDate = ...;
Timestamp endDate = ...;

final ref = ConnectorConnector.instance.getLessonsByDay(
  startDate: startDate,
  endDate: endDate,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetLessonsByPupil
#### Required Arguments
```dart
String pupilID = ...;
ConnectorConnector.instance.getLessonsByPupil(
  pupilID: pupilID,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetLessonsByPupilData, GetLessonsByPupilVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getLessonsByPupil(
  pupilID: pupilID,
);
GetLessonsByPupilData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String pupilID = ...;

final ref = ConnectorConnector.instance.getLessonsByPupil(
  pupilID: pupilID,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetPupils
#### Required Arguments
```dart
// No required arguments
ConnectorConnector.instance.getPupils().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetPupilsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getPupils();
GetPupilsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ConnectorConnector.instance.getPupils().ref();
ref.execute();

ref.subscribe(...);
```


### GetPupil
#### Required Arguments
```dart
String userId = ...;
ConnectorConnector.instance.getPupil(
  userId: userId,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetPupilData, GetPupilVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getPupil(
  userId: userId,
);
GetPupilData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String userId = ...;

final ref = ConnectorConnector.instance.getPupil(
  userId: userId,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetMyRole
#### Required Arguments
```dart
String firebaseUid = ...;
ConnectorConnector.instance.getMyRole(
  firebaseUid: firebaseUid,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyRoleData, GetMyRoleVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getMyRole(
  firebaseUid: firebaseUid,
);
GetMyRoleData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String firebaseUid = ...;

final ref = ConnectorConnector.instance.getMyRole(
  firebaseUid: firebaseUid,
).ref();
ref.execute();

ref.subscribe(...);
```


### GetMyUserId
#### Required Arguments
```dart
String firebaseUid = ...;
ConnectorConnector.instance.getMyUserId(
  firebaseUid: firebaseUid,
).execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyUserIdData, GetMyUserIdVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ConnectorConnector.instance.getMyUserId(
  firebaseUid: firebaseUid,
);
GetMyUserIdData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String firebaseUid = ...;

final ref = ConnectorConnector.instance.getMyUserId(
  firebaseUid: firebaseUid,
).ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### EditCourseCosts
#### Required Arguments
```dart
String id = ...;
int lessonTime = ...;
double lessonPrice = ...;
double registrationFee = ...;
double selfDeclaration = ...;
double brokerageFees = ...;
double examCarUsage = ...;
ConnectorConnector.instance.editCourseCosts(
  id: id,
  lessonTime: lessonTime,
  lessonPrice: lessonPrice,
  registrationFee: registrationFee,
  selfDeclaration: selfDeclaration,
  brokerageFees: brokerageFees,
  examCarUsage: examCarUsage,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<EditCourseCostsData, EditCourseCostsVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.editCourseCosts(
  id: id,
  lessonTime: lessonTime,
  lessonPrice: lessonPrice,
  registrationFee: registrationFee,
  selfDeclaration: selfDeclaration,
  brokerageFees: brokerageFees,
  examCarUsage: examCarUsage,
);
EditCourseCostsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
int lessonTime = ...;
double lessonPrice = ...;
double registrationFee = ...;
double selfDeclaration = ...;
double brokerageFees = ...;
double examCarUsage = ...;

final ref = ConnectorConnector.instance.editCourseCosts(
  id: id,
  lessonTime: lessonTime,
  lessonPrice: lessonPrice,
  registrationFee: registrationFee,
  selfDeclaration: selfDeclaration,
  brokerageFees: brokerageFees,
  examCarUsage: examCarUsage,
).ref();
ref.execute();
```


### CreateNewLesson
#### Required Arguments
```dart
Timestamp date = ...;
Timestamp endDate = ...;
double cost = ...;
String pupilId = ...;
ConnectorConnector.instance.createNewLesson(
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateNewLesson, we created `CreateNewLessonBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateNewLessonVariablesBuilder {
  ...
   CreateNewLessonVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.createNewLesson(
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
)
.notes(notes)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateNewLessonData, CreateNewLessonVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createNewLesson(
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
);
CreateNewLessonData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
Timestamp date = ...;
Timestamp endDate = ...;
double cost = ...;
String pupilId = ...;

final ref = ConnectorConnector.instance.createNewLesson(
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
).ref();
ref.execute();
```


### EditLesson
#### Required Arguments
```dart
String id = ...;
Timestamp date = ...;
Timestamp endDate = ...;
double cost = ...;
String pupilId = ...;
ConnectorConnector.instance.editLesson(
  id: id,
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
).execute();
```

#### Optional Arguments
We return a builder for each query. For EditLesson, we created `EditLessonBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class EditLessonVariablesBuilder {
  ...
   EditLessonVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }
  EditLessonVariablesBuilder paymentStatus(String? t) {
   _paymentStatus.value = t;
   return this;
  }
  EditLessonVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  ...
}
ConnectorConnector.instance.editLesson(
  id: id,
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
)
.status(status)
.paymentStatus(paymentStatus)
.notes(notes)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<EditLessonData, EditLessonVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.editLesson(
  id: id,
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
);
EditLessonData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
Timestamp date = ...;
Timestamp endDate = ...;
double cost = ...;
String pupilId = ...;

final ref = ConnectorConnector.instance.editLesson(
  id: id,
  date: date,
  endDate: endDate,
  cost: cost,
  pupilId: pupilId,
).ref();
ref.execute();
```


### CreateUserProfile
#### Required Arguments
```dart
String name = ...;
String email = ...;
ConnectorConnector.instance.createUserProfile(
  name: name,
  email: email,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<CreateUserProfileData, CreateUserProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ConnectorConnector.instance.createUserProfile(
  name: name,
  email: email,
);
CreateUserProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
String email = ...;

final ref = ConnectorConnector.instance.createUserProfile(
  name: name,
  email: email,
).ref();
ref.execute();
```

