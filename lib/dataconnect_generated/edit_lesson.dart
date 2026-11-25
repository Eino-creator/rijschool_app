part of 'generated.dart';

class EditLessonVariablesBuilder {
  String id;
  Timestamp date;
  Timestamp endDate;
  Optional<String> _status = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _paymentStatus = Optional.optional(nativeFromJson, nativeToJson);
  double cost;
  Optional<String> _notes = Optional.optional(nativeFromJson, nativeToJson);
  String pupilId;

  final FirebaseDataConnect _dataConnect;  EditLessonVariablesBuilder status(String? t) {
   _status.value = t;
   return this;
  }
  EditLessonVariablesBuilder paymentStatus(String? t) {
   _paymentStatus.value = t;
   return this;
  }
  EditLessonVariablesBuilder notes(String? t) {
   _notes.value = t;
   return this;
  }

  EditLessonVariablesBuilder(this._dataConnect, {required  this.id,required  this.date,required  this.endDate,required  this.cost,required  this.pupilId,});
  Deserializer<EditLessonData> dataDeserializer = (dynamic json)  => EditLessonData.fromJson(jsonDecode(json));
  Serializer<EditLessonVariables> varsSerializer = (EditLessonVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<EditLessonData, EditLessonVariables>> execute() {
    return ref().execute();
  }

  MutationRef<EditLessonData, EditLessonVariables> ref() {
    EditLessonVariables vars= EditLessonVariables(id: id,date: date,endDate: endDate,status: _status,paymentStatus: _paymentStatus,cost: cost,notes: _notes,pupilId: pupilId,);
    return _dataConnect.mutation("EditLesson", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class EditLessonLessonUpdate {
  final String id;
  EditLessonLessonUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final EditLessonLessonUpdate otherTyped = other as EditLessonLessonUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  EditLessonLessonUpdate({
    required this.id,
  });
}

@immutable
class EditLessonData {
  final EditLessonLessonUpdate? lesson_update;
  EditLessonData.fromJson(dynamic json):
  
  lesson_update = json['lesson_update'] == null ? null : EditLessonLessonUpdate.fromJson(json['lesson_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final EditLessonData otherTyped = other as EditLessonData;
    return lesson_update == otherTyped.lesson_update;
    
  }
  @override
  int get hashCode => lesson_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (lesson_update != null) {
      json['lesson_update'] = lesson_update!.toJson();
    }
    return json;
  }

  EditLessonData({
    this.lesson_update,
  });
}

@immutable
class EditLessonVariables {
  final String id;
  final Timestamp date;
  final Timestamp endDate;
  late final Optional<String>status;
  late final Optional<String>paymentStatus;
  final double cost;
  late final Optional<String>notes;
  final String pupilId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  EditLessonVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  date = Timestamp.fromJson(json['date']),
  endDate = Timestamp.fromJson(json['endDate']),
  cost = nativeFromJson<double>(json['cost']),
  pupilId = nativeFromJson<String>(json['pupilId']) {
  
  
  
  
  
    status = Optional.optional(nativeFromJson, nativeToJson);
    status.value = json['status'] == null ? null : nativeFromJson<String>(json['status']);
  
  
    paymentStatus = Optional.optional(nativeFromJson, nativeToJson);
    paymentStatus.value = json['paymentStatus'] == null ? null : nativeFromJson<String>(json['paymentStatus']);
  
  
  
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

    final EditLessonVariables otherTyped = other as EditLessonVariables;
    return id == otherTyped.id && 
    date == otherTyped.date && 
    endDate == otherTyped.endDate && 
    status == otherTyped.status && 
    paymentStatus == otherTyped.paymentStatus && 
    cost == otherTyped.cost && 
    notes == otherTyped.notes && 
    pupilId == otherTyped.pupilId;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, date.hashCode, endDate.hashCode, status.hashCode, paymentStatus.hashCode, cost.hashCode, notes.hashCode, pupilId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['date'] = date.toJson();
    json['endDate'] = endDate.toJson();
    if(status.state == OptionalState.set) {
      json['status'] = status.toJson();
    }
    if(paymentStatus.state == OptionalState.set) {
      json['paymentStatus'] = paymentStatus.toJson();
    }
    json['cost'] = nativeToJson<double>(cost);
    if(notes.state == OptionalState.set) {
      json['notes'] = notes.toJson();
    }
    json['pupilId'] = nativeToJson<String>(pupilId);
    return json;
  }

  EditLessonVariables({
    required this.id,
    required this.date,
    required this.endDate,
    required this.status,
    required this.paymentStatus,
    required this.cost,
    required this.notes,
    required this.pupilId,
  });
}

