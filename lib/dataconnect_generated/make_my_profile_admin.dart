part of 'generated.dart';

class MakeMyProfileAdminVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  MakeMyProfileAdminVariablesBuilder(this._dataConnect, );
  Deserializer<MakeMyProfileAdminData> dataDeserializer = (dynamic json)  => MakeMyProfileAdminData.fromJson(jsonDecode(json));
  
  Future<OperationResult<MakeMyProfileAdminData, void>> execute() {
    return ref().execute();
  }

  MutationRef<MakeMyProfileAdminData, void> ref() {
    
    return _dataConnect.mutation("MakeMyProfileAdmin", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class MakeMyProfileAdminData {
  final int user_updateMany;
  MakeMyProfileAdminData.fromJson(dynamic json):
  
  user_updateMany = nativeFromJson<int>(json['user_updateMany']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final MakeMyProfileAdminData otherTyped = other as MakeMyProfileAdminData;
    return user_updateMany == otherTyped.user_updateMany;
    
  }
  @override
  int get hashCode => user_updateMany.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['user_updateMany'] = nativeToJson<int>(user_updateMany);
    return json;
  }

  MakeMyProfileAdminData({
    required this.user_updateMany,
  });
}

