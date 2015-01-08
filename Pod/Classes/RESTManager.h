//
//  RESTManager.h
//  PivotalTracker-IOS-API
//
//  Created by Leonel Perea on 12/04/2014.
//  Copyright (c) 2014 Leonel Perea. All rights reserved.
//

/** Class with the methods for request to the Pivotal Tracker API. */

#import <Foundation/Foundation.h>

@interface RESTManager : NSObject

typedef enum { NONE = 0, PROJECT_CREATION, TIME_KEEPING, TIME_ENTERING, ADMINISTRATION } PERMISSION;
typedef enum { DONE = 0, CURRENT, BACKLOG, CURRENT_BACKLOG } SCOPE;
typedef enum { SUNDAY = 0, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY } WEEK_DAY;
typedef enum { BUGZILLA = 0, GET_SATISFACTION, JIRA, LIGHTHOUSE, OTHER, ZENDESK } TYPE_EXTERNAL_INTEGRATION;
typedef enum { OWNER = 0, MEMBER, VIEWER, INACTIVE } ROLE;
typedef enum { V3 = 0, V5 } WEBHOOK_VERSION;
typedef enum { ACCEPTED = 0, DELIVERED, FINISHED, STARTED, REJECTED, PLANNED, UNSTARTED, UNSCHEDULED } STORY_STATE;
typedef enum { _FEATURE = 0, _BUG, _CHORE, _RELEASE } STORY_TYPE;
typedef enum { _SCHEDULED = 0, _UNSCHEDULED, _CURRENT } STORY_GROUP;

+(NSString*)permissionToString:(PERMISSION)permission;
+(NSString*)scopeToString:(SCOPE)scope;
+(NSString*)weekDayToString:(WEEK_DAY)week_day;
+(NSString*)typeExternalIntegrationToString:(TYPE_EXTERNAL_INTEGRATION)type;
+(NSString*)roleToString:(ROLE)role;
+(NSString*)webhookVersionToString:(WEBHOOK_VERSION)webhook_version;
+(NSString*)storyStateToString:(STORY_STATE)story_state;
+(NSString*)storyTypeToString:(STORY_TYPE)story_type;
+(NSString*)storyGroupToString:(STORY_GROUP)story_group;

+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method andParams:(NSString*)params toCallback:(void (^)(id))callback;

///---------------------
/// @name Account
///---------------------

/** Access the account specified by the account_id value in the URL.
 
 @return Successful responses to this request return the account resource.
 
 @param account_id The ID of the account.
 */
+(void)getAccount:(int)account_id toCallback:(void (^)(id))callback;

///---------------------
/// @name Account Memberships
///---------------------

/** Membership operations.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 */
+(void)getAccountMemberships:(int)account_id toCallback:(void (^)(id))callback;

/** Membership operations.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 @param person_id The ID of the Tracker user to be added to the account.
 @param email The ID of the account.
 @param name The name to be given to a new Tracker user, should a user with the given email address not already exist.
 @param initials The initials to be given to a new Tracker user, should a user with the given email address not already exist.
 @param created_at Creation time.
 @param admin True if the person has administrative rights on the account.
 @param project_creator True if the person is allowed to create new projects within the account.
 @param timekeeper True if the person is allowed to administer time entry by others on the account.
 @param time_enterer  True if the person is expected to enter time for work on projects in the account.
 */
+(void)postAccountMemberships:(int)account_id withPersonId:(int)person_id withEmail:(NSString *)email withName:(NSString *)name withInitials:(NSString *)initials withCreated_at:(double)created_at withAdmin:(BOOL)admin withProject_creator:(BOOL)project_creator withTimekeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_entered toCallback:(void (^)(id))callback;

/** Get an individual account membership, requested by the person_id.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 */
+(void)getIndividualAccountMembership:(int)account_id withPersonId:(int)person_id toCallback:(void (^)(id))callback;

/** Put an individual account membership, requested by the person_id.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 @param admin True if the person has administrative rights on the account.
 @param project_creator True if the person is allowed to create new projects within the account.
 @param timekeeper True if the person is allowed to administer time entry by others on the account.
 @param time_enterer True if the person is expected to enter time for work on projects in the account.
 */
+(void)putIndividualAccountMembership:(int)account_id withPersonId:(int)person_id withAdmin:(BOOL)admin withProjectCreator:(BOOL)project_creator withTimeKeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_entered toCallback:(void (^)(id))callback;

/** Delete an individual account membership, requested by the person_id.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 */
+(void)deleteIndividualAccountMembership:(int)account_id withPersonId:(int)person_id toCallback:(void (^)(id))callback;

///---------------------
/// @name Accounts
///---------------------

/** Access a user's accounts.
 
 @return Successful responses to this request return an array containing zero or more instances of the account resource.
 
 */
+(void)getAccounts:(void (^)(id))callback;

/** Access the account summaries that you are a member of.
 
 @return Successful responses to this request return an array containing zero or more instances of the account_summary resource.
 
 @param with_permision Find accounts where you have the specified permission. Valid enumeration values: none, project_creation, time_keeping, time_entering, administration.
 
 */
+(void)getAccountSumaries:(PERMISSION)with_permision toCallback:(void (^)(id))callback;

///---------------------
/// @name Activity
///---------------------

/** Provides a list of all the activity performed by you.
 
 @return Successful responses to this request return an array containing zero or more instances of an activity-type resource.
 
  @param limit The number of activity items you want returned.
  @param offset Index of the first activity item you want, starting from zero.
  @param occurred_before Activity will be returned only for operations that occurred before the time specified by this parameter.
  @param occurred_after Activity will be returned only for operations that occurred after the time specified by this parameter.
 
 */
+(void)getActivity:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after toCallback:(void (^)(id))callback;

/** Provides a list of all the activity performed on a project.
 
 @return Successful responses to this request return an array containing zero or more instances of an activity-type resource.
 
 @param project_id The ID of the project.
 @param limit The number of activity items you want returned.
 @param offset Index of the first activity item you want, starting from zero.
 @param occurred_before Activity will be returned only for operations that occurred before the time specified by this parameter.
 @param occurred_after Activity will be returned only for operations that occurred after the time specified by this parameter.
 @param since_version Activity will be returned only for operations that occurred after the specified version.
 
 */
+(void)getProjectActivity:(int)project_id withLimit:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after andSinceVersion:(int)since_version toCallback:(void (^)(id))callback;

/** Provides a list of all the activity performed on the story.
 
 @return Successful responses to this request return an array containing zero or more instances of an activity-type resource.
 
 @param project_id The ID of the project.
 @param epic_id The ID of the epic.
 @param limit The number of activity items you want returned.
 @param offset Index of the first activity item you want, starting from zero.
 @param occurred_before Activity will be returned only for operations that occurred before the time specified by this parameter.
 @param occurred_after Activity will be returned only for operations that occurred after the time specified by this parameter.
 @param since_version Activity will be returned only for operations that occurred after the specified version.
 
 */
+(void)getProjectEpicActivity:(int)project_id withEpicId:(int)epic_id withLimit:(int)limit withOffset:(int)offset withOccurredBefore:(NSDate *)occurred_before withOccurredAfter:(NSDate *)occurred_after andSinceVersion:(int)since_version toCallback:(void (^)(id))callback;

