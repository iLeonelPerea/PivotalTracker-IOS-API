//
//  RESTManager.m
//  PivotalTracker-IOS-API
//
//  Created by Leonel Perea on 12/04/2014.
//  Copyright (c) 2014 Leonel Perea. All rights reserved.
//

#import "RESTManager.h"
#import "NSData+Base64.h"
#import "Configuration.h"

@implementation RESTManager

//Account
+(void)getAccount:(int)account_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"accounts/%d",account_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Account Memberships endpoint
+(void)getAccountMemberships:(int)account_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"accounts/%d/memberships",account_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postAccountMemberships:(int)account_id withPersonId:(int)person_id withEmail:(NSString *)email withName:(NSString *)name withInitials:(NSString *)initials withCreated_at:(double)created_at withAdmin:(BOOL)admin withProject_creator:(BOOL)project_creator withTimekeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_entered toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict;
    if (person_id) {
        jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"person_id": [NSNumber numberWithInt:person_id], @"created_at": [NSNumber numberWithInt:created_at], @"admin": [NSNumber numberWithBool:admin], @"project_creator": [NSNumber numberWithBool:project_creator], @"timekeeper": [NSNumber numberWithBool:timekeeper], @"time_enterer": [NSNumber numberWithBool:time_entered]}];
    }else{
       jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"email": [NSString stringWithFormat:@"%@",email], @"name": [NSString stringWithFormat:@"%@",name], @"initials": [NSString stringWithFormat:@"%@",initials], @"created_at": [NSNumber numberWithInt:created_at], @"admin": [NSNumber numberWithBool:admin], @"project_creator": [NSNumber numberWithBool:project_creator], @"timekeeper": [NSNumber numberWithBool:timekeeper], @"time_enterer": [NSNumber numberWithBool:time_entered]}];
    }
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"accounts/%d/memberships",account_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getIndividualAccountMembership:(int)account_id withPersonId:(int)person_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"accounts/%d/memberships/%d",account_id,person_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putIndividualAccountMembership:(int)account_id withPersonId:(int)person_id withAdmin:(BOOL)admin withProjectCreator:(BOOL)project_creator withTimeKeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_entered toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"admin": [NSNumber numberWithBool:admin], @"project_creator": [NSNumber numberWithBool:project_creator], @"timekeeper": [NSNumber numberWithBool:timekeeper], @"time_enterer": [NSNumber numberWithBool:time_entered]}];
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"accounts/%d/memberships/%d",account_id,person_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteIndividualAccountMembership:(int)account_id withPersonId:(int)person_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"accounts/%d/memberships/%d",account_id,person_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Accounts endpoint
+(void)getAccounts:(void (^)(id))callback{
    [self sendData:nil toService:@"accounts/" withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getAccountSumaries:(PERMISSION)with_permision toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"account_summaries?with_permission=%@",[self permissionToString:with_permision ]] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Activity endpoint
+(void)getActivity:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after  toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@&%@",(limit)? [NSString stringWithFormat:@"limit=%d",limit]:@"",(offset)? [NSString stringWithFormat:@"offset=%d",offset]:@""];
    [self sendData:nil toService:@"my/activity" withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectActivity:(int)project_id withLimit:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after andSinceVersion:(int)since_version toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@&%@&%@",(limit)? [NSString stringWithFormat:@"limit=%d",limit]:@"",(offset)? [NSString stringWithFormat:@"offset=%d",offset]:@"", (since_version)? [NSString stringWithFormat:@"since_version=%d",since_version]:@""];
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/activity",project_id] withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectStoryActivity:(int)project_id withStoryId:(int)story_id withLimit:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after andSinceVersion:(int)since_version toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@&%@&%@",(limit)? [NSString stringWithFormat:@"limit=%d",limit]:@"",(offset)? [NSString stringWithFormat:@"offset=%d",offset]:@"", (since_version)? [NSString stringWithFormat:@"since_version=%d",since_version]:@""];
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/activity",project_id, story_id] withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectEpicActivity:(int)project_id withEpicId:(int)epic_id withLimit:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after andSinceVersion:(int)since_version toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@&%@&%@",(limit)? [NSString stringWithFormat:@"limit=%d",limit]:@"",(offset)? [NSString stringWithFormat:@"offset=%d",offset]:@"", (since_version)? [NSString stringWithFormat:@"since_version=%d",since_version]:@""];
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d/activity",project_id, epic_id] withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

//Attachment endpoint
+(void)deleteFileAttachment:(int)project_id withStoryId:(int)story_id withCommentId:(int)comment_id andFileAttachmentId:(int)file_attachment_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments/%d/file_attachments/%d",project_id, story_id, comment_id, file_attachment_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)projectUploadFile:(int)project_id withComment:(NSString *)comment_id andFile:(NSInteger)file toCallback:(void (^)(id))callback{
    //Needs implementation
}

+(void)projectDownloadFile:(int)file_attachment_id andInline:(BOOL)inLine toCallback:(void (^)(id))callback{
    //Needs implementation
}

