# Basic Usage

```dart
ConnectorConnector.instance.GetLesson(getLessonVariables).execute();
ConnectorConnector.instance.GetLessonsByDay(getLessonsByDayVariables).execute();
ConnectorConnector.instance.GetLessonsByPupil(getLessonsByPupilVariables).execute();
ConnectorConnector.instance.CreateNewLesson(createNewLessonVariables).execute();
ConnectorConnector.instance.GetPupils().execute();
ConnectorConnector.instance.GetPupil(getPupilVariables).execute();
ConnectorConnector.instance.CreateUserProfile(createUserProfileVariables).execute();
ConnectorConnector.instance.GetMyRole(getMyRoleVariables).execute();
ConnectorConnector.instance.GetMyUserId(getMyUserIdVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ConnectorConnector.instance.CreateNewLesson({ ... })
.notes(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