///---------------------
/// @name Attachment
///---------------------

/** Operations on an individual file attachment.
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param comment_id The ID of the comment.
 @param file_attachment_id The ID of the file_attachment.
 
 */
+(void)deleteFileAttachment:(int)project_id withStoryId:(int)story_id withCommentId:(int)comment_id andFileAttachmentId:(int)file_attachment_id toCallback:(void (^)(id))callback;

+(void)projectUploadFile:(int)project_id withComment:(NSString *)comment_id andFile:(NSInteger)file toCallback:(void (^)(id))callback;
+(void)projectDownloadFile:(int)file_attachment_id andInline:(BOOL)inLine toCallback:(void (^)(id))callback;

///---------------------
/// @name Comments
///---------------------

/** Index of comments on an individual story.
 
 @return Successful responses to this request return the comment resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 
 */
+(void)getProjectStoryComments:(int)project_id withStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Post a comments on an individual story.
 
 @return Successful responses to this request return the comment resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param text Content of the comment.
 @param person_id The id of the comment creator.
 @param file_attachments This parameter allows file_attachments to be selected by content as part of the basic request. See the 'file_attachment_ids' attribute of the comment resource. The file_attachments' ids must be included.
 @param google_attachments This parameter allows creation of new google_attachments implicitly as part of the basic request. See the 'google_attachment_ids' attribute of the comment resource. The nested google_attachments must not contain an id.
 @param commit_identifier Commit Id on the remote source control system for the comment. Present only on comments that were created by a POST to the source commits API endpoint.
 @param commit_type String identifying the type of remote source control system if Pivotal Tracker can determine it. Present only on comments that were created by a POST to the source commits API endpoint.
 
 */
+(void)postProjectStoryComments:(int)project_id withStoryId:(int)story_id withText:(NSString *)text withFileAttachment:(NSString *)file_attachments withGoogleAttachments:(NSString *)google_attachments withCommitIdentifier:(NSString *)commit_identifier withCommitType:(NSString *)commit_type andPersonId:(int)person_id toCallback:(void (^)(id))callback;

/** Delete a individual comment.
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param comment_id The ID of the comment.
 
 */
+(void)deleteProjectStoryComment:(int)project_id withStoryId:(int)story_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback;

/** Get a individual comment.
 
 @return Successful responses to this request return the comment resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param comment_id The ID of the comment.
 
 */
+(void)getProjectStoryComment:(int)project_id withStoryId:(int)story_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback;

/** Put a individual comment.
 
 @return Successful responses to this request return the comment resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param comment_id The ID of the comment.
 
 */
+(void)putProjectStoryComment:(int)project_id withStoryId:(int)story_id withCommentId:(int)comment_id andText:(NSString *)text toCallback:(void (^)(id))callback;

+(void)getProjectEpicComments:(int)project_id withEpicId:(int)epic_id toCallback:(void (^)(id))callback;

+(void)postProjectEpicComments:(int)project_id withEpicId:(int)epic_id withText:(NSString *)text withFileAttachment:(NSString *)file_attachments withGoogleAttachments:(NSString *)google_attachments withCommitIdentifier:(NSString *)commit_identifier withCommitType:(NSString *)commit_type andPersonId:(int)person_id toCallback:(void (^)(id))callback;

+(void)deleteProjectEpicComment:(int)project_id withEpicId:(int)epic_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback;

+(void)getProjectEpicComment:(int)project_id withEpicId:(int)epic_id andCommentId:(int)comment_id toCallback:(void (^)(id))callback;

+(void)putProjectEpicComment:(int)project_id withEpicId:(int)epicy_id withCommentId:(int)comment_id andText:(NSString *)text toCallback:(void (^)(id))callback;
                                                         
///---------------------
/// @name Epic
///---------------------

/** Operations on an individual epic.
 
 @return Successful responses to this request return the epic resource.
 
 @param project_id The ID of the project.
 @param epic_id The ID of the epic.
 
 */
+(void)getProjectEpic:(int)project_id andEpicId:(int)epic_id toCallback:(void (^)(id))callback;

/** Operations on an individual epic.
 
 @return Successful responses to this request return the epic resource.
 
 @param project_id The ID of the project.
 @param epic_id The ID of the epic.
 @param follower_ids The ids of the project members to follow the epic.
 @param name Name of the epic.
 @param label This parameter allows a label to be selected by content or to be created implicitly as part of the basic request. See the 'label_id' attribute of the epic resource. The label's id must not be included if creating a new one.
 @param label_id id of the epic's label.
 @param description In-depth explanation of the epic's goals, scope, etc.
 @param after_id The Id of the epic preceding the epic.
 @param before_id The Id of the epic following the epic.
 
 */
+(void)putProjectEpic:(int)project_id withEpicId:(int)epic_id withFollowerIds:(int)follower_ids withName:(NSMutableArray *)name withLabel:(NSString *)label withLabelId:(int)label_id withDescription:(NSString *)description withAfterId:(int)after_id andBeforeId:(int)before_id toCallback:(void (^)(id))callback;

/** Operations on an individual epic.
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param epic_id The ID of the epic.
 
 */
+(void)deleteProjectEpic:(int)project_id andEpicId:(int)epic_id toCallback:(void (^)(id))callback;

/** Operations on an individual epic.
 
 @return Successful responses to this request return the epic resource.
 
 @param epic_id The ID of the epic.
 
 */
+(void)getEpic:(int)epic_id toCallback:(void (^)(id))callback;

///---------------------
/// @name Epics
///---------------------

/** Epics operations.
 
 @return Successful responses to this request return an array containing zero or more instances of the epic resource.
 
 @param project_id The ID of the project.
 @param filter This parameter supplies a search string; only epics that match the search criteria are returned. How can a search be refined?
 
 */
+(void)getProjectEpics:(int)project_id andFilter:(NSString *)filter toCallback:(void (^)(id))callback;

/** Epics operations.
 
 @return Successful responses to this request return the epic resource.
 
 @param project_id The ID of the project.
 @param name Name of the epic.
 @param label This parameter allows a label to be selected by content or to be created implicitly as part of the basic request. See the 'label_id' attribute of the epic resource. The label's id must not be included if creating a new one.
 @param label_id id of the epic's label.
 @param description In-depth explanation of the epic's goals, scope, etc.
 @param after_id The Id of the epic preceding the epic.
 @param before_id The Id of the epic following the epic.
 
 */
+(void)postProjectEpics:(int)project_id withName:(NSMutableArray *)name withLabel:(NSString *)label withLabelId:(int)label_id withDescription:(NSString *)description withAfterId:(int)after_id andBeforeId:(int)before_id toCallback:(void (^)(id))callback;

///---------------------
/// @name Export
///---------------------

// Note: Check the return...

/** Returns a project's integration
 
 @return Export the specified project to CSV
 
 @param project_id The ID of the project.
 @param story_ids A list of stories to fetch.
 
 */
+(void)postExportProject:(int)project_id andStories:(NSMutableArray *)story_ids toCallback:(void (^)(id))callback;

