part of 'generated.dart';

class GetLessonVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  GetLessonVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<GetLessonData> dataDeserializer = (dynamic json)  => GetLessonData.fromJson(jsonDecode(json));
  Serializer<GetLessonVariables> varsSerializer = (GetLessonVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetLessonData, GetLessonVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetLessonData, GetLessonVariables> ref() {
    GetLessonVariables vars= GetLessonVariables(id: id,);
    return _dataConnect.query("GetLesson", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetLessonLessons {
  final String id;
  final Timestamp date;
  final Timestamp endDate;
  final String status;
  final String paymentStatus;
  final double cost;
  final String? notes;
  final GetLessonLessonsPupil pupil;
  GetLessonLessons.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  status = nativeFromJson<String>(json['status']),
  paymentStatus = nativeFromJson<String>(json['paymentStatus']),
  cost = nativeFromJson<double>(json['cost']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  pupil = GetLessonLessonsPupil.fromJson(json['pupil']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonLessons otherTyped = other as GetLessonLessons;
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

  GetLessonLessons({
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
class GetLessonLessonsPupil {
  final String id;
  final String name;
  GetLessonLessonsPupil.fromJson(dynamic json):
  
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

    final GetLessonLessonsPupil otherTyped = other as GetLessonLessonsPupil;
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

  GetLessonLessonsPupil({
    required this.id,
    required this.name,
  });
}

@immutable
class GetLessonData {
  final List<GetLessonLessons> lessons;
  GetLessonData.fromJson(dynamic json):
  
  lessons = (json['lessons'] as List<dynamic>)
        .map((e) => GetLessonLessons.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonData otherTyped = other as GetLessonData;
    return lessons == otherTyped.lessons;
    
  }
  @override
  int get hashCode => lessons.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lessons'] = lessons.map((e) => e.toJson()).toList();
    return json;
  }

  GetLessonData({
    required this.lessons,
  });
}

@immutable
class GetLessonVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetLessonVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonVariables otherTyped = other as GetLessonVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  GetLessonVariables({
    required this.id,
  });
}

