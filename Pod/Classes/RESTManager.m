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

+(void)sendData:(NSMutableDictionary *)data toService:(NSString *)service withMethod:(NSString *)method isTesting:(BOOL)testing withAccessToken:(NSString *)accessToken toCallback:(void (^)(id))callback
{
    NSURL *url = nil;
    NSMutableURLRequest *request;
    
    url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v5/%@", service]];
    
    request = [NSMutableURLRequest requestWithURL:url];
    
    if ([service isEqualToString:@"me"]) {
        Configuration *sharedManager = [Configuration sharedManager];
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", sharedManager.userName, sharedManager.userPassword];
        NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedString]];
        [request setHTTPMethod:method];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }else{
        if(accessToken && data)
        {
            //[data setObject:@"here username" forKey:@"username"];
            //[data setObject:@"here password" forKey:@"password"];
        }
        if(data)
        {
            /*
             NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:kNilOptions error:nil];
             
             NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
             NSLog(@"json string: %@", JSONString);
             [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
             [request setHTTPBody:jsonData];*/
        }
    }
    
    
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

+getMe: (void (^)(id))callback{
    Configuration *sharedManager = [Configuration sharedManager];
    [self sendData:nil toService:@"me" withMethod:@"GET" isTesting:NO withAccessToken:sharedManager.pivotalTrackerAPIToken toCallback:^(id result) {
        callback(result);
    }];
}

@end
