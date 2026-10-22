part of 'generated.dart';

class GetPupilsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetPupilsVariablesBuilder(this._dataConnect, );
  Deserializer<GetPupilsData> dataDeserializer = (dynamic json)  => GetPupilsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetPupilsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetPupilsData, void> ref() {
    
    return _dataConnect.query("GetPupils", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetPupilsUsers {
  final String id;
  final String name;
  final String email;
  final String role;
  GetPupilsUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  email = nativeFromJson<String>(json['email']),
  role = nativeFromJson<String>(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPupilsUsers otherTyped = other as GetPupilsUsers;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    email == otherTyped.email && 
    role == otherTyped.role;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, email.hashCode, role.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['email'] = nativeToJson<String>(email);
    json['role'] = nativeToJson<String>(role);
    return json;
  }

  GetPupilsUsers({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

@immutable
class GetPupilsData {
  final List<GetPupilsUsers> users;
  GetPupilsData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetPupilsUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetPupilsData otherTyped = other as GetPupilsData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetPupilsData({
    required this.users,
  });
}

