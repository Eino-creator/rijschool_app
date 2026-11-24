part of 'generated.dart';

class EditCourseCostsVariablesBuilder {
  String id;
  int lessonTime;
  double lessonPrice;
  double registrationFee;
  double selfDeclaration;
  double brokerageFees;
  double examCarUsage;

  final FirebaseDataConnect _dataConnect;
  EditCourseCostsVariablesBuilder(this._dataConnect, {required  this.id,required  this.lessonTime,required  this.lessonPrice,required  this.registrationFee,required  this.selfDeclaration,required  this.brokerageFees,required  this.examCarUsage,});
  Deserializer<EditCourseCostsData> dataDeserializer = (dynamic json)  => EditCourseCostsData.fromJson(jsonDecode(json));
  Serializer<EditCourseCostsVariables> varsSerializer = (EditCourseCostsVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<EditCourseCostsData, EditCourseCostsVariables>> execute() {
    return ref().execute();
  }

  MutationRef<EditCourseCostsData, EditCourseCostsVariables> ref() {
    EditCourseCostsVariables vars= EditCourseCostsVariables(id: id,lessonTime: lessonTime,lessonPrice: lessonPrice,registrationFee: registrationFee,selfDeclaration: selfDeclaration,brokerageFees: brokerageFees,examCarUsage: examCarUsage,);
    return _dataConnect.mutation("EditCourseCosts", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class EditCourseCostsCourseCostUpdate {
  final String id;
  EditCourseCostsCourseCostUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final EditCourseCostsCourseCostUpdate otherTyped = other as EditCourseCostsCourseCostUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  EditCourseCostsCourseCostUpdate({
    required this.id,
  });
}

@immutable
class EditCourseCostsData {
  final EditCourseCostsCourseCostUpdate? courseCost_update;
  EditCourseCostsData.fromJson(dynamic json):
  
  courseCost_update = json['courseCost_update'] == null ? null : EditCourseCostsCourseCostUpdate.fromJson(json['courseCost_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final EditCourseCostsData otherTyped = other as EditCourseCostsData;
    return courseCost_update == otherTyped.courseCost_update;
    
  }
  @override
  int get hashCode => courseCost_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (courseCost_update != null) {
      json['courseCost_update'] = courseCost_update!.toJson();
    }
    return json;
  }

  EditCourseCostsData({
    this.courseCost_update,
  });
}

@immutable
class EditCourseCostsVariables {
  final String id;
  final int lessonTime;
  final double lessonPrice;
  final double registrationFee;
  final double selfDeclaration;
  final double brokerageFees;
  final double examCarUsage;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  EditCourseCostsVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']),
  lessonTime = nativeFromJson<int>(json['lessonTime']),
  lessonPrice = nativeFromJson<double>(json['lessonPrice']),
  registrationFee = nativeFromJson<double>(json['registrationFee']),
  selfDeclaration = nativeFromJson<double>(json['selfDeclaration']),
  brokerageFees = nativeFromJson<double>(json['brokerageFees']),
  examCarUsage = nativeFromJson<double>(json['examCarUsage']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final EditCourseCostsVariables otherTyped = other as EditCourseCostsVariables;
    return id == otherTyped.id && 
    lessonTime == otherTyped.lessonTime && 
    lessonPrice == otherTyped.lessonPrice && 
    registrationFee == otherTyped.registrationFee && 
    selfDeclaration == otherTyped.selfDeclaration && 
    brokerageFees == otherTyped.brokerageFees && 
    examCarUsage == otherTyped.examCarUsage;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, lessonTime.hashCode, lessonPrice.hashCode, registrationFee.hashCode, selfDeclaration.hashCode, brokerageFees.hashCode, examCarUsage.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['lessonTime'] = nativeToJson<int>(lessonTime);
    json['lessonPrice'] = nativeToJson<double>(lessonPrice);
    json['registrationFee'] = nativeToJson<double>(registrationFee);
    json['selfDeclaration'] = nativeToJson<double>(selfDeclaration);
    json['brokerageFees'] = nativeToJson<double>(brokerageFees);
    json['examCarUsage'] = nativeToJson<double>(examCarUsage);
    return json;
  }

  EditCourseCostsVariables({
    required this.id,
    required this.lessonTime,
    required this.lessonPrice,
    required this.registrationFee,
    required this.selfDeclaration,
    required this.brokerageFees,
    required this.examCarUsage,
  });
}

