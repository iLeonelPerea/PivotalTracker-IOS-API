//
//  PTAppDelegate.m
//  PivotalTracker-IOS-API
//
//  Created by CocoaPods on 12/04/2014.
//  Copyright (c) 2014 Leonel Perea. All rights reserved.
//

#import "PTAppDelegate.h"
#import <PivotalTracker-IOS-API/RESTManager.h>
#import <PivotalTracker-IOS-API/Configuration.h>

@implementation PTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    Configuration *sharedManager = [Configuration sharedManager];
    sharedManager.pivotalTrackerAPIToken = @"4175aa1a1eae67ea8a6a89e3fd5f6aae";
    sharedManager.userName = @"ileonelperea";
    sharedManager.userPassword = @"@Pivotaltracker_Leo.87";
    
    __block NSDictionary * results;
    
    // ----- ACCOUNT ENDPOINT -----
    //  account stufs id -> 715874
    /*
    [RESTManager getAccount:715874 toCallback:^(id result) {
        results = result;
        NSLog(@"getAccount done");
    }];
     */
    
    // ----- ACCOUNT MEMBERSHIPS ENDPOINT -----
    /*
    [RESTManager getAccountMemberships:715874 toCallback:^(id result) {
        results = result;
        NSLog(@"getAccountMemberships done");
    }];
    
    Id account omar -> 1431836
     *Falta crear un nuevo usuario y agregarlo
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
        NSDate *date = [dateFormat dateFromString:@"2014-12-28T21:54:27Z"];
    
        NSTimeInterval seconds = [date timeIntervalSince1970];
        double milliseconds = seconds*1000;
    
        //Reparar error milisegundo o de timepo
        [RESTManager postAccountMemberships:715874 withPersonId:1431836 withEmail:nil withName:nil withInitials:nil withCreated_at:milliseconds withAdmin:YES withProject_creator:YES withTimekeeper:YES withTimeEntered:YES toCallback:^(id result) {
            results = result;
            NSLog(@"postAccountMemberships done");
        }];
    
    [RESTManager getIndividualAccountMembership:715874 withPersonId:1431836 toCallback:^(id result) {
        results = result;
        NSLog(@"getIndividualAccountMembership done");
     }];
     
    [RESTManager putIndividualAccountMembership:715874 withPersonId:1431836 withAdmin:YES withProjectCreator:NO withTimeKeeper:NO withTimeEntered:nil toCallback:^(id result) {
        results = result;
        NSLog(@"putIndividualAccountMembership done");
     }];
    
    [RESTManager deleteIndividualAccountMembership:715874 withPersonId:1431836 toCallback:^(id result) {
        results = result;
        NSLog(@"deleteIndividualAccountMembership done");
     }];
     */
    
    // ----- ACCOUNTS ENDPOINT -----
    /*
    [RESTManager getAccounts:^(id result) {
        results = result;
        NSLog(@"getAccounts done");
    }];
     
    [RESTManager getAccountSumaries:PROJECT_CREATION toCallback:^(id result) {
        results = result;
        NSLog(@"getAccounts done");
    }];
     */

    // ----- ACTIVITY ENDPOINT -----
    /*
    [RESTManager getActivity:5 withOffset:2 withOccurredBefore:nil withOccurredAfter:nil toCallback:^(id result) {
        results = result;
        NSLog(@"getActivity done");
    }];
    */
    
    /*
    [RESTManager getProjectActivity:1192970 withLimit:5 withOffset:2 withOccurredBefore:nil withOccurredAfter:nil andSinceVersion:200 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectActivity done");
    }];
    */
    
    /*
    [RESTManager getProjectStoryActivity:1192970 withStoryId:84961662 withLimit:5 withOffset:2 withOccurredBefore:nil withOccurredAfter:nil andSinceVersion:200 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectStoryActivity done");
    }];
     */
    
    /*
    [RESTManager getProjectEpicActivity:1233334 withEpicId:1589974 withLimit:nil withOffset:nil withOccurredBefore:nil withOccurredAfter:nil andSinceVersion:nil toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectStoryActivity done");
    }];
     */
    
    // ----- ATTACHMENT ENDPOINT -----
    //coomentId -> 88500872
    /*
    [RESTManager deleteFileAttachment:1233334 withStoryId:85294376 withCommentId:<#(int)#> andFileAttachmentId:<#(int)#> toCallback:<#^(id)callback#>  toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectStoryActivity done");
    }];*/
    
    // ----- COMMENTS ENDPOINT -----
    /*
    [RESTManager getProjectStoryComments:1233334 withStoryId:85294376 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectStoryComments done");
    }];
    */
    
    /*
    [RESTManager postProjectStoryComments:1233334 withStoryId:85294376 withText:@"Este es un comentario" withFileAttachment:nil withGoogleAttachments:nil withCommitIdentifier:nil withCommitType:nil andPersonId:1431832 toCallback:^(id result) {
        results = result;
        NSLog(@"postProjectStoryComments done");
    }];
    */
    //88502300
    /*
    [RESTManager deleteProjectStoryComment:1233334 withStoryId:85294376 andCommentId:88502300 toCallback:^(id result) {
        results = result;
        NSLog(@"deleteProjectStoryComment done");
    }];
    */
    
    /*
    [RESTManager getProjectStoryComment:1233334 withStoryId:85294376 andCommentId:88502300 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectStoryComment done");
    }];
    */
    
    /*
    [RESTManager putProjectStoryComment:1233334 withStoryId:85294376 withCommentId:88502300 andText:@"this us a update of a comment" toCallback:^(id result) {
        results = result;
        NSLog(@"putProjectStoryComment done");
    }];
    */
    
    /*
    [RESTManager getProjectEpicComments:1233334 withEpicId:1589974 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectEpicComments done");
    }];
     */
    
    // ----- EPIC ENDPOINT -----
    /*
    [RESTManager getProjectEpic:1233334 andEpicId:1589974 toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectEpic done");
    }];
     */
    
    /*
    [RESTManager putProjectEpic:1233334 withEpicId:1589974 withFollowerIds:nil withName:nil withLabel:nil withLabelId:nil withDescription:@"Description of a epic" withAfterId:nil andBeforeId:nil toCallback:^(id result) {
        results = result;
        NSLog(@"putProjectEpic done");
    }];
     */
    
    /*
    [RESTManager deleteProjectEpic:1233334 andEpicId:1589974 toCallback:^(id result) {
        results = result;
        NSLog(@"deleteProjectEpic done");
    }];
     */
    
    /*
    [RESTManager getEpic:1589974 toCallback:^(id result) {
        results = result;
        NSLog(@"getEpic done");
    }];
    */
    
    // ----- EPICS ENDPOINT -----
    [RESTManager getProjectEpics:1233334 andFilter:nil toCallback:^(id result) {
        results = result;
        NSLog(@"getProjectEpics done");
    }];
    
    // ----- ME ENDPOINT -----
    /*
    [RESTManager getMe: ^(id result) {
        results = result;
        NSLog(@"getMe done");
    }];
    */

    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
