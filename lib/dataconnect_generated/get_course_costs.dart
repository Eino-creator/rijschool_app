part of 'generated.dart';

class GetCourseCostsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetCourseCostsVariablesBuilder(this._dataConnect, );
  Deserializer<GetCourseCostsData> dataDeserializer = (dynamic json)  => GetCourseCostsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetCourseCostsData, void>> execute({QueryFetchPolicy fetchPolicy = QueryFetchPolicy.preferCache}) {
    return ref().execute(fetchPolicy: fetchPolicy);
  }

  QueryRef<GetCourseCostsData, void> ref() {
    
    return _dataConnect.query("GetCourseCosts", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetCourseCostsCourseCosts {
  final String id;
  final GetCourseCostsCourseCostsInstructor instructor;
  final int? lessonTime;
  final double? lessonPrice;
  final double? registrationFee;
  final double? selfDeclaration;
  final double? brokerageFees;
  final double? examCarUsage;
  GetCourseCostsCourseCosts.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  instructor = GetCourseCostsCourseCostsInstructor.fromJson(json['instructor']),
  lessonTime = json['lessonTime'] == null ? null : nativeFromJson<int>(json['lessonTime']),
  lessonPrice = json['lessonPrice'] == null ? null : nativeFromJson<double>(json['lessonPrice']),
  registrationFee = json['registrationFee'] == null ? null : nativeFromJson<double>(json['registrationFee']),
  selfDeclaration = json['selfDeclaration'] == null ? null : nativeFromJson<double>(json['selfDeclaration']),
  brokerageFees = json['brokerageFees'] == null ? null : nativeFromJson<double>(json['brokerageFees']),
  examCarUsage = json['examCarUsage'] == null ? null : nativeFromJson<double>(json['examCarUsage']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCourseCostsCourseCosts otherTyped = other as GetCourseCostsCourseCosts;
    return id == otherTyped.id && 
    instructor == otherTyped.instructor && 
    lessonTime == otherTyped.lessonTime && 
    lessonPrice == otherTyped.lessonPrice && 
    registrationFee == otherTyped.registrationFee && 
    selfDeclaration == otherTyped.selfDeclaration && 
    brokerageFees == otherTyped.brokerageFees && 
    examCarUsage == otherTyped.examCarUsage;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, instructor.hashCode, lessonTime.hashCode, lessonPrice.hashCode, registrationFee.hashCode, selfDeclaration.hashCode, brokerageFees.hashCode, examCarUsage.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['instructor'] = instructor.toJson();
    if (lessonTime != null) {
      json['lessonTime'] = nativeToJson<int?>(lessonTime);
    }
    if (lessonPrice != null) {
      json['lessonPrice'] = nativeToJson<double?>(lessonPrice);
    }
    if (registrationFee != null) {
      json['registrationFee'] = nativeToJson<double?>(registrationFee);
    }
    if (selfDeclaration != null) {
      json['selfDeclaration'] = nativeToJson<double?>(selfDeclaration);
    }
    if (brokerageFees != null) {
      json['brokerageFees'] = nativeToJson<double?>(brokerageFees);
    }
    if (examCarUsage != null) {
      json['examCarUsage'] = nativeToJson<double?>(examCarUsage);
    }
    return json;
  }

  GetCourseCostsCourseCosts({
    required this.id,
    required this.instructor,
    this.lessonTime,
    this.lessonPrice,
    this.registrationFee,
    this.selfDeclaration,
    this.brokerageFees,
    this.examCarUsage,
  });
}

@immutable
class GetCourseCostsCourseCostsInstructor {
  final String id;
  final String name;
  GetCourseCostsCourseCostsInstructor.fromJson(dynamic json):
  
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

    final GetCourseCostsCourseCostsInstructor otherTyped = other as GetCourseCostsCourseCostsInstructor;
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

  GetCourseCostsCourseCostsInstructor({
    required this.id,
    required this.name,
  });
}

@immutable
class GetCourseCostsData {
  final List<GetCourseCostsCourseCosts> courseCosts;
  GetCourseCostsData.fromJson(dynamic json):
  
  courseCosts = (json['courseCosts'] as List<dynamic>)
        .map((e) => GetCourseCostsCourseCosts.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetCourseCostsData otherTyped = other as GetCourseCostsData;
    return courseCosts == otherTyped.courseCosts;
    
  }
  @override
  int get hashCode => courseCosts.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['courseCosts'] = courseCosts.map((e) => e.toJson()).toList();
    return json;
  }

  GetCourseCostsData({
    required this.courseCosts,
  });
}

