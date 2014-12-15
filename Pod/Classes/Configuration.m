//
//  Configuration.m
//  PivotalTracker-IOS-API
//
//  Created by Leonel Perea on 12/04/2014.
//  Copyright (c) 2014 Leonel Perea. All rights reserved.
//

#import "Configuration.h"

@implementation Configuration

@synthesize pivotalTrackerAPIToken, userName, userPassword;

#pragma mark Singleton Methods
+ (id)sharedManager {
    static Configuration *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