/** Create a new integration for a project
 
 @return Export the specified stories (from any number of projects) to CSV
 
 @param story_ids A list of stories to fetch.
 
 */
+(void)postExportStories:(NSMutableArray *)story_ids toCallback:(void (^)(id))callback;

///---------------------
/// @name Iterations
///---------------------

/** Return a set of iterations from the project. (Paginated)
 
 Allows iterations to be retrieved, with optional scope, limit and offset. For the 'Done' scope, a negative offset can be passed, which specifies the number of iterations preceding the 'Current' iteration. Note that iterations are ordered with the oldest (lowest iteration number) first.
 
 @return Successful responses to this request return an array containing zero or more instances of the iteration resource. The response from this request is paginated, see Paginating List Responses.
 
 @param project_id The ID of the project.
 @param offset The offset of first iteration to return, relative to the set of iterations specified by 'scope', with zero being the first iteration in the scope. Defaults to zero. For the 'Done' scope, negative numbers can be passed, which specifies the number of iterations preceding the 'Current' iteration.
 @param label The label to filter on
 @param limit The number of iterations to return relative to the offset.
 @param scope Restricts the state of iterations to return. If not specified, it defaults to all iterations including done. Valid enumeration values: done, current, backlog, current_backlog
 
 */
+(void)getProjectIterations:(int)project_id withOffset:(int)offset withLabel:(NSString *)label withLimit:(int)limit andScope:(SCOPE)scope toCallback:(void (^)(id))callback;

/** Updates an iteration's overrides
 
 Operations on an individual iteration's overrides.
 
 @return Successful responses to this request return the iteration_override resource.
 
 @param project_id The ID of the project.
 @param iteration_number The ID of the iteration.
 @param length Iteration length in weeks.
 @param team_strength Iteration team strength, 1.0 is full-strength.
 
 */
+(void)putProjectIterationsOverrides:(int)project_id withIterationNumber:(int)iteration_number withLenght:(int)length andTeamStrengh:(float)team_strength toCallback:(void (^)(id))callback;

///---------------------
/// @name Labels
///---------------------

/** Provides all of the project's labels.
 
 @return Successful responses to this request return an array containing zero or more instances of the label resource.
 
 @param project_id The ID of the project.
 
 */
+(void)getProjectsLabels:(int)project_id toCallback:(void (^)(id))callback;

/** Provides all of the project's labels.
 
 @return Successful responses to this request return an array containing zero or more instances of the label resource.
 
 @param project_id The ID of the project.
 @param name The label's name.
 
 */
+(void)postProjectsLabels:(int)project_id andName:(NSString *)name toCallback:(void (^)(id))callback;

/** Provides a project label.
 
 @return Successful responses to this request return the label resource.
 
 @param project_id The ID of the project.
 @param label_id The ID of the label.
 
 */
+(void)getProjectLabel:(int)project_id andLabelId:(int)label_id toCallback:(void (^)(id))callback;

/** Updates a project label.
 
 @return Successful responses to this request return the label resource.
 
 @param project_id The ID of the project.
 @param label_id The ID of the label.
 @name name The label's name.
 
 */
+(void)putProjectLabel:(int)project_id withLabelId:(int)label_id andName:(NSString *)name toCallback:(void (^)(id))callback;

/** Delete a project label.
 
 @return Successful responses to this request
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 
 */
+(void)deleteProjectLabel:(int)project_id andLabelId:(int)label_id toCallback:(void (^)(id))callback;

/** Returns the label on a specified story.
 
 @return Successful responses to this request return an array containing zero or more instances of the label resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 
 */
+(void)getProjectStoryLabel:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Returns the label that was created.
 
 @return Successful responses to this request return the label resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param label_id The id of a label that already exists within the project, which should be added to the selected story.
 @param name The label's name.
 
 */
+(void)postProjectStoryLabel:(int)project_id withStoryId:(int)story_id withLabelId:(int)label_id andName:(NSString *)name toCallback:(void (^)(id))callback;

/** Remove the label from the story.
 
 @return Operations on a story label.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param label_id The id of a label that already exists within the project, which should be added to the selected story.
 
 */
+(void)deleteProjectStoryLabel:(int)project_id withStoryId:(int)story_id andLabelId:(int)label_id toCallback:(void (^)(id))callback;

///---------------------
/// @name Me
///---------------------

/** Provides information about the authenticated user. 
 
  @return Successful responses to this request return the me resource.
 
 */
+(void)getMe:(void (^)(id))callback;

///---------------------
/// @name Notifications
///---------------------

//Check date param

/** Return list of the notifications for the authenticated person. Response is sorted by notification created_at, most recent first.
 Provides a list of all notifications.
 
 @return Successful responses to this request return an array containing zero or more instances of the notification resource.
 
 @param created_after Show notifications created after this date/time. If this parameter is not provided, the default is 10 days prior to the request time.
 
 */
+(void)getMyNotifications:(NSDate *)created_after toCallback:(void (^)(id))callback;

/** Marks the authenticated person's notifications as read up to the given notification id.
 
 Marks all notifications read before a notification id.
 
 @return Successful responses to this request return.
 
 @param before Mark all notifications before this id as read.
 
 */
+(void)putMyNotificationsMarkRead:(int)before toCallback:(void (^)(id))callback;

// Checa date param

/** Returns list of the notifications for the specified person whose updated_at values are less than the timestamp. The timestamp provided must match that of an existing notification. If the timestamp value is 0, a default value 10 days before the request time is used. Results are sorted by updated_at, most recent first.
 
 Provides a list of notifications. Unlike most endpoints that allow you to control the response format with url parameters, this endpoint will always return responses with an envelope and a date_format in milliseconds.
 
 @return Successful responses to this request return an array containing zero or more instances of the notification resource.
 
 @param person_id The ID of the person.
 @param timestamp Show notifications created after this timestamp. The timestamp provided must match that of an existing notification. Note that this datetime must be specified in number of milliseconds since the epoch; it does not support ISO 8601 like other datetimes.
 
 */
+(void)getPeopleNotificationsSince:(int)person_id andTimeStamp:(NSDate *)timestamp toCallback:(void (^)(id))callback;

/** Mark the notification as read
 
 Access the notification specified by the notification_id value in the URL.
 
 @return Successful responses to this request return the notification resource.
 
 @param notification_id The ID of the notification.
 @param read_at Time notification was read.
 
 */
+(void)putMyNotificationMarkRead:(int)notification_id andTimeStamp:(NSDate *)read_at toCallback:(void (^)(id))callback;

///---------------------
/// @name Project
///---------------------

/** Fetch the content of specified project
 
 @return Successful responses to this request return an array containing zero or more instances of the notification resource.
 
 @param project_id The ID of the project.
 
 */
+(void)getProject:(int)project_id toCallback:(void (^)(id))callback;

// Check the date param

