part of 'generated.dart';

class GetLessonsByDayVariablesBuilder {
  Timestamp startDate;
  Timestamp endDate;

  final FirebaseDataConnect _dataConnect;
  GetLessonsByDayVariablesBuilder(this._dataConnect, {required  this.startDate,required  this.endDate,});
  Deserializer<GetLessonsByDayData> dataDeserializer = (dynamic json)  => GetLessonsByDayData.fromJson(jsonDecode(json));
  Serializer<GetLessonsByDayVariables> varsSerializer = (GetLessonsByDayVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetLessonsByDayData, GetLessonsByDayVariables>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetLessonsByDayData, GetLessonsByDayVariables> ref() {
    GetLessonsByDayVariables vars= GetLessonsByDayVariables(startDate: startDate,endDate: endDate,);
    return _dataConnect.query("GetLessonsByDay", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class GetLessonsByDayLessons {
  final String id;
  final Timestamp date;
  final Timestamp endDate;
  final String status;
  final String paymentStatus;
  final double cost;
  final String? notes;
  final GetLessonsByDayLessonsPupil pupil;
  GetLessonsByDayLessons.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  status = nativeFromJson<String>(json['status']),
  paymentStatus = nativeFromJson<String>(json['paymentStatus']),
  cost = nativeFromJson<double>(json['cost']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  pupil = GetLessonsByDayLessonsPupil.fromJson(json['pupil']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByDayLessons otherTyped = other as GetLessonsByDayLessons;
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

  GetLessonsByDayLessons({
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
class GetLessonsByDayLessonsPupil {
  final String id;
  final String name;
  GetLessonsByDayLessonsPupil.fromJson(dynamic json):
  
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

    final GetLessonsByDayLessonsPupil otherTyped = other as GetLessonsByDayLessonsPupil;
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

  GetLessonsByDayLessonsPupil({
    required this.id,
    required this.name,
  });
}

@immutable
class GetLessonsByDayData {
  final List<GetLessonsByDayLessons> lessons;
  GetLessonsByDayData.fromJson(dynamic json):
  
  lessons = (json['lessons'] as List<dynamic>)
        .map((e) => GetLessonsByDayLessons.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByDayData otherTyped = other as GetLessonsByDayData;
    return lessons == otherTyped.lessons;
    
  }
  @override
  int get hashCode => lessons.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lessons'] = lessons.map((e) => e.toJson()).toList();
    return json;
  }

  GetLessonsByDayData({
    required this.lessons,
  });
}

@immutable
class GetLessonsByDayVariables {
  final Timestamp startDate;
  final Timestamp endDate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  GetLessonsByDayVariables.fromJson(Map<String, dynamic> json):
  
  startDate = Timestamp.fromJson(json['startDate']),
  endDate = Timestamp.fromJson(json['endDate']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsByDayVariables otherTyped = other as GetLessonsByDayVariables;
    return startDate == otherTyped.startDate && 
    endDate == otherTyped.endDate;
    
  }
  @override
  int get hashCode => Object.hashAll([startDate.hashCode, endDate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['startDate'] = startDate.toJson();
    json['endDate'] = endDate.toJson();
    return json;
  }

  GetLessonsByDayVariables({
    required this.startDate,
    required this.endDate,
  });
}

