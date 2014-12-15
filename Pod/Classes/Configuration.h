//
//  Configuration.h
//  PivotalTracker-IOS-API
//
//  Created by Leonel Perea on 12/04/2014.
//  Copyright (c) 2014 Leonel Perea. All rights reserved.
//

/** Singleton Class with properties for request to the Pivotal Tracker API. */

#import <Foundation/Foundation.h>

@interface Configuration : NSObject

@property (nonatomic, strong) NSString * pivotalTrackerAPIToken;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userPassword;

///---------------------
/// @name Account
///---------------------

/** Access the account specified by the account_id value in the URL.
 
 @return Successful responses to this request return the account resource.
 
 @param account_id The ID of the account.
 */
+ (id)sharedManager;

@end