/** Update the specified project
 
 @return Successful responses to this request return the project resource.
 
 @param project_id The ID of the project.
 @param name The name of the project.
 @param iteration_length The number of weeks in an iteration.
 @param week_start_day The day in the week the project's iterations are to start on.
 @param point_scale The specification for the "point scale" available for entering story estimates within the project. It is specified as a comma-delimited series of values--any value that would be acceptable on the Project Settings page of the Tracker web application may be used here. If an exact match to one of the built-in point scales, the project will use that point scale. If another comma-separated point-scale string is passed, it will be treated as a "custom" point scale. The built-in scales are "0,1,2,3", "0,1,2,4,8", and "0,1,2,3,5,8".
 @param bugs_and_chores_are_estimatable When true, Tracker will allow estimates to be set on Bug- and Chore-type stories. This is strongly not recommended. Please see the FAQ for more information.
 @param automatic_planning When false, Tracker suspends the emergent planning of iterations based on the project's velocity, and allows users to manually control the set of unstarted stories included in the Current iteration. See the FAQ for more information.
 @param enable_tasks When true, Tracker allows individual tasks to be created and managed within each story in the project.
 @param start_date The first day that should be in an iteration of the project. If both this and "week_start_day" are supplied, they must be consistent. It is specified as a string in the format "YYYY-MM-DD" with "01" for January. If this is not supplied, it will remain blank (null), but "start_time" will have a default value based on the stories in the project. If a value is supplied for start_date, but that date is later than the accepted_at date of the earliest accepted story in your project, start_time will be based on the accepted_at date of the earliest accepted story.
 @param time_zone The "native" time zone for the project, independent of the time zone(s) from which members of the project view or modify it.
 @param velocity_averaged_over The number of iterations that should be used when averaging the number of points of Done stories in order to compute the project's velocity.
 @param number_of_done_iterations_to_show There are areas within the Tracker UI and the API in which sets of stories automatically exclude the Done stories contained in older iterations. For example, in the web UI, the DONE panel doesn't necessarily show all Done stories by default, and provides a link to click to cause the full story set to be loaded/displayed. The value of this attribute is the maximum number of Done iterations that will be loaded/shown/included in these areas.
 @param description A description of the project's content. Entered through the web UI on the Project Settings page.
 @param profile_content A long description of the project. This is displayed on the Project Overview page in the Tracker web UI.
 @param enable_incoming_emails When true, the project will accept incoming email responses to Tracker notification emails and convert them to comments on the appropriate stories.
 @param initial_velocity The number which should be used as the project's velocity when there are not enough recent iterations with Done stories for an actual velocity to be computed.
 @param public When true, Tracker will allow any user on the web to view the content of the project. The project will not count toward the limits of a paid subscription, and may be included on Tracker's Public Projects listing page.
 @param atom_enabled When true, Tracker allows people to subscribe to the Atom (RSS, XML) feed of project changes.
 @param account_id The ID number for the account which contains the project.
 @param featured Whether or not the project will be included on Tracker's Featured Public Projects web page.
 
 */
+(void)putProject:(int)project_id withName:(NSString *)name withIterationLeght:(int)iteration_length withWeekStartDay:(WEEK_DAY)week_start_day withPointScale:(NSString *)point_scale withBugsAndChores:(BOOL)bugs_and_chores_are_estimatable withAutomaticPlanning:(BOOL)automatic_planning withEnableTask:(BOOL)enable_tasks withStartDate:(NSDate *)start_date withTimeZone:(NSString *)time_zone withVelocityAverage:(int)velocity_averaged_over withNumberShowIterations:(int)number_of_done_iterations_to_show withDescription:(NSString *)description withProfileContent:(NSString *)profile_content withEnableIncomingEmails:(BOOL)enable_incoming_emails withInitialVelocity:(int)initial_velocity withPublic:(BOOL)public_content withAtomEnable:(BOOL)atom_enabled withAccountId:(int)account_id andFeatured:(BOOL)featured toCallback:(void (^)(id))callback;

/** Permanently delete the specified project
 
 @return Successful responses to this request return the project resource.
 
 @param project_id The ID of the project.
 
 */
+(void)deleteProject:(int)project_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Project Integrations
///----------------------------

/** Returns a project's integrations
 
 @return Successful responses to this request return an array containing zero or more instances of an integration-type resource. In particular, any mix of any of the following: bugzilla_integration, get_satisfaction_integration, jira_integration, lighthouse_integration, other_integration, zendesk_integration.
 
 @param project_id The ID of the project.
 
 */
+(void)getProjectIntegrations:(int)project_id toCallback:(void (^)(id))callback;

/** Returns a project's integrations
 
 @return Successful responses to this request return an array containing zero or more instances of an integration-type resource. In particular, any mix of any of the following: bugzilla_integration, get_satisfaction_integration, jira_integration, lighthouse_integration, other_integration, zendesk_integration.
 
 @param project_id The ID of the project.
 @param type The name of the type of external integration that this resource represents. Valid enumeration values: bugzilla, get_satisfaction, jira, lighthouse, other, zendesk
 @param api_username The username to use to access the external API.
 @param api_password The password to use to access the external API.
 @param zendesk_user_email The email of the Zendesk user which you want to use for integration purposes.
 @param zendesk_user_password The password of the Zendesk user which you want to use for integration purposes.
 @param view_id Only show tickets from the specified Zendesk view.
 @param company Can be found in the URL in your company's community on Satisfaction. For example - http://www.getsatisfaction.com/yourcompany.
 @param product The name of your Bugzilla Product. Use this in conjunction with the component to narrow the bugs to be imported.
 @param component The name of your Bugzilla Component. Use this in conjunction with product to narrow the bugs to be imported.
 @param statuses_to_exclude A comma separated list of status names that should be excluded from the imported bugs. If left blank, all bugs will be imported.
 @param filter_id The ID of the saved JIRA filter to use to load stories.
 @param account Your Lighthouse account name, and can be found in the first part of your Lighthouse URL, for example http://yourcompany.lighthouseapp.com.
 @param external_api_token Your Lighthouse API token.
 @param bin_id Only import tickets from the specified ticket bin.
 @param external_project_id The unique ID of your Lighthouse project, which can be found in a project URL, for example http://yourcompany.lighthouseapp.com/projects/1234-project-name/overview.
 @param import_api_url The URL to import stories from.
 @param basic_auth_username The username to use when importing stories.
 @param basic_auth_password The password to use when importing stories.
 @param comments_private If enabled, comments made by Tracker on the external bug will be marked as private.
 @param update_comments If enabled, comments created in Tracker will be added to the linked ticket or bug.
 @param update_state Adds a state change comment to the linked ticket or bug.
 @param base_url url used for outgoing web links in stories imported via this integration.
 @param name The name given to the particular external integration in the Project Settings pages.
 @param active True if the integration is currently enabled for use.
 
 */
+(void)postProjectIntegrations:(int)project_id withType:(TYPE_EXTERNAL_INTEGRATION)type withAPIUserName:(NSString *)api_username withAPIPassword:(NSString *)api_password withZendeskUserEmail:(NSString *)zendesk_user_email withZendeskUserPassword:(NSString *)zendesk_user_password withViewId:(NSString *)view_id withCompany:(NSString *)company withProduct:(NSString *)product withComponent:(NSString *)component withStatusesToExclude:(NSString *)statuses_to_exclude withFilterId:(NSString*)filter_id withAccount:(NSString *)account withExternalApiToken:(NSString *)external_api_token withBinId:(int)bin_id withExternalProjectId:(int)external_project_id withImportAPIUrl:(NSString *)import_api_url withBasicAuthUsername:(NSString *)basic_auth_username withBasicAuthPassword:(NSString *)basic_auth_password withCommentsPrivate:(BOOL)comments_private withUpdateComments:(BOOL)update_comments withUpdateState:(BOOL)update_state withBaseUrl:(NSString *)base_url withName:(NSString *)name andActive:(BOOL)active toCallback:(void (^)(id))callback;

