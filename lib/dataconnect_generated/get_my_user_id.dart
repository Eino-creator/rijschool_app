part of 'generated.dart';

class GetMyUserIdVariablesBuilder {
  String firebaseUid;

  final FirebaseDataConnect _dataConnect;
  GetMyUserIdVariablesBuilder(this._dataConnect, {required  this.firebaseUid,});
  Deserializer<GetMyUserIdData> dataDeserializer = (dynamic json)  => GetMyUserIdData.fromJson(jsonDecode(json));
  Serializer<GetMyUserIdVariables> varsSerializer = (GetMyUserIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMyUserIdData, GetMyUserIdVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetMyUserIdData, GetMyUserIdVariables> ref() {
    GetMyUserIdVariables vars= GetMyUserIdVariables(firebaseUid: firebaseUid,);
    return _dataConnect.query("GetMyUserId", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetMyUserIdUsers {
  final String id;
  GetMyUserIdUsers.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyUserIdUsers otherTyped = other as GetMyUserIdUsers;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetMyUserIdUsers({
    required this.id,
  });
}

@immutable
class GetMyUserIdData {
  final List<GetMyUserIdUsers> users;
  GetMyUserIdData.fromJson(dynamic json):
  
  users = (json['users'] as List<dynamic>)
        .map((e) => GetMyUserIdUsers.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyUserIdData otherTyped = other as GetMyUserIdData;
    return users == otherTyped.users;
    
  }
  @override
  int get hashCode => users.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['users'] = users.map((e) => e.toJson()).toList();
    return json;
  }

  GetMyUserIdData({
    required this.users,
  });
}

@immutable
class GetMyUserIdVariables {
  final String firebaseUid;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetMyUserIdVariables.fromJson(Map<String, dynamic> json):
  
  firebaseUid = nativeFromJson<String>(json['firebaseUid']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetMyUserIdVariables otherTyped = other as GetMyUserIdVariables;
    return firebaseUid == otherTyped.firebaseUid;
    
  }
  @override
  int get hashCode => firebaseUid.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['firebaseUid'] = nativeToJson<String>(firebaseUid);
    return json;
  }

  GetMyUserIdVariables({
    required this.firebaseUid,
  });
}

