part of 'generated.dart';

class GetLessonsByPupilVariablesBuilder {
  String pupilID;

  final FirebaseDataConnect _dataConnect;
  GetLessonsByPupilVariablesBuilder(this._dataConnect, {required  this.pupilID,});
  Deserializer<GetLessonsByPupilData> dataDeserializer = (dynamic json)  => GetLessonsByPupilData.fromJson(jsonDecode(json));
  Serializer<GetLessonsByPupilVariables> varsSerializer = (GetLessonsByPupilVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetLessonsByPupilData, GetLessonsByPupilVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetLessonsByPupilData, GetLessonsByPupilVariables> ref() {
    GetLessonsByPupilVariables vars= GetLessonsByPupilVariables(pupilID: pupilID,);
    return _dataConnect.query("GetLessonsByPupil", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetLessonsByPupilLessons {
  final String id;
  final Timestamp date;
  final Timestamp endDate;
  final String status;
  final String paymentStatus;
  final double cost;
  final String? notes;
  final GetLessonsByPupilLessonsPupil pupil;
  GetLessonsByPupilLessons.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  status = nativeFromJson<String>(json['status']),
  paymentStatus = nativeFromJson<String>(json['paymentStatus']),
  cost = nativeFromJson<double>(json['cost']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  pupil = GetLessonsByPupilLessonsPupil.fromJson(json['pupil']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByPupilLessons otherTyped = other as GetLessonsByPupilLessons;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    endDate == otherTyped.endDate && 
    status == otherTyped.status && 
    paymentStatus == otherTyped.paymentStatus && 
    cost == otherTyped.cost && 
    notes == otherTyped.notes && 
    pupil == otherTyped.pupil;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, endDate.hashCode, status.hashCode, paymentStatus.hashCode, cost.hashCode, notes.hashCode, pupil.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = date.toJson();
    json['endDate'] = endDate.toJson();
    json['status'] = nativeToJson<String>(status);
    json['paymentStatus'] = nativeToJson<String>(paymentStatus);
    json['cost'] = nativeToJson<double>(cost);
    if (notes != null) {
      json['notes'] = nativeToJson<String?>(notes);
    }
    json['pupil'] = pupil.toJson();
    return json;
  }

  GetLessonsByPupilLessons({
    required this.id,
    required this.date,
    required this.endDate,
    required this.status,
    required this.paymentStatus,
    required this.cost,
    this.notes,
    required this.pupil,
  });
}

@immutable
class GetLessonsByPupilLessonsPupil {
  final String id;
  final String name;
  GetLessonsByPupilLessonsPupil.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByPupilLessonsPupil otherTyped = other as GetLessonsByPupilLessonsPupil;
    return id == otherTyped.id && 
    name == otherTyped.name;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    return json;
  }

  GetLessonsByPupilLessonsPupil({
    required this.id,
    required this.name,
  });
}

@immutable
class GetLessonsByPupilData {
  final List<GetLessonsByPupilLessons> lessons;
  GetLessonsByPupilData.fromJson(dynamic json):
  
  lessons = (json['lessons'] as List<dynamic>)
        .map((e) => GetLessonsByPupilLessons.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByPupilData otherTyped = other as GetLessonsByPupilData;
    return lessons == otherTyped.lessons;
    
  }
  @override
  int get hashCode => lessons.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lessons'] = lessons.map((e) => e.toJson()).toList();
    return json;
  }

  GetLessonsByPupilData({
    required this.lessons,
  });
}

@immutable
class GetLessonsByPupilVariables {
  final String pupilID;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetLessonsByPupilVariables.fromJson(Map<String, dynamic> json):
  
  pupilID = nativeFromJson<String>(json['pupilID']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByPupilVariables otherTyped = other as GetLessonsByPupilVariables;
    return pupilID == otherTyped.pupilID;
    
  }
  @override
  int get hashCode => pupilID.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['pupilID'] = nativeToJson<String>(pupilID);
    return json;
  }

  GetLessonsByPupilVariables({
    required this.pupilID,
  });
}