/** Returns a project integrations
 
 @return Successful responses to this request return an integration-type resource. In particular, any one of the following: bugzilla_integration, get_satisfaction_integration, jira_integration, lighthouse_integration, other_integration, zendesk_integration.
 
 @param project_id The ID of the project.
 @param integration_id The ID of the integration.
 
 */
+(void)getProjectIntegrations:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback;

/** Updates a project integration
 
 @return Successful responses to this request return an integration-type resource. In particular, any one of the following: bugzilla_integration, get_satisfaction_integration, jira_integration, lighthouse_integration, other_integration, zendesk_integration.
 
 @param project_id The ID of the project.
 @param integration_id The ID of the integration.
 @param api_username The username to use to access the external API.
 @param api_password The password to use to access the external API.
 @param zendesk_user_email The email of the Zendesk user which you want to use for integration purposes.
 @param zendesk_user_password The password of the Zendesk user which you want to use for integration purposes.
 @param view_id Only show tickets from the specified Zendesk view.
 @param company Can be found in the URL in your company's community on Satisfaction. For example - http://www.getsatisfaction.com/yourcompany.
 @param product The name of your Bugzilla Product. Use this in conjunction with the component to narrow the bugs to be imported.
 @param component The name of your Bugzilla Component. Use this in conjunction with product to narrow the bugs to be imported.
 @param statuses_to_exclude A comma separated list of status names that should be excluded from the imported bugs. If left blank, all bugs will be imported.
 @param filter_id The ID of the saved JIRA filter to use to load stories.
 @param account Your Lighthouse account name, and can be found in the first part of your Lighthouse URL, for example http://yourcompany.lighthouseapp.com.
 @param external_api_token Your Lighthouse API token.
 @param bin_id Only import tickets from the specified ticket bin.
 @param external_project_id The unique ID of your Lighthouse project, which can be found in a project URL, for example http://yourcompany.lighthouseapp.com/projects/1234-project-name/overview.
 @param import_api_url The URL to import stories from.
 @param basic_auth_username The username to use when importing stories.
 @param basic_auth_password The password to use when importing stories.
 @param comments_private If enabled, comments made by Tracker on the external bug will be marked as private.
 @param update_comments If enabled, comments created in Tracker will be added to the linked ticket or bug.
 @param update_state Adds a state change comment to the linked ticket or bug.
 @param base_url url used for outgoing web links in stories imported via this integration.
 @param name The name given to the particular external integration in the Project Settings pages.
 @param active True if the integration is currently enabled for use.
 
 */
+(void)putProjectIntegrations:(int)project_id withIntegrationId:(int)integration_id withAPIUserName:(NSString *)api_username withAPIPassword:(NSString *)api_password withZendeskUserEmail:(NSString *)zendesk_user_email withZendeskUserPassword:(NSString *)zendesk_user_password withViewId:(NSString *)view_id withCompany:(NSString *)company withProduct:(NSString *)product withComponent:(NSString *)component withStatusesToExclude:(NSString *)statuses_to_exclude withFilterId:(NSString*)filter_id withAccount:(NSString *)account withExternalApiToken:(NSString *)external_api_token withBinId:(int)bin_id withExternalProjectId:(int)external_project_id withImportAPIUrl:(NSString *)import_api_url withBasicAuthUsername:(NSString *)basic_auth_username withBasicAuthPassword:(NSString *)basic_auth_password withCommentsPrivate:(BOOL)comments_private withUpdateComments:(BOOL)update_comments withUpdateState:(BOOL)update_state withBaseUrl:(NSString *)base_url withName:(NSString *)name andActive:(BOOL)active toCallback:(void (^)(id))callback;

/** Delete a project integration
 
 @return Successful responses to this request return.
 
 @param project_id The ID of the project.
 @param integration_id The ID of the integration.
 
 */
+(void)deleteProjectIntegrations:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback;

/** Provides external_story records for all of the potential stories available through the selected integration (already configured on the selected project). The content of the objects returned is suitable for use as parameters to create stories 'imported from' the selected integration.
 
 @return Successful responses to this request return an array containing zero or more instances of the external_story resource.
 
 @param project_id The ID of the project.
 @param integration_id The ID of the integration.
 
 */
+(void)getProjectIntegrationsStories:(int)project_id andProjectIntegrationId:(int)integration_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Project Memberships
///----------------------------

//Check last_viewed_at param

/** Add a user to the project
 
 @return Successful responses to this request return the project_membership resource.
 
 @param project_id The ID of the project.
 @param person_id The ID of the Tracker user to be added to the project.
 @param role The role the user will assume on the project. Valid enumeration values: owner, member, viewer
 @param email The email address of a new/existing Tracker user to be added to this project.
 @param name The name to be given to a new Tracker user, should a user with the given email address not already exist.
 @param initials The initials to be given to a new Tracker user, should a user with the given email address not already exist.
 @param project_color The hex-value color to give the project in multi-project views.
 
 */
+(void)postProjectMemberships:(int)project_id withPersonId:(int)person_id withRole:(ROLE)role withEmail:(NSString *)email withName:(NSString *)name withInitials:(NSString *)initials andProjectColor:(NSString *)project_color toCallback:(void (^)(id))callback;

/** List all of the memberships in a project
 
 @return Successful responses to this request return the project_membership resource.
 
 @param project_id The ID of the project.
 
 */
+(void)getProjectMemberships:(int)project_id toCallback:(void (^)(id))callback;

/** Return the specified project membership
 
 @return Successful responses to this request return the project_membership resource.
 
 @param project_id The ID of the project.
 @param membership_id The ID of the membership.
 
 */
+(void)getProjectMembership:(int)project_id andMembershipId:(int)membership_id toCallback:(void (^)(id))callback;

/** Delete the specified project membership
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param membership_id The ID of the membership.
 
 */
+(void)deleteProjectMembership:(int)project_id andMembershipId:(int)membership_id toCallback:(void (^)(id))callback;

/** Updates the specified project membership
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param membership_id The ID of the membership.
 @param role The role the user will assume on the project. Valid enumeration values: owner, member, viewer
 @param project_color The hex-value color to give the project in multi-project views.
 
 */
+(void)putProjectMembership:(int)project_id withMembershipId:(int)membership_id withRole:(ROLE)role andProjectColor:(NSString *)project_color toCallback:(void (^)(id))callback;

///----------------------------
/// @name Project Webhooks
///----------------------------

/** Return the project's webhooks
 
 @return Successful responses to this request return an array containing zero or more instances of the webhook resource.
 
 @param project_id The ID of the project.
 
 */
+(void)getProjectWebhooks:(int)project_id toCallback:(void (^)(id))callback;

