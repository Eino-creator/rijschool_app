part of 'generated.dart';

class CreateNewLessonVariablesBuilder {
  Timestamp date;
  Timestamp endDate;
  String status;
  String paymentStatus;
  double cost;
  Optional<String> _notes = Optional.optional(nativeFromJson, nativeToJson);
  String pupilId;

  final FirebaseDataConnect _dataConnect;  CreateNewLessonVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  CreateNewLessonVariablesBuilder(this._dataConnect, {required  this.date,required  this.endDate,required  this.status,required  this.paymentStatus,required  this.cost,required  this.pupilId,});
  Deserializer<CreateNewLessonData> dataDeserializer = (dynamic json)  => CreateNewLessonData.fromJson(jsonDecode(json));
  Serializer<CreateNewLessonVariables> varsSerializer = (CreateNewLessonVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateNewLessonData, CreateNewLessonVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateNewLessonData, CreateNewLessonVariables> ref() {
    CreateNewLessonVariables vars= CreateNewLessonVariables(date: date,endDate: endDate,status: status,paymentStatus: paymentStatus,cost: cost,notes: _notes,pupilId: pupilId,);
    return _dataConnect.mutation("CreateNewLesson", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateNewLessonLessonInsert {
  final String id;
  CreateNewLessonLessonInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNewLessonLessonInsert otherTyped = other as CreateNewLessonLessonInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateNewLessonLessonInsert({
    required this.id,
  });
}

@immutable
class CreateNewLessonData {
  final CreateNewLessonLessonInsert lesson_insert;
  CreateNewLessonData.fromJson(dynamic json):
  
  lesson_insert = CreateNewLessonLessonInsert.fromJson(json['lesson_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNewLessonData otherTyped = other as CreateNewLessonData;
    return lesson_insert == otherTyped.lesson_insert;
    
  }
  @override
  int get hashCode => lesson_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['lesson_insert'] = lesson_insert.toJson();
    return json;
  }

  CreateNewLessonData({
    required this.lesson_insert,
  });
}

@immutable
class CreateNewLessonVariables {
  final Timestamp date;
  final Timestamp endDate;
  final String status;
  final String paymentStatus;
  final double cost;
  late final Optional<String>notes;
  final String pupilId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateNewLessonVariables.fromJson(Map<String, dynamic> json):
  
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  status = nativeFromJson<String>(json['status']),
  paymentStatus = nativeFromJson<String>(json['paymentStatus']),
  cost = nativeFromJson<double>(json['cost']),
  pupilId = nativeFromJson<String>(json['pupilId']) {
  
  
  
  
  
  
  
    notes = Optional.optional(nativeFromJson, nativeToJson);
    notes.value = json['notes'] == null ? null : nativeFromJson<String>(json['notes']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateNewLessonVariables otherTyped = other as CreateNewLessonVariables;
    return date == otherTyped.date && 
    endDate == otherTyped.endDate && 
    status == otherTyped.status && 
    paymentStatus == otherTyped.paymentStatus && 
    cost == otherTyped.cost && 
    notes == otherTyped.notes && 
    pupilId == otherTyped.pupilId;
    
  }
  @override
  int get hashCode => Object.hashAll([date.hashCode, endDate.hashCode, status.hashCode, paymentStatus.hashCode, cost.hashCode, notes.hashCode, pupilId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['date'] = date.toJson();
    json['endDate'] = endDate.toJson();
    json['status'] = nativeToJson<String>(status);
    json['paymentStatus'] = nativeToJson<String>(paymentStatus);
    json['cost'] = nativeToJson<double>(cost);
    if(notes.state == OptionalState.set) {
      json['notes'] = notes.toJson();
    }
    json['pupilId'] = nativeToJson<String>(pupilId);
    return json;
  }

  CreateNewLessonVariables({
    required this.date,
    required this.endDate,
    required this.status,
    required this.paymentStatus,
    required this.cost,
    required this.notes,
    required this.pupilId,
  });
}

