part of 'generated.dart';

class GetLessonsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetLessonsVariablesBuilder(this._dataConnect, );
  Deserializer<GetLessonsData> dataDeserializer = (dynamic json)  => GetLessonsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetLessonsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetLessonsData, void> ref() {
    
    return _dataConnect.query("GetLessons", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetLessonsLessons {
  final String id;
  final Timestamp date;
  final Timestamp endDate;
  final String status;
  final String paymentStatus;
  final double cost;
  final String? notes;
  final GetLessonsLessonsPupil pupil;
  GetLessonsLessons.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  status = nativeFromJson<String>(json['status']),
  paymentStatus = nativeFromJson<String>(json['paymentStatus']),
  cost = nativeFromJson<double>(json['cost']),
  notes = json['notes'] == null ? null : nativeFromJson<String>(json['notes']),
  pupil = GetLessonsLessonsPupil.fromJson(json['pupil']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsLessons otherTyped = other as GetLessonsLessons;
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

  GetLessonsLessons({
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
class GetLessonsLessonsPupil {
  final String id;
  final String name;
  GetLessonsLessonsPupil.fromJson(dynamic json):
  
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

    final GetLessonsLessonsPupil otherTyped = other as GetLessonsLessonsPupil;
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

  GetLessonsLessonsPupil({
    required this.id,
    required this.name,
  });
}

@immutable
class GetLessonsData {
  final List<GetLessonsLessons> lessons;
  GetLessonsData.fromJson(dynamic json):
  
  lessons = (json['lessons'] as List<dynamic>)
        .map((e) => GetLessonsLessons.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetLessonsData otherTyped = other as GetLessonsData;
    return lessons == otherTyped.lessons;
    
  }
  @override
  int get hashCode => lessons.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lessons'] = lessons.map((e) => e.toJson()).toList();
    return json;
  }

  GetLessonsData({
    required this.lessons,
  });
}