/** Creates a webhook on the project
 
 @return Successful responses to this request return the webhook resource.
 
 @param project_id The ID of the project.
 @param webhook_url The location of the application listening for Tracker events.
 @param webhook_version The version of the API your webhook will interact with. Valid enumeration values: v3, v5
 
 */
+(void)postProjectWebhooks:(int)project_id withWebhookURL:(NSString *)webhook_url andWebhookVersion:(WEBHOOK_VERSION)webhook_version toCallback:(void (^)(id))callback;

/** Return the specified project webhook
 
 @return Successful responses to this request return the webhook resource.
 
 @param project_id The ID of the project.
 @param webhook_id The ID of the webhook.
 
 */
+(void)getProjectWebhook:(int)project_id andWebhookId:(int)webhook_id toCallback:(void (^)(id))callback;

/** Update the specified project webhook
 
 @return Successful responses to this request return the webhook resource.
 
 @param project_id The ID of the project.
 @param webhook_id The ID of the webhook.
 @param webhook_url The location of the application listening for Tracker events.
 @param webhook_version The version of the API your webhook will interact with. Valid enumeration values: v3, v5
 
 */
+(void)putProjectWebhook:(int)project_id withWebhookId:(int)webhook_id withWebhookURL:(NSString *)webhook_url andWebhookVersion:(WEBHOOK_VERSION)webhook_version toCallback:(void (^)(id))callback;

/** Delete the specified project webhook
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param webhook_id The ID of the webhook.
 
 */
+(void)deleteProjectWebhook:(int)project_id andWebhookId:(int)webhook_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Project Webhooks
///----------------------------

/** Get all of user's active project
 
 @return Successful responses to this request return an array containing zero or more instances of the project resource.
 
 @param account_ids A comma separated list of account ids whose projects should be returned.
 */
+(void)getProjects:(NSString *)account_ids toCallback:(void (^)(id))callback;

// Check the date param

/** Create a new empty project
 
 @return Successful responses to this request return the project resource.
 
 @param no_owner By default, the user whose credentials are supplied will be added as a project owner. To leave the project without this owner, supply the no_owner key.
 @param new_account_name If specified, creates a new account with the specified name, and adds the new project to that account.
 @param create_sample Autogenerates a sample project that will allow you to get used to using Tracker.
 @param name The name of the project.
 @param iteration_length The number of weeks in an iteration.
 @param week_start_day The day in the week the project's iterations are to start on.
 @param point_scale The specification for the "point scale" available for entering story estimates within the project. It is specified as a comma-delimited series of values--any value that would be acceptable on the Project Settings page of the Tracker web application may be used here. If an exact match to one of the built-in point scales, the project will use that point scale. If another comma-separated point-scale string is passed, it will be treated as a "custom" point scale. The built-in scales are "0,1,2,3", "0,1,2,4,8", and "0,1,2,3,5,8".
 @param bugs_and_chores_are_estimatable When true, Tracker will allow estimates to be set on Bug- and Chore-type stories. This is strongly not recommended. Please see the FAQ for more information.
 @param automatic_planning When false, Tracker suspends the emergent planning of iterations based on the project's velocity, and allows users to manually control the set of unstarted stories included in the Current iteration. See the FAQ for more information.
 @param enable_tasks When true, Tracker allows individual tasks to be created and managed within each story in the project.
 @param start_date The first day that should be in an iteration of the project. If both this and "week_start_day" are supplied, they must be consistent. It is specified as a string in the format "YYYY-MM-DD" with "01" for January. If this is not supplied, it will remain blank (null), but "start_time" will have a default value based on the stories in the project. If a value is supplied for start_date, but that date is later than the accepted_at date of the earliest accepted story in your project, start_time will be based on the accepted_at date of the earliest accepted story.
 @param time_zone The "native" time zone for the project, independent of the time zone(s) from which members of the project view or modify it.
 @param velocity_averaged_over The number of iterations that should be used when averaging the number of points of Done stories in order to compute the project's velocity.
 @param number_of_done_iterations_to_show There are areas within the Tracker UI and the API in which sets of stories automatically exclude the Done stories contained in older iterations. For example, in the web UI, the DONE panel doesn't necessarily show all Done stories by default, and provides a link to click to cause the full story set to be loaded/displayed. The value of this attribute is the maximum number of Done iterations that will be loaded/shown/included in these areas.
 @param description A description of the project's content. Entered through the web UI on the Project Settings page.
 @param profile_content A long description of the project. This is displayed on the Project Overview page in the Tracker web UI.
 @param enable_incoming_emails When true, the project will accept incoming email responses to Tracker notification emails and convert them to comments on the appropriate stories.
 @param initial_velocity The number which should be used as the project's velocity when there are not enough recent iterations with Done stories for an actual velocity to be computed.
 @param public When true, Tracker will allow any user on the web to view the content of the project. The project will not count toward the limits of a paid subscription, and may be included on Tracker's Public Projects listing page.
 @param atom_enabled When true, Tracker allows people to subscribe to the Atom (RSS, XML) feed of project changes.
 @param account_id The ID number for the account which contains the project.
 @param featured Whether or not the project will be included on Tracker's Featured Public Projects web page.
 
 */
+(void)postProject:(BOOL)no_owner withNewAccountName:(NSString *)new_account_name withCreateSample:(BOOL)create_sample withName:(NSString *)name withIterationLeght:(int)iteration_length withWeekStartDay:(WEEK_DAY)week_start_day withPointScale:(NSString *)point_scale withBugsAndChores:(BOOL)bugs_and_chores_are_estimatable withAutomaticPlanning:(BOOL)automatic_planning withEnableTask:(BOOL)enable_tasks withStartDate:(NSDate *)start_date withTimeZone:(NSString *)time_zone withVelocityAverage:(int)velocity_averaged_over withNumberShowIterations:(int)number_of_done_iterations_to_show withDescription:(NSString *)description withProfileContent:(NSString *)profile_content withEnableIncomingEmails:(BOOL)enable_incoming_emails withInitialVelocity:(int)initial_velocity withPublic:(BOOL)public_content withAtomEnable:(BOOL)atom_enabled withAccountId:(int)account_id andFeatured:(BOOL)featured toCallback:(void (^)(id))callback;

///----------------------------
/// @name Request Aggregator
///----------------------------

/* unimplemented by pivotal tracker */

///----------------------------
/// @name Saved Search
///----------------------------

/** Provides a list of searches which have been saved by the current person.
 
 @return Successful responses to this request return an array containing zero or more instances of the saved_search resource.
 
 @param project_id The ID of the project.
 
 */
+(void)getProjectsSearches:(int)project_id toCallback:(void (^)(id))callback;

/** Saves a new search.
 
 @return Successful responses to this request return the saved_search resource.
 
 @param project_id The ID of the project.
 @param name Name of saved search.
 @param query The search criteria string containing search terms and options which were specified for this saved search.
 
 */
+(void)postProjectsSearches:(int)project_id withName:(NSString *)name andQuery:(NSString *)query toCallback:(void (^)(id))callback;

/** Deletes a saved search.
 
 Deleted a saved search for the currently logged-in person.
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param search_id The ID of the search.
 
 */
