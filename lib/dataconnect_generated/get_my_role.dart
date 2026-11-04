part of 'generated.dart';

class GetMyRoleVariablesBuilder {
  String firebaseUid;

  final FirebaseDataConnect _dataConnect;
  GetMyRoleVariablesBuilder(this._dataConnect, {required  this.firebaseUid,});
  Deserializer<GetMyRoleData> dataDeserializer = (dynamic json)  => GetMyRoleData.fromJson(jsonDecode(json));
  Serializer<GetMyRoleVariables> varsSerializer = (GetMyRoleVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMyRoleData, GetMyRoleVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetMyRoleData, GetMyRoleVariables> ref() {
    GetMyRoleVariables vars= GetMyRoleVariables(firebaseUid: firebaseUid,);
    return _dataConnect.query("GetMyRole", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMyRoleUsers {
  final String role;
  GetMyRoleUsers.fromJson(dynamic json):
  
  role = nativeFromJson<String>(json['role']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyRoleUsers otherTyped = other as GetMyRoleUsers;
    return role == otherTyped.role;
    
  }
  @override
  int get hashCode => role.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['role'] = nativeToJson<String>(role);
    return json;
  }

  GetMyRoleUsers({
    required this.role,
  });
}

@immutable
class GetMyRoleData {
  final List<GetMyRoleUsers> users;
  GetMyRoleData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetMyRoleUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyRoleData otherTyped = other as GetMyRoleData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyRoleData({
    required this.users,
  });
}

@immutable
class GetMyRoleVariables {
  final String firebaseUid;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMyRoleVariables.fromJson(Map<String, dynamic> json):
  
  firebaseUid = nativeFromJson<String>(json['firebaseUid']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyRoleVariables otherTyped = other as GetMyRoleVariables;
    return firebaseUid == otherTyped.firebaseUid;
    
  }
  @override
  int get hashCode => firebaseUid.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firebaseUid'] = nativeToJson<String>(firebaseUid);
    return json;
  }

  GetMyRoleVariables({
    required this.firebaseUid,
  });
}

