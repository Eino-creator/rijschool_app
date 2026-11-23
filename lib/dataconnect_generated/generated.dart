library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'get_lesson.dart';

part 'get_lessons_by_day.dart';

part 'get_lessons_by_pupil.dart';

part 'create_new_lesson.dart';

part 'get_pupils.dart';

part 'get_pupil.dart';

part 'create_user_profile.dart';

part 'get_my_role.dart';

part 'get_my_user_id.dart';







class ConnectorConnector {
  
  
  GetLessonVariablesBuilder getLesson ({required String id, }) {
    return GetLessonVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetLessonsByDayVariablesBuilder getLessonsByDay ({required Timestamp startDate, required Timestamp endDate, }) {
    return GetLessonsByDayVariablesBuilder(dataConnect, startDate: startDate,endDate: endDate,);
  }
  
  
  GetLessonsByPupilVariablesBuilder getLessonsByPupil ({required String pupilID, }) {
    return GetLessonsByPupilVariablesBuilder(dataConnect, pupilID: pupilID,);
  }
  
  
  CreateNewLessonVariablesBuilder createNewLesson ({required Timestamp date, required Timestamp endDate, required double cost, required String pupilId, }) {
    return CreateNewLessonVariablesBuilder(dataConnect, date: date,endDate: endDate,cost: cost,pupilId: pupilId,);
  }
  
  
  GetPupilsVariablesBuilder getPupils () {
    return GetPupilsVariablesBuilder(dataConnect, );
  }
  
  
  GetPupilVariablesBuilder getPupil ({required String userId, }) {
    return GetPupilVariablesBuilder(dataConnect, userId: userId,);
  }
  
  
  CreateUserProfileVariablesBuilder createUserProfile ({required String name, required String email, }) {
    return CreateUserProfileVariablesBuilder(dataConnect, name: name,email: email,);
  }
  
  
  GetMyRoleVariablesBuilder getMyRole ({required String firebaseUid, }) {
    return GetMyRoleVariablesBuilder(dataConnect, firebaseUid: firebaseUid,);
  }
  
  
  GetMyUserIdVariablesBuilder getMyUserId ({required String firebaseUid, }) {
    return GetMyUserIdVariablesBuilder(dataConnect, firebaseUid: firebaseUid,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'europe-west4',
    'connector',
    'rijschool-app-4954a-service',
  );

  ConnectorConnector({required this.dataConnect});
  static ConnectorConnector get instance {
    
    CacheSettings cacheSettings = CacheSettings(
      maxAge: Duration(milliseconds:0),
      storage: CacheStorage.persistent,
    );
    
    return ConnectorConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            cacheSettings: cacheSettings,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