//Comments endpoint
+(void)getProjectStoryComments:(int)project_id withStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments",project_id, story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectStoryComments:(int)project_id withStoryId:(int)story_id withText:(NSString *)text withFileAttachment:(NSString *)file_attachments withGoogleAttachments:(NSString *)google_attachments withCommitIdentifier:(NSString *)commit_identifier withCommitType:(NSString *)commit_type andPersonId:(int)person_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"text": [NSString stringWithFormat:@"%@",text]}];
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments",project_id, story_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectStoryComment:(int)project_id withStoryId:(int)story_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments/%d",project_id, story_id, comment_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectStoryComment:(int)project_id withStoryId:(int)story_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments/%d",project_id, story_id, comment_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectStoryComment:(int)project_id withStoryId:(int)story_id withCommentId:(int)comment_id andText:(NSString *)text toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"text": [NSString stringWithFormat:@"%@",text]}];
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/comments/%d",project_id, story_id, comment_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectEpicComments:(int)project_id withEpicId:(int)epic_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d/comments",project_id, epic_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectEpicComments:(int)project_id withEpicId:(int)epic_id withText:(NSString *)text withFileAttachment:(NSString *)file_attachments withGoogleAttachments:(NSString *)google_attachments withCommitIdentifier:(NSString *)commit_identifier withCommitType:(NSString *)commit_type andPersonId:(int)person_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"text": [NSString stringWithFormat:@"%@",text]}];
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/epics/%d/comments",project_id, epic_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectEpicComment:(int)project_id withEpicId:(int)epic_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d/comments/%d",project_id, epic_id, comment_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectEpicComment:(int)project_id withEpicId:(int)epic_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d/comments/%d",project_id, epic_id, comment_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectEpicComment:(int)project_id withEpicId:(int)epic_id withCommentId:(int)comment_id andText:(NSString *)text toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [NSMutableDictionary dictionaryWithDictionary:@{@"text": [NSString stringWithFormat:@"%@",text]}];
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/epics/%d/comments/%d",project_id, epic_id, comment_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Epic endpoint
+(void)getProjectEpic:(int)project_id andEpicId:(int)epic_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d",project_id, epic_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectEpic:(int)project_id withEpicId:(int)epic_id withFollowerIds:(int)follower_ids withName:(NSMutableArray *)name withLabel:(NSString *)label withLabelId:(int)label_id withDescription:(NSString *)description withAfterId:(int)after_id andBeforeId:(int)before_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (follower_ids)? [jsonDict setObject:[NSNumber numberWithInt:follower_ids] forKey:@"follower_ids"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (label)? [jsonDict setObject:label forKey:@"label"]:nil;
    (label_id)? [jsonDict setObject:[NSNumber numberWithInt:label_id] forKey:@"label_id"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (after_id)? [jsonDict setObject:[NSNumber numberWithInt:after_id] forKey:@"after_id"]:nil;
    (before_id)? [jsonDict setObject:[NSNumber numberWithInt:before_id] forKey:@"before_id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/epics/%d",project_id, epic_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectEpic:(int)project_id andEpicId:(int)epic_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics/%d",project_id, epic_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getEpic:(int)epic_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"epics/%d",epic_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Epics endpoint
+(void)getProjectEpics:(int)project_id andFilter:(NSString *)filter toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@",(filter)? [NSString stringWithFormat:@"filter=%@",filter]:@""];
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/epics",project_id] withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectEpics:(int)project_id withName:(NSMutableArray *)name withLabel:(NSString *)label withLabelId:(int)label_id withDescription:(NSString *)description withAfterId:(int)after_id andBeforeId:(int)before_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (label)? [jsonDict setObject:label forKey:@"label"]:nil;
    (label_id)? [jsonDict setObject:[NSNumber numberWithInt:label_id] forKey:@"label_id"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (after_id)? [jsonDict setObject:[NSNumber numberWithInt:after_id] forKey:@"after_id"]:nil;
    (before_id)? [jsonDict setObject:[NSNumber numberWithInt:before_id] forKey:@"before_id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/epics",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Exports endpoint
+(void)postExportProject:(int)project_id andStories:(NSMutableArray *)story_ids toCallback:(void (^)(id))callback{
    
}

+(void)postExportStories:(NSMutableArray *)story_ids toCallback:(void (^)(id))callback{
    
}

//Iterations endpoint
+(void)getProjectIterations:(int)project_id withOffset:(int)offset withLabel:(NSString *)label withLimit:(int)limit andScope:(SCOPE)scope toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@&%@%@&%@",(offset)? [NSString stringWithFormat:@"offset=%d",offset]:@"",(label)? [NSString stringWithFormat:@"label=%@",label]:@"",(limit)? [NSString stringWithFormat:@"limit=%d",limit]:@"",(scope)? [NSString stringWithFormat:@"scope=%@", [self scopeToString:scope]]:@""];
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/iterations",project_id] withMethod:@"GET" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectIterationsOverrides:(int)project_id withIterationNumber:(int)iteration_number withLenght:(int)length andTeamStrengh:(float)team_strength toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (length)? [jsonDict setObject:[NSNumber numberWithInt:length] forKey:@"length"]:nil;
    (team_strength)? [jsonDict setObject:[NSNumber numberWithFloat:team_strength] forKey:@"team_strength"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/iteration_overrides/%d",project_id,iteration_number] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Labels endpoint
+(void)getProjectsLabels:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/labels",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectsLabels:(int)project_id andName:(NSString *)name toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/labels",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectLabel:(int)project_id andLabelId:(int)label_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/labels/%d",project_id, label_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectLabel:(int)project_id withLabelId:(int)label_id andName:(NSString *)name toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/labels/%d",project_id,label_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectLabel:(int)project_id andLabelId:(int)label_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/labels/%d",project_id,label_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectStoryLabel:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/labels",project_id,story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectStoryLabel:(int)project_id withStoryId:(int)story_id withLabelId:(int)label_id andName:(NSString *)name toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (label_id)? [jsonDict setObject:[NSNumber numberWithInt:label_id] forKey:@"id"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/labels",project_id,story_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectStoryLabel:(int)project_id withStoryId:(int)story_id andLabelId:(int)label_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/labels/%d",project_id,story_id, label_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Me endpoint
+(void)getMe: (void (^)(id))callback{
    [self sendData:nil toService:@"me" withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Notifications endpoint
+(void)getMyNotifications:(NSDate *)created_after toCallback:(void (^)(id))callback{
    [self sendData:nil toService:@"my/notifications" withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putMyNotificationsMarkRead:(int)before toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@",(before)? [NSString stringWithFormat:@"before=%d",before]:@""];
    [self sendData:nil toService:@"my/notifications/mark_read" withMethod:@"PUT" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getPeopleNotificationsSince:(int)person_id andTimeStamp:(NSDate *)timestamp toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"people/%d/notifications/since/%@",person_id,timestamp] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putMyNotificationMarkRead:(int)notification_id andTimeStamp:(NSDate *)read_at toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (read_at)? [jsonDict setObject:read_at forKey:@"read_at"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"my/notifications/%d",notification_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Project endpoint
+(void)getProject:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];

}

+(void)putProject:(int)project_id withName:(NSString *)name withIterationLeght:(int)iteration_length withWeekStartDay:(WEEK_DAY)week_start_day withPointScale:(NSString *)point_scale withBugsAndChores:(BOOL)bugs_and_chores_are_estimatable withAutomaticPlanning:(BOOL)automatic_planning withEnableTask:(BOOL)enable_tasks withStartDate:(NSDate *)start_date withTimeZone:(NSString *)time_zone withVelocityAverage:(int)velocity_averaged_over withNumberShowIterations:(int)number_of_done_iterations_to_show withDescription:(NSString *)description withProfileContent:(NSString *)profile_content withEnableIncomingEmails:(BOOL)enable_incoming_emails withInitialVelocity:(int)initial_velocity withPublic:(BOOL)public_content withAtomEnable:(BOOL)atom_enabled withAccountId:(int)account_id andFeatured:(BOOL)featured toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (iteration_length)? [jsonDict setObject:[NSNumber numberWithInt:iteration_length] forKey:@"iteration_length"]:nil;
    (week_start_day)? [jsonDict setObject:[self weekDayToString:week_start_day] forKey:@"week_start_day"]:nil;
    (point_scale)? [jsonDict setObject:point_scale forKey:@"point_scale"]:nil;
    (bugs_and_chores_are_estimatable)? [jsonDict setObject:[NSNumber numberWithBool:bugs_and_chores_are_estimatable] forKey:@"bugs_and_chores_are_estimatable"]:nil;
    (automatic_planning)? [jsonDict setObject:[NSNumber numberWithBool:automatic_planning] forKey:@"automatic_planning"]:nil;
    (enable_tasks)? [jsonDict setObject:[NSNumber numberWithBool:enable_tasks] forKey:@"enable_tasks"]:nil;
    (start_date)? [jsonDict setObject:start_date forKey:@"start_date"]:nil;
    (time_zone)? [jsonDict setObject:time_zone forKey:@"time_zone"]:nil;
    (velocity_averaged_over)? [jsonDict setObject:[NSNumber numberWithInt:velocity_averaged_over] forKey:@"velocity_averaged_over"]:nil;
    (number_of_done_iterations_to_show)? [jsonDict setObject:[NSNumber numberWithInt:number_of_done_iterations_to_show] forKey:@"number_of_done_iterations_to_show"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (profile_content)? [jsonDict setObject:profile_content forKey:@"profile_content"]:nil;
    (enable_incoming_emails)? [jsonDict setObject:[NSNumber numberWithBool:enable_incoming_emails] forKey:@"enable_incoming_emails"]:nil;
    (initial_velocity)? [jsonDict setObject:[NSNumber numberWithInt:initial_velocity] forKey:@"initial_velocity"]:nil;
    (public_content)? [jsonDict setObject:[NSNumber numberWithBool:public_content] forKey:@"public"]:nil;
    (atom_enabled)? [jsonDict setObject:[NSNumber numberWithBool:atom_enabled] forKey:@"atom_enabled"]:nil;
    (account_id)? [jsonDict setObject:[NSNumber numberWithInt:account_id] forKey:@"account_id"]:nil;
    (featured)? [jsonDict setObject:[NSNumber numberWithBool:featured] forKey:@"featured"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d",project_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProject:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d",project_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Project Integrations endpoint
+(void)getProjectIntegrations:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/integrations",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectIntegrations:(int)project_id withType:(TYPE_EXTERNAL_INTEGRATION)type withAPIUserName:(NSString *)api_username withAPIPassword:(NSString *)api_password withZendeskUserEmail:(NSString *)zendesk_user_email withZendeskUserPassword:(NSString *)zendesk_user_password withViewId:(NSString *)view_id withCompany:(NSString *)company withProduct:(NSString *)product withComponent:(NSString *)component withStatusesToExclude:(NSString *)statuses_to_exclude withFilterId:(NSString*)filter_id withAccount:(NSString *)account withExternalApiToken:(NSString *)external_api_token withBinId:(int)bin_id withExternalProjectId:(int)external_project_id withImportAPIUrl:(NSString *)import_api_url withBasicAuthUsername:(NSString *)basic_auth_username withBasicAuthPassword:(NSString *)basic_auth_password withCommentsPrivate:(BOOL)comments_private withUpdateComments:(BOOL)update_comments withUpdateState:(BOOL)update_state withBaseUrl:(NSString *)base_url withName:(NSString *)name andActive:(BOOL)active toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (type)? [jsonDict setObject:[self typeExternalIntegrationToString:type] forKey:@"type"]:nil;
    (api_username)? [jsonDict setObject:api_username forKey:@"api_username"]:nil;
    (api_password)? [jsonDict setObject:api_password forKey:@"api_password"]:nil;
    (zendesk_user_email)? [jsonDict setObject:zendesk_user_email forKey:@"zendesk_user_email"]:nil;
    (zendesk_user_password)? [jsonDict setObject:zendesk_user_password forKey:@"zendesk_user_password"]:nil;
    (view_id)? [jsonDict setObject:view_id forKey:@"view_id"]:nil;
    (company)? [jsonDict setObject:company forKey:@"company"]:nil;
    (product)? [jsonDict setObject:product forKey:@"product"]:nil;
    (component)? [jsonDict setObject:component forKey:@"component"]:nil;
    (statuses_to_exclude)? [jsonDict setObject:statuses_to_exclude forKey:@"statuses_to_exclude"]:nil;
    (filter_id)? [jsonDict setObject:filter_id forKey:@"filter_id"]:nil;
    (account)? [jsonDict setObject:account forKey:@"account"]:nil;
    (external_api_token)? [jsonDict setObject:external_api_token forKey:@"external_api_token"]:nil;
    (bin_id)? [jsonDict setObject:[NSNumber numberWithBool:bin_id] forKey:@"bin_id"]:nil;
    (external_project_id)? [jsonDict setObject:[NSNumber numberWithInt:external_project_id] forKey:@"external_project_id"]:nil;
    (import_api_url)? [jsonDict setObject:import_api_url forKey:@"import_api_url"]:nil;
    (basic_auth_username)? [jsonDict setObject:basic_auth_username forKey:@"basic_auth_username"]:nil;
    (basic_auth_password)? [jsonDict setObject:basic_auth_password forKey:@"basic_auth_password"]:nil;
    (comments_private)? [jsonDict setObject:[NSNumber numberWithBool:comments_private] forKey:@"comments_private"]:nil;
    (update_comments)? [jsonDict setObject:[NSNumber numberWithBool:update_comments] forKey:@"update_comments"]:nil;
    (update_state)? [jsonDict setObject:[NSNumber numberWithBool:update_state] forKey:@"update_state"]:nil;
    (base_url)? [jsonDict setObject:base_url forKey:@"base_url"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (active)? [jsonDict setObject:[NSNumber numberWithBool:active] forKey:@"active"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectIntegrations:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/integrations/%d",project_id, integration_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectIntegrations:(int)project_id withIntegrationId:(int)integration_id withAPIUserName:(NSString *)api_username withAPIPassword:(NSString *)api_password withZendeskUserEmail:(NSString *)zendesk_user_email withZendeskUserPassword:(NSString *)zendesk_user_password withViewId:(NSString *)view_id withCompany:(NSString *)company withProduct:(NSString *)product withComponent:(NSString *)component withStatusesToExclude:(NSString *)statuses_to_exclude withFilterId:(NSString*)filter_id withAccount:(NSString *)account withExternalApiToken:(NSString *)external_api_token withBinId:(int)bin_id withExternalProjectId:(int)external_project_id withImportAPIUrl:(NSString *)import_api_url withBasicAuthUsername:(NSString *)basic_auth_username withBasicAuthPassword:(NSString *)basic_auth_password withCommentsPrivate:(BOOL)comments_private withUpdateComments:(BOOL)update_comments withUpdateState:(BOOL)update_state withBaseUrl:(NSString *)base_url withName:(NSString *)name andActive:(BOOL)active toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (api_username)? [jsonDict setObject:api_username forKey:@"api_username"]:nil;
    (api_password)? [jsonDict setObject:api_password forKey:@"api_password"]:nil;
    (zendesk_user_email)? [jsonDict setObject:zendesk_user_email forKey:@"zendesk_user_email"]:nil;
    (zendesk_user_password)? [jsonDict setObject:zendesk_user_password forKey:@"zendesk_user_password"]:nil;
    (view_id)? [jsonDict setObject:view_id forKey:@"view_id"]:nil;
    (company)? [jsonDict setObject:company forKey:@"company"]:nil;
    (product)? [jsonDict setObject:product forKey:@"product"]:nil;
    (component)? [jsonDict setObject:component forKey:@"component"]:nil;
    (statuses_to_exclude)? [jsonDict setObject:statuses_to_exclude forKey:@"statuses_to_exclude"]:nil;
    (filter_id)? [jsonDict setObject:filter_id forKey:@"filter_id"]:nil;
    (account)? [jsonDict setObject:account forKey:@"account"]:nil;
    (external_api_token)? [jsonDict setObject:external_api_token forKey:@"external_api_token"]:nil;
    (bin_id)? [jsonDict setObject:[NSNumber numberWithBool:bin_id] forKey:@"bin_id"]:nil;
    (external_project_id)? [jsonDict setObject:[NSNumber numberWithInt:external_project_id] forKey:@"external_project_id"]:nil;
    (import_api_url)? [jsonDict setObject:import_api_url forKey:@"import_api_url"]:nil;
    (basic_auth_username)? [jsonDict setObject:basic_auth_username forKey:@"basic_auth_username"]:nil;
    (basic_auth_password)? [jsonDict setObject:basic_auth_password forKey:@"basic_auth_password"]:nil;
    (comments_private)? [jsonDict setObject:[NSNumber numberWithBool:comments_private] forKey:@"comments_private"]:nil;
    (update_comments)? [jsonDict setObject:[NSNumber numberWithBool:update_comments] forKey:@"update_comments"]:nil;
    (update_state)? [jsonDict setObject:[NSNumber numberWithBool:update_state] forKey:@"update_state"]:nil;
    (base_url)? [jsonDict setObject:base_url forKey:@"base_url"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (active)? [jsonDict setObject:[NSNumber numberWithBool:active] forKey:@"active"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/integrations/%d",project_id, integration_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectIntegrations:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/integrations/%d",project_id, integration_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectIntegrationsStories:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/integrations/%d/stories",project_id, integration_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Project Memberships endpoint
+(void)postProjectMemberships:(int)project_id withPersonId:(int)person_id withRole:(ROLE)role withEmail:(NSString *)email withName:(NSString *)name withInitials:(NSString *)initials andProjectColor:(NSString *)project_color toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (person_id)? [jsonDict setObject:[NSNumber numberWithInt:person_id] forKey:@"person_id"]:nil;
    (role)? [jsonDict setObject:[self roleToString:role] forKey:@"role"]:nil;
    (email)? [jsonDict setObject:email forKey:@"email"]:nil;
    (name)? [jsonDict setObject:name forKey:@"zendesk_user_password"]:nil;
    (initials)? [jsonDict setObject:initials forKey:@"initials"]:nil;
    (project_color)? [jsonDict setObject:project_color forKey:@"project_color"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/memberships",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectMemberships:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/memberships",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectMembership:(int)project_id andMembershipId:(int)membership_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/memberships/%d",project_id,membership_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectMembership:(int)project_id andMembershipId:(int)membership_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/memberships/%d",project_id,membership_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectMembership:(int)project_id withMembershipId:(int)membership_id withRole:(ROLE)role andProjectColor:(NSString *)project_color toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (role)? [jsonDict setObject:[self roleToString:role] forKey:@"role"]:nil;
    (project_color)? [jsonDict setObject:project_color forKey:@"project_color"]:nil;
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/memberships/%d",project_id,membership_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Project Webhooks endpoint
+(void)getProjectWebhooks:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/webhooks",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectWebhooks:(int)project_id withWebhookURL:(NSString *)webhook_url andWebhookVersion:(WEBHOOK_VERSION)webhook_version toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (webhook_url)? [jsonDict setObject:webhook_url forKey:@"webhook_url"]:nil;
    (webhook_version)? [jsonDict setObject:[self webhookVersionToString:webhook_version] forKey:@"webhook_version"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/webhooks",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectWebhook:(int)project_id andWebhookId:(int)webhook_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/webhooks/%d",project_id,webhook_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectWebhook:(int)project_id withWebhookId:(int)webhook_id withWebhookURL:(NSString *)webhook_url andWebhookVersion:(WEBHOOK_VERSION)webhook_version toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (webhook_url)? [jsonDict setObject:webhook_url forKey:@"webhook_url"]:nil;
    (webhook_version)? [jsonDict setObject:[self webhookVersionToString:webhook_version] forKey:@"webhook_version"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/webhooks/%d",project_id, webhook_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectWebhook:(int)project_id andWebhookId:(int)webhook_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/webhooks/%d",project_id, webhook_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Projects endpoints
+(void)getProjects:(NSString *)account_ids toCallback:(void (^)(id))callback{
    NSString *params = [NSString stringWithFormat:@"%@",(account_ids)? [NSString stringWithFormat:@"account_ids=%@",account_ids]:@""];
    [self sendData:nil toService:@"projects" withMethod:@"DELETE" andParams:params toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProject:(BOOL)no_owner withNewAccountName:(NSString *)new_account_name withCreateSample:(BOOL)create_sample withName:(NSString *)name withIterationLeght:(int)iteration_length withWeekStartDay:(WEEK_DAY)week_start_day withPointScale:(NSString *)point_scale withBugsAndChores:(BOOL)bugs_and_chores_are_estimatable withAutomaticPlanning:(BOOL)automatic_planning withEnableTask:(BOOL)enable_tasks withStartDate:(NSDate *)start_date withTimeZone:(NSString *)time_zone withVelocityAverage:(int)velocity_averaged_over withNumberShowIterations:(int)number_of_done_iterations_to_show withDescription:(NSString *)description withProfileContent:(NSString *)profile_content withEnableIncomingEmails:(BOOL)enable_incoming_emails withInitialVelocity:(int)initial_velocity withPublic:(BOOL)public_content withAtomEnable:(BOOL)atom_enabled withAccountId:(int)account_id andFeatured:(BOOL)featured toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (no_owner)? [jsonDict setObject:[NSNumber numberWithBool:no_owner] forKey:@"no_owner"]:nil;
    (new_account_name)? [jsonDict setObject:new_account_name forKey:@"new_account_name"]:nil;
    (create_sample)? [jsonDict setObject:[NSNumber numberWithBool:create_sample] forKey:@"create_sample"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (iteration_length)? [jsonDict setObject:[NSNumber numberWithInt:iteration_length] forKey:@"iteration_length"]:nil;
    (week_start_day)? [jsonDict setObject:[self weekDayToString:week_start_day] forKey:@"week_start_day"]:nil;
    (point_scale)? [jsonDict setObject:point_scale forKey:@"point_scale"]:nil;
    (bugs_and_chores_are_estimatable)? [jsonDict setObject:[NSNumber numberWithBool:bugs_and_chores_are_estimatable] forKey:@"bugs_and_chores_are_estimatable"]:nil;
    (automatic_planning)? [jsonDict setObject:[NSNumber numberWithBool:automatic_planning] forKey:@"automatic_planning"]:nil;
    (enable_tasks)? [jsonDict setObject:[NSNumber numberWithBool:enable_tasks] forKey:@"enable_tasks"]:nil;
    (start_date)? [jsonDict setObject:start_date forKey:@"start_date"]:nil;
    (time_zone)? [jsonDict setObject:time_zone forKey:@"time_zone"]:nil;
    (velocity_averaged_over)? [jsonDict setObject:[NSNumber numberWithInt:velocity_averaged_over] forKey:@"velocity_averaged_over"]:nil;
    (number_of_done_iterations_to_show)? [jsonDict setObject:[NSNumber numberWithInt:number_of_done_iterations_to_show] forKey:@"number_of_done_iterations_to_show"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (profile_content)? [jsonDict setObject:profile_content forKey:@"profile_content"]:nil;
    (enable_incoming_emails)? [jsonDict setObject:[NSNumber numberWithBool:enable_incoming_emails] forKey:@"enable_incoming_emails"]:nil;
    (initial_velocity)? [jsonDict setObject:[NSNumber numberWithInt:initial_velocity] forKey:@"initial_velocity"]:nil;
    (public_content)? [jsonDict setObject:[NSNumber numberWithBool:public_content] forKey:@"public"]:nil;
    (atom_enabled)? [jsonDict setObject:[NSNumber numberWithBool:atom_enabled] forKey:@"atom_enabled"]:nil;
    (account_id)? [jsonDict setObject:[NSNumber numberWithInt:account_id] forKey:@"account_id"]:nil;
    (featured)? [jsonDict setObject:[NSNumber numberWithBool:featured] forKey:@"featured"]:nil;
    [self sendData:jsonDict toService:@"projects" withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Saved Search endpoint
+(void)getProjectsSearches:(int)project_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/my/searches",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectsSearches:(int)project_id withName:(NSString *)name andQuery:(NSString *)query toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (query)? [jsonDict setObject:query forKey:@"query"]:nil;
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/my/searches",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectSearch:(int)project_id withName:(int)search_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/my/searches/%d",project_id, search_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Search endpoint
+(void)getProjectsSearches:(int)project_id andQuery:(NSString *)query toCallback:(void (^)(id))callback{
    //Needs implementation
}

//Source endpoint
+(void)postSourceCommits:(void (^)(id))callback{
    //Needs implementation
}

//Stories endpoint
+(void)getProjectsSearches:(int)project_id withLabel:(NSString *)with_label withState:(STORY_STATE)with_state withAfterStoryId:(int)after_story_id withBeforeStoryId:(int)before_story_id withAcceptedBefore:(NSDate *)accepted_before withAcceptedAfter:(NSDate *)accepted_after withCreatedBefore:(NSDate *)created_before withCreatedAfter:(NSDate *)created_after withUpdatedBefore:(NSDate *)updated_before withUpdatedAfter:(NSDate *)updated_after withDeadlineBefore:(NSDate *)deadline_before withDeadlineAfter:(NSDate *)deadline_after withLimit:(int)limit withOffset:(int)offset andFilter:(NSString *)filter toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (with_label)? [jsonDict setObject:with_label forKey:@"with_label"]:nil;
    (with_state)? [jsonDict setObject:[self storyStateToString:with_state] forKey:@"with_state"]:nil;
    (after_story_id)? [jsonDict setObject:[NSNumber numberWithBool:after_story_id] forKey:@"after_story_id"]:nil;
    (before_story_id)? [jsonDict setObject:[NSNumber numberWithBool:before_story_id] forKey:@"before_story_id"]:nil;
    (accepted_before)? [jsonDict setObject:accepted_before forKey:@"accepted_before"]:nil;
    (accepted_after)? [jsonDict setObject:accepted_after forKey:@"accepted_after"]:nil;
    (created_before)? [jsonDict setObject:created_before forKey:@"created_before"]:nil;
    (created_after)? [jsonDict setObject:created_after forKey:@"created_after"]:nil;
    (updated_before)? [jsonDict setObject:updated_before forKey:@"updated_before"]:nil;
    (updated_after)? [jsonDict setObject:updated_after forKey:@"updated_after"]:nil;
    (deadline_before)? [jsonDict setObject:deadline_before forKey:@"deadline_before"]:nil;
    (deadline_after)? [jsonDict setObject:deadline_after forKey:@"deadline_after"]:nil;
    (limit)? [jsonDict setObject:[NSNumber numberWithBool:limit] forKey:@"limit"]:nil;
    (offset)? [jsonDict setObject:[NSNumber numberWithBool:offset] forKey:@"offset"]:nil;
    (filter)? [jsonDict setObject:filter forKey:@"filter"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories",project_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectsSearches:(int)project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withTasks:(NSMutableArray *)tasks withFollowerIds:(NSMutableArray *)follower_ids withComments:(NSMutableArray *)comments withCreatedAt:(NSDate *)created_at withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (story_type)? [jsonDict setObject:[self storyTypeToString:story_type] forKey:@"story_type"]:nil;
    (current_state)? [jsonDict setObject:[self storyStateToString:current_state] forKey:@"current_state"]:nil;
    (estimate)? [jsonDict setObject:[NSNumber numberWithFloat:estimate] forKey:@"estimate"]:nil;
    (accepted_at)? [jsonDict setObject:accepted_at forKey:@"accepted_at"]:nil;
    (deadline)? [jsonDict setObject:deadline forKey:@"deadline"]:nil;
    (requested_by_id)? [jsonDict setObject:[NSNumber numberWithInt:requested_by_id] forKey:@"requested_by_id"]:nil;
    (owned_by_id)? [jsonDict setObject:[NSNumber numberWithInt:owned_by_id] forKey:@"owned_by_id"]:nil;
    (owner_ids)? [jsonDict setObject:owner_ids forKey:@"owner_ids"]:nil;
    (labels)? [jsonDict setObject:labels forKey:@"labels"]:nil;
    (label_ids)? [jsonDict setObject:label_ids forKey:@"label_ids"]:nil;
    (tasks)? [jsonDict setObject:tasks forKey:@"tasks"]:nil;
    (follower_ids)? [jsonDict setObject:follower_ids forKey:@"follower_ids"]:nil;
    (comments)? [jsonDict setObject:comments forKey:@"comments"]:nil;
    (created_at)? [jsonDict setObject:created_at forKey:@"created_at"]:nil;
    (before_id)? [jsonDict setObject:[NSNumber numberWithInt:before_id] forKey:@"before_id"]:nil;
    (after_id)? [jsonDict setObject:[NSNumber numberWithInt:after_id] forKey:@"after_id"]:nil;
    (integration_id)? [jsonDict setObject:[NSNumber numberWithInt:integration_id] forKey:@"integration_id"]:nil;
    (external_id)? [jsonDict setObject:external_id forKey:@"external_id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories",project_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Story endpoint
+(void)getProjectStory:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d",project_id, story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectsStory:(int)project_id withStoryID:(int)story_id withComment:(NSMutableArray *)comment withFollowerIds:(NSMutableArray *)follower_ids withGroup:(STORY_GROUP)group withNewProjectId:(int)new_project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (comment)? [jsonDict setObject:comment forKey:@"comment"]:nil;
    (follower_ids)? [jsonDict setObject:follower_ids forKey:@"follower_ids"]:nil;
    (group)? [jsonDict setObject:[self storyGroupToString:group] forKey:@"group"]:nil;
    (new_project_id)? [jsonDict setObject:[NSNumber numberWithInt:new_project_id] forKey:@"project_id"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (story_type)? [jsonDict setObject:[self storyTypeToString:story_type] forKey:@"story_type"]:nil;
    (current_state)? [jsonDict setObject:[self storyStateToString:current_state] forKey:@"current_state"]:nil;
    (estimate)? [jsonDict setObject:[NSNumber numberWithFloat:estimate] forKey:@"estimate"]:nil;
    (accepted_at)? [jsonDict setObject:accepted_at forKey:@"accepted_at"]:nil;
    (deadline)? [jsonDict setObject:deadline forKey:@"deadline"]:nil;
    (requested_by_id)? [jsonDict setObject:[NSNumber numberWithInt:requested_by_id] forKey:@"requested_by_id"]:nil;
    (owned_by_id)? [jsonDict setObject:[NSNumber numberWithInt:owned_by_id] forKey:@"owned_by_id"]:nil;
    (owner_ids)? [jsonDict setObject:owner_ids forKey:@"owner_ids"]:nil;
    (labels)? [jsonDict setObject:labels forKey:@"labels"]:nil;
    (label_ids)? [jsonDict setObject:label_ids forKey:@"label_ids"]:nil;
    (before_id)? [jsonDict setObject:[NSNumber numberWithInt:before_id] forKey:@"before_id"]:nil;
    (after_id)? [jsonDict setObject:[NSNumber numberWithInt:after_id] forKey:@"after_id"]:nil;
    (integration_id)? [jsonDict setObject:[NSNumber numberWithInt:integration_id] forKey:@"integration_id"]:nil;
    (external_id)? [jsonDict setObject:external_id forKey:@"external_id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d",project_id, story_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectStory:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d",project_id, story_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectStoryOwners:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/owners",project_id, story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectStoryOwners:(int)project_id withStoryId:(int)story_id andId:(int)person_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (person_id)? [jsonDict setObject:[NSNumber numberWithInt:person_id] forKey:@"id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/owners",project_id, story_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectStoryOwners:(int)project_id withStoryId:(int)story_id andId:(int)person_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/owners/%d",project_id, story_id, person_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getStory:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"stories/%d",story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putStory:(int)story_id withComment:(NSMutableArray *)comment withFollowerIds:(NSMutableArray *)follower_ids withGroup:(STORY_GROUP)group withNewProjectId:(int)new_project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (comment)? [jsonDict setObject:comment forKey:@"comment"]:nil;
    (follower_ids)? [jsonDict setObject:follower_ids forKey:@"follower_ids"]:nil;
    (group)? [jsonDict setObject:[self storyGroupToString:group] forKey:@"group"]:nil;
    (new_project_id)? [jsonDict setObject:[NSNumber numberWithInt:new_project_id] forKey:@"project_id"]:nil;
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (story_type)? [jsonDict setObject:[self storyTypeToString:story_type] forKey:@"story_type"]:nil;
    (current_state)? [jsonDict setObject:[self storyStateToString:current_state] forKey:@"current_state"]:nil;
    (estimate)? [jsonDict setObject:[NSNumber numberWithFloat:estimate] forKey:@"estimate"]:nil;
    (accepted_at)? [jsonDict setObject:accepted_at forKey:@"accepted_at"]:nil;
    (deadline)? [jsonDict setObject:deadline forKey:@"deadline"]:nil;
    (requested_by_id)? [jsonDict setObject:[NSNumber numberWithInt:requested_by_id] forKey:@"requested_by_id"]:nil;
    (owned_by_id)? [jsonDict setObject:[NSNumber numberWithInt:owned_by_id] forKey:@"owned_by_id"]:nil;
    (owner_ids)? [jsonDict setObject:owner_ids forKey:@"owner_ids"]:nil;
    (labels)? [jsonDict setObject:labels forKey:@"labels"]:nil;
    (label_ids)? [jsonDict setObject:label_ids forKey:@"label_ids"]:nil;
    (before_id)? [jsonDict setObject:[NSNumber numberWithInt:before_id] forKey:@"before_id"]:nil;
    (after_id)? [jsonDict setObject:[NSNumber numberWithInt:after_id] forKey:@"after_id"]:nil;
    (integration_id)? [jsonDict setObject:[NSNumber numberWithInt:integration_id] forKey:@"integration_id"]:nil;
    (external_id)? [jsonDict setObject:external_id forKey:@"external_id"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"stories/%d", story_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteStory:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"stories/%d", story_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Story Task endpoint
+(void)getProjectStoryTasks:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/tasks", project_id, story_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postProjectStoryTasks:(int)project_id andStoryId:(int)story_id withDescription:(NSString *)description withComplete:(BOOL)complete andPosition:(int)position toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (complete)? [jsonDict setObject:[NSNumber numberWithBool:complete] forKey:@"complete"]:nil;
    (position)? [jsonDict setObject:[NSNumber numberWithInt:position] forKey:@"position"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/tasks", project_id, story_id] withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getProjectStoryTask:(int)project_id withStoryId:(int)story_id andTaskId:(int)task_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/tasks/%d", project_id, story_id, task_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteProjectStoryTask:(int)project_id withStoryId:(int)story_id andTaskId:(int)task_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"projects/%d/stories/%d/tasks/%d", project_id, story_id, task_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putProjectStoryTask:(int)project_id withStoryId:(int)story_id withTaskId:(int)task_id withDescription:(NSString *)description withComplete:(BOOL)complete andPosition:(int)position toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (description)? [jsonDict setObject:description forKey:@"description"]:nil;
    (complete)? [jsonDict setObject:[NSNumber numberWithBool:complete] forKey:@"complete"]:nil;
    (position)? [jsonDict setObject:[NSNumber numberWithInt:position] forKey:@"position"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"projects/%d/stories/%d/tasks/%d", project_id, story_id, task_id] withMethod:@"PUT" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

//Workspaces endpoint
+(void)getWorkspaces:(void (^)(id))callback{
    [self sendData:nil toService:@"my/workspaces" withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)postWorkspaces:(NSString *)name andProjectsIds:(NSMutableArray *)projects_ids toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (name)? [jsonDict setObject:name forKey:@"name"]:nil;
    (projects_ids)? [jsonDict setObject:projects_ids forKey:@"projects_ids"]:nil;
    [self sendData:jsonDict toService:@"my/workspaces" withMethod:@"POST" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)getWorkspace:(int)workspace_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"my/workspaces/%d",workspace_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)putWorkspace:(int)workspace_id andProjectsIds:(NSMutableArray *)projects_ids toCallback:(void (^)(id))callback{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc]init];
    (projects_ids)? [jsonDict setObject:projects_ids forKey:@"projects_ids"]:nil;
    [self sendData:jsonDict toService:[NSString stringWithFormat:@"my/workspaces/%d",workspace_id] withMethod:@"GET" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)deleteWorkspace:(int)workspace_id toCallback:(void (^)(id))callback{
    [self sendData:nil toService:[NSString stringWithFormat:@"my/workspaces/%d",workspace_id] withMethod:@"DELETE" andParams:nil toCallback:^(id result) {
        callback(result);
    }];
}

+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method andParams:(NSString*)params toCallback:(void (^)(id))callback
{
    NSURL *url = nil;
    NSMutableURLRequest *request;
    
    if(params.length != 0)
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v5/%@?%@", service, params]];
    }
    else
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v5/%@", service]];
    }
    
    request = [NSMutableURLRequest requestWithURL:url];
    
    
    Configuration *sharedManager = [Configuration sharedManager];
    
    if ([service isEqualToString:@"me"]) {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", sharedManager.userName, sharedManager.userPassword];
        NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedString]];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }else{
        [request setValue:sharedManager.pivotalTrackerAPIToken forHTTPHeaderField:@"X-TrackerToken"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        if(data)
        {
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
            [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:jsonData];
        }
    }
    [request setHTTPMethod:method];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 204)
        {
            callback(@{@"success": @YES});
        }
        else if(!error && response != nil)
        {
            NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            callback(responseJson);
        }
        else
        {
            callback(nil);
        }
    }];
}

+(NSString*)permissionToString:(PERMISSION)permission {
    NSString *result = nil;
    switch(permission) {
        case NONE:
            result = @"none";
            break;
        case PROJECT_CREATION:
            result = @"project_creation";
            break;
        case TIME_KEEPING:
            result = @"time_keeping";
            break;
        case TIME_ENTERING:
            result = @"time_entering";
            break;
        case ADMINISTRATION:
            result = @"administration";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)scopeToString:(SCOPE)scope {
    NSString *result = nil;
    switch(scope) {
        case DONE:
            result = @"DONE";
            break;
        case CURRENT:
            result = @"CURRENT";
            break;
        case BACKLOG:
            result = @"BACKLOG";
            break;
        case CURRENT_BACKLOG:
            result = @"CURRENT_BACKLOG";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)weekDayToString:(WEEK_DAY)week_day{
    NSString *result = nil;
    switch(week_day) {
        case SUNDAY:
            result = @"Sunday";
            break;
        case MONDAY:
            result = @"Monday";
            break;
        case TUESDAY:
            result = @"Tuesday";
            break;
        case WEDNESDAY:
            result = @"Wednesday";
            break;
        case THURSDAY:
            result = @"Thursday";
            break;
        case FRIDAY:
            result = @"Friday";
            break;
        case SATURDAY:
            result = @"Saturday";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)typeExternalIntegrationToString:(TYPE_EXTERNAL_INTEGRATION)type{
    NSString *result = nil;
    switch(type) {
        case BUGZILLA:
            result = @"bugzilla";
            break;
        case GET_SATISFACTION:
            result = @"get_satisfaction";
            break;
        case JIRA:
            result = @"jira";
            break;
        case LIGHTHOUSE:
            result = @"lighthouse";
            break;
        case OTHER:
            result = @"other";
            break;
        case ZENDESK:
            result = @"zenddesk";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)roleToString:(ROLE)role{
    NSString *result = nil;
    switch(role) {
        case OWNER:
            result = @"owner";
            break;
        case MEMBER:
            result = @"member";
            break;
        case VIEWER:
            result = @"viewer";
            break;
        case INACTIVE:
            result = @"inactive";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)webhookVersionToString:(WEBHOOK_VERSION)webhook_version{
    NSString *result = nil;
    switch(webhook_version) {
        case V3:
            result = @"v3";
            break;
        case V5:
            result = @"v5";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)storyStateToString:(STORY_STATE)story_state{
    NSString *result = nil;
    switch(story_state) {
        case ACCEPTED:
            result = @"accepted";
            break;
        case DELIVERED:
            result = @"delivered";
            break;
        case FINISHED:
            result = @"finished";
            break;
        case STARTED:
            result = @"started";
            break;
        case REJECTED:
            result = @"rejected";
            break;
        case PLANNED:
            result = @"planned";
            break;
        case UNSTARTED:
            result = @"unstarted";
            break;
        case UNSCHEDULED:
            result = @"unscheduled";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)storyTypeToString:(STORY_TYPE)story_type{
    NSString *result = nil;
    switch(story_type) {
        case _FEATURE:
            result = @"feature";
            break;
        case _BUG:
            result = @"bug";
            break;
        case _CHORE:
            result = @"chore";
            break;
        case _RELEASE:
            result = @"release";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

+(NSString*)storyGroupToString:(STORY_GROUP)story_group{
    NSString *result = nil;
    switch(story_group) {
        case _SCHEDULED:
            result = @"scheduled";
            break;
        case _UNSCHEDULED:
            result = @"unscheduled";
            break;
        case _CURRENT:
            result = @"current";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }
    return result;
}

@end