+(void)deleteProjectSearch:(int)project_id withName:(int)search_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Search
///----------------------------

/** Search for stories and epics.
 
 GET only; searches the project data and returns the stories and/or epics matching the query_string.
 
 @return Successful responses to this request return the search_result_container resource.
 
 @param project_id The ID of the project.
 @param query String containing the search terms and options.
 
 */
+(void)getProjectsSearches:(int)project_id andQuery:(NSString *)query toCallback:(void (^)(id))callback;

///----------------------------
/// @name Source Commits
///----------------------------

// Check how implement

/** Creates a comment associated with a commit in a Source Control system.
 
 @return Successful responses to this request return the story resource.
 
 @param source_commit The source commit object
 
 */
+(void)postSourceCommits:(void (^)(id))callback;

///----------------------------
/// @name Stories
///----------------------------

//Check date parameters

/** Provides selected stories. (Paginated)
 
 Fetch some or all stories for the specified project.
 
 @return Successful responses to this request return an array containing zero or more instances of the story resource. The response from this request is paginated, see Paginating List Responses.
 
 @param project_id The ID of the project.
 @param with_label A label name which all returned stories must match.
 @param with_state A story's current_state which all returned stories must match. Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled.
 @param after_story_id Filters results to stories that are after the given story id.
 @param before_story_id Filters results to stories that are before the given story id
 @param accepted_before A date and time (ISO 8601 format or milliseconds) which all returned stories are accepted before.
 @param accepted_after A date and time (ISO 8601 format or milliseconds) which all returned stories are accepted after.
 @param created_before A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param created_after A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param updated_before A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param updated_after A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param deadline_before A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param deadline_after A date and time (ISO 8601 format or milliseconds) which all returned stories are created before.
 @param limit The number of stories you want returned.
 @param offset With the first story in your priority list as 0, the index of the first story you want returned.
 @param filter This parameter supplies a search string; only stories that match the search criteria are returned. Cannot be used together with any other parameters.
 
 */
+(void)getProjectsSearches:(int)project_id withLabel:(NSString *)with_label withState:(STORY_STATE)with_state withAfterStoryId:(int)after_story_id withBeforeStoryId:(int)before_story_id withAcceptedBefore:(NSDate *)accepted_before withAcceptedAfter:(NSDate *)accepted_after withCreatedBefore:(NSDate *)created_before withCreatedAfter:(NSDate *)created_after withUpdatedBefore:(NSDate *)updated_before withUpdatedAfter:(NSDate *)updated_after withDeadlineBefore:(NSDate *)deadline_before withDeadlineAfter:(NSDate *)deadline_after withLimit:(int)limit withOffset:(int)offset andFilter:(NSString *)filter toCallback:(void (^)(id))callback;

/** Create a new story
 
 //Check Arrays, see the List[]
 
 @return Successful responses to this request return the story resource.
 
 @param project_id The ID of the project.
 @param name Name of the story.
 @param description In-depth explanation of the story requirements.
 @param with_state A story's current_state which all returned stories must match. Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled.
 @param estimate Point value of the story.
 @param accepted_at Acceptance time.
 @param deadline Due date/time (for a release-type story).
 @param requested_by_id The id of the person who requested the story.
 @param owned_by_id The id of the person who owns the story.
 @param owner_ids IDs of the current story owners.
 @param labels This parameter allows labels to be selected by content or to be created implicitly as part of the basic request. See the 'label_ids' attribute of the story resource. The labels' ids must not be included if creating a new one.
 @param labels_ids This parameter allows labels to be selected by content or to be created implicitly as part of the basic request. See the 'label_ids' attribute of the story resource. The labels' ids must not be included if creating a new one
 @param label_ids IDs of labels currently applied to story.
 @param tasks This parameter allows creation of new tasks implicitly as part of the basic request. See the 'task_ids' attribute of the story resource for how the resources relate. See the parameters of the POST to /projects/{project_id}/stories/{story_id}/tasks operation for keys that can be included in the nested hash in the parameters. The nested tasks must not contain an id.
 @param follower_ids IDs of people currently following the story.
 @param comments This parameter allows creation of new comments implicitly as part of the basic request. See the 'comment_ids' attribute of the story resource for how the resources relate. See the parameters of the POST to /projects/{project_id}/stories/{story_id}/comments operation for keys that can be included in the nested hash in the parameters. The nested comments must not contain an id.
 @param created_at Creation Time
 @param before_id ID of the story that the current story is located before. Null if story is last one in the project.
 @param after_id ID of the story that the current story is located after. Null if story is the first one in the project.
 @param integration_id ID of the integration API that is linked to this story.
 @param external_id The integration's specific ID for the story.
 
 */
+(void)postProjectsSearches:(int)project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withTasks:(NSMutableArray *)tasks withFollowerIds:(NSMutableArray *)follower_ids withComments:(NSMutableArray *)comments withCreatedAt:(NSDate *)created_at withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Story
///----------------------------

// Operations on an individual story.

/** Creates a comment associated with a commit in a Source Control system.
 
 @return Successful responses to this request return the story resource.
 
 @param source_commit The source commit object
 @param story_id The IF of the story
 
 */
+(void)getProjectStory:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Updates the specified story
 
 //Check Arrays, see the List[], check object type
 
 @return Successful responses to this request return the story resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story
 @param comment The content for a new comment to create. May contain nested attachments, but must not contain id values.
 @param follower_ids IDs of people currently following the story.
 @param group Should be supplied when specifying the story's before_id and/or after_id. Valid enumeration values: scheduled, unscheduled, current
 @param new_project_id The value that the story's project_id should be updated to. Has the effect of moving the story being updated into that project from its current one.
 @param name Name of the story.
 @param description In-depth explanation of the story requirements.
 @param story_type Type of story. Valid enumeration values: feature, bug, chore, release
 @param current_state A story's current_state which all returned stories must match. Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled.
 @param estimate Point value of the story.
 @param accepted_at Acceptance time.
 @param deadline Due date/time (for a release-type story).
 @param requested_by_id The id of the person who requested the story.
 @param owned_by_id The id of the person who owns the story.
 @param owner_ids IDs of the current story owners.
 @param labels This parameter allows labels to be selected by content or to be created implicitly as part of the basic request. See the 'label_ids' attribute of the story resource. The labels' ids must not be included if creating a new one.
 @param label_ids IDs of labels currently applied to story.
 @param before_id ID of the story that the current story is located before. Null if story is last one in the project.
 @param after_id ID of the story that the current story is located after. Null if story is the first one in the project.
 @param integration_id ID of the integration API that is linked to this story.
 @param external_id The integration's specific ID for the story.
 
 */
+(void)putProjectsStory:(int)project_id withStoryID:(int)story_id withComment:(NSMutableArray *)comment withFollowerIds:(NSMutableArray *)follower_ids withGroup:(STORY_GROUP)group withNewProjectId:(int)new_project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback;

/** Deletes a story
 
 @return Successful responses to this request.
 
 @param source_commit The source commit object
 @param story_id The ID of the story
 
 */
