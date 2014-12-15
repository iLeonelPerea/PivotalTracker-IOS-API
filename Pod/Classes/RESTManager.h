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

+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method isTesting:(BOOL)testing withAccessToken:(NSString *)accessToken toCallback:(void (^)(id))callback;

///---------------------
/// @name Account
///---------------------

/** Access the account specified by the account_id value in the URL.
 
 @return Successful responses to this request return the account resource.
 
 @param account_id The ID of the account.
 */
+(NSDictionary *)getAccount:(int)account_id;

///---------------------
/// @name Account Memberships
///---------------------

/** Membership operations.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 */
+(NSDictionary *)getAccountMemberships:(int)account_id;

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
+(NSDictionary *)postAccountMemberships:(int)account_id withPersonId:(int)person_id withEmail:(NSString *)email withName:(NSString *)name withInitials:(NSString *)initials withCreated_at:(NSDate *)created_at withAdmin:(BOOL)admin withProject_creator:(BOOL)project_creator withTimekeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_entered;

/** Get an individual account membership, requested by the person_id.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 */
+(NSDictionary *)getIndividualAccountMembership:(int)account_id withPersonId:(int)person_id;

/** Put an individual account membership, requested by the person_id.
 
 @return Successful responses to this request return the account_membership resource.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 @param admin True if the person has administrative rights on the account.
 @param project_creator True if the person is allowed to create new projects within the account.
 @param timekeeper True if the person is allowed to administer time entry by others on the account.
 @param time_enterer True if the person is expected to enter time for work on projects in the account.
 */
+(NSDictionary *)putIndividualAccountMembership:(int)account_id withPersonId:(int)person_id withAdmin:(BOOL)admin withProjectCreator:(BOOL)project_creator withTimeKeeper:(BOOL)timekeeper withTimeEntered:(BOOL)time_enterer;

/** Delete an individual account membership, requested by the person_id.
 
 @param account_id The ID of the account.
 @param person_id The ID of the person.
 */
+(void)deleteIndividualAccountMembership:(int)account_id withPersonId:(int)person_id;

///---------------------
/// @name Accounts
///---------------------

/** Access a user's accounts.
 
 @return Successful responses to this request return an array containing zero or more instances of the account resource.
 
 */
+(NSDictionary *)getAccounts;

/** Access the account summaries that you are a member of.
 
 @return Successful responses to this request return an array containing zero or more instances of the account_summary resource.
 
 @param with_permision Find accounts where you have the specified permission. Valid enumeration values: none, project_creation, time_keeping, time_entering, administration.
 
 */
+(NSDictionary *)getAccountSumaries:(NSString *)with_permision;

///---------------------
/// @name Me
///---------------------

/** Provides information about the authenticated user.
 
 
 
 */
+getMe:(void (^)(id))callback;

@end
