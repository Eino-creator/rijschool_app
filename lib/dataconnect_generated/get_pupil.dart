part of 'generated.dart';

class GetPupilVariablesBuilder {
  String userId;

  final FirebaseDataConnect _dataConnect;
  GetPupilVariablesBuilder(this._dataConnect, {required  this.userId,});
  Deserializer<GetPupilData> dataDeserializer = (dynamic json)  => GetPupilData.fromJson(jsonDecode(json));
  Serializer<GetPupilVariables> varsSerializer = (GetPupilVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetPupilData, GetPupilVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPupilData, GetPupilVariables> ref() {
    GetPupilVariables vars= GetPupilVariables(userId: userId,);
    return _dataConnect.query("GetPupil", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetPupilUsers {
  final String id;
  final String name;
  final String email;
  GetPupilUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPupilUsers otherTyped = other as GetPupilUsers;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    email == otherTyped.email;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, email.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    return json;
  }

  GetPupilUsers({
    required this.id,
    required this.name,
    required this.email,
  });
}

@immutable
class GetPupilData {
  final List<GetPupilUsers> users;
  GetPupilData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetPupilUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPupilData otherTyped = other as GetPupilData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetPupilData({
    required this.users,
  });
}

@immutable
class GetPupilVariables {
  final String userId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetPupilVariables.fromJson(Map<String, dynamic> json):
  
  userId = nativeFromJson<String>(json['userId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPupilVariables otherTyped = other as GetPupilVariables;
    return userId == otherTyped.userId;
    
  }
  @override
  int get hashCode => userId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    return json;
  }

  GetPupilVariables({
    required this.userId,
  });
}