+(void)deleteProjectStory:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Returns the owners of a specific story
 
 @return Successful responses to this request.
 
 @param source_commit The source commit object
 @param story_id The ID of the story
 
 */
+(void)getProjectStoryOwners:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Add a user as an owner of the story
 
 @return Successful responses to this request return an array containing zero or more instances of the person resource.
 
 @param source_commit The source commit object
 @param story_id The ID of the story
 @param id ID of the person to be added
 
 */
+(void)postProjectStoryOwners:(int)project_id withStoryId:(int)story_id andId:(int)person_id toCallback:(void (^)(id))callback;

/** Removes ownerships of a story from a person.
 
 @return Successful responses to this request return.
 
 @param source_commit The source commit object
 @param story_id The ID of the story
 @param id ID of the person to be added
 
 */
+(void)deleteProjectStoryOwners:(int)project_id withStoryId:(int)story_id andId:(int)person_id toCallback:(void (^)(id))callback;

/** Returns the specified story.
 
 @return Successful responses to this request return the story resource.
 
 @param story_id The ID of the story
 
 */
+(void)getStory:(int)story_id toCallback:(void (^)(id))callback;

/** Updates the specified story.
 
 @return Successful responses to this request return the story resource.
 
 @param story_id The ID of the story
 @param comment The content for a new comment to create. May contain nested attachments, but must not contain id values.
 @param follower_ids IDs of people currently following the story.
 @param group Should be supplied when specifying the story's before_id and/or after_id. Valid enumeration values: scheduled, unscheduled, current
 @param new_project_id The value that the story's project_id should be updated to. Has the effect of moving the story being updated into that project from its current one.
 @param name Name of the story.
 @param description In-depth explanation of the story requirements.
 @param story_type Type of story. Valid enumeration values: feature, bug, chore, release
 @param current_state A story's current_state which all returned stories must match. Valid enumeration values: accepted, delivered, finished, started, rejected, planned, unstarted, unscheduled.
 @param estimate Point value of the story.
 @param accepted_at Acceptance time.
 @param deadline Due date/time (for a release-type story).
 @param requested_by_id The id of the person who requested the story.
 @param owned_by_id The id of the person who owns the story.
 @param owner_ids IDs of the current story owners.
 @param labels This parameter allows labels to be selected by content or to be created implicitly as part of the basic request. See the 'label_ids' attribute of the story resource. The labels' ids must not be included if creating a new one.
 @param label_ids IDs of labels currently applied to story.
 @param before_id ID of the story that the current story is located before. Null if story is last one in the project.
 @param after_id ID of the story that the current story is located after. Null if story is the first one in the project.
 @param integration_id ID of the integration API that is linked to this story.
 @param external_id The integration's specific ID for the story.
 
 */
+(void)putStory:(int)story_id withComment:(NSMutableArray *)comment withFollowerIds:(NSMutableArray *)follower_ids withGroup:(STORY_GROUP)group withNewProjectId:(int)new_project_id withName:(NSString *)name withDescription:(NSString *)description withStoryType:(STORY_TYPE)story_type withCurrentState:(STORY_STATE)current_state withEstimate:(float)estimate withAcceptedAt:(NSDate *)accepted_at withDeadline:(NSDate *)deadline withRequestById:(int)requested_by_id withOwnedById:(int)owned_by_id withOwnersIds:(NSMutableArray *)owner_ids withLabels:(NSMutableArray *)labels withLabelsIds:(NSMutableArray *)label_ids withBeforeId:(int)before_id withAfterId:(int)after_id withIntegrationId:(int)integration_id andExternalId:(NSString *)external_id toCallback:(void (^)(id))callback;

/** Delete the specified story.
 
 @return Successful responses to this request.
 
 @param story_id The ID of the story
 
 */
+(void)deleteStory:(int)story_id toCallback:(void (^)(id))callback;

///----------------------------
/// @name Story Tasks
///----------------------------

/** Returns the task on a specified story.
 
 @return Successful responses to this request return an array containing zero or more instances of the task resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 
 */
+(void)getProjectStoryTasks:(int)project_id andStoryId:(int)story_id toCallback:(void (^)(id))callback;

/** Returns the task that was created.
 
 @return Successful responses to this request return an array containing zero or more instances of the task resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param description Content of the task
 @param complete Flag showing the completion of the task.
 @param position Offset from the top of the task list. Positions start counting from 1 for the first task on a story.
 
 */
+(void)postProjectStoryTasks:(int)project_id andStoryId:(int)story_id withDescription:(NSString *)description withComplete:(BOOL)complete andPosition:(int)position toCallback:(void (^)(id))callback;

/** Returns the specified task on a specified story
 
 @return Successful responses to this request return the task resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param task_id The ID of the task.
 
 */
+(void)getProjectStoryTask:(int)project_id withStoryId:(int)story_id andTaskId:(int)task_id toCallback:(void (^)(id))callback;

/** Deletes the specified task
 
 @return Successful responses to this request.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param task_id The ID of the task.
 
 */
+(void)deleteProjectStoryTask:(int)project_id withStoryId:(int)story_id andTaskId:(int)task_id toCallback:(void (^)(id))callback;

/** Updates the specified task
 
 @return Successful responses to this request return the task resource.
 
 @param project_id The ID of the project.
 @param story_id The ID of the story.
 @param task_id The ID of the task.
 @param description Content of the task
 @param complete Flag showing the completion of the task.
 @param position Offset from the top of the task list. Positions start counting from 1 for the first task on a story.
 
 */
+(void)putProjectStoryTask:(int)project_id withStoryId:(int)story_id withTaskId:(int)task_id withDescription:(NSString *)description withComplete:(BOOL)complete andPosition:(int)position toCallback:(void (^)(id))callback;

///----------------------------
/// @name Workspaces
///----------------------------

/** Return list of workspaces for the authenticated person.
 
 @return Successful responses to this request return an array containing zero or more instances of the workspace resource.
 
 */
+(void)getWorkspaces:(void (^)(id))callback;

/** Create a new wokspaces for the authenticated person.
 
 @return Successful responses to this request return an array containing zero or more instances of the workspace resource.
 
 @param name The name of the workspace.
 @param project_ids Array of projects contained in the workspace.
 
 */
+(void)postWorkspaces:(NSString *)name andProjectsIds:(NSMutableArray *)projects_ids toCallback:(void (^)(id))callback;

/** Return a workspace for the authenticated person.
 
 @return Successful responses to this request return the workspace resource.
 
 @param workspace_id The ID of the workspace.
 
 */
+(void)getWorkspace:(int)workspace_id toCallback:(void (^)(id))callback;

/** Update the specified workspace.
 
 @return Successful responses to this request return the workspace resource.
 
 @param workspace_id The ID of the workspace.
 @param projects_ids The list of projects to associate with this workspace.
 
 */
+(void)putWorkspace:(int)workspace_id andProjectsIds:(NSMutableArray *)projects_ids toCallback:(void (^)(id))callback;

/** Permanently delete the workspace
 
 @return Successful responses to this request return the workspace resource.
 
 @param workspace_id The ID of the workspace.
 
 */
+(void)deleteWorkspace:(int)workspace_id toCallback:(void (^)(id))callback;

@end
