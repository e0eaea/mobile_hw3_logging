//
//  AppDelegate.m
//  hw3_map_log
//
//  Created by KMK on 2016. 6. 6..
//  Copyright © 2016년 KMK. All rights reserved.
//


#import "AppDelegate.h"

@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyD7rhu51vOD3EtRz9KId6nw6syIvOGzSlE"];
    
    
    return YES;
}


- (void)connectToServer:(NSString*)jsonString url:(NSString *)urlString {
    
    NSLog(@"ConnectToServer With Json, URL");
    //Formatting the URL
    //NSString *urlAsString = kSend;
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Structuring the URL request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //[urlRequest setValue:[NSString stringWithFormat:@"Basic %@",authValue] forHTTPHeaderField:@"Authorization"];
    
    //    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:urlRequest
                                     completionHandler:^(NSData *data,NSURLResponse *response,NSError *connectionError) {
                                         
                                         
                                         if ([data length] > 0 && connectionError == nil) {
                                             
                                             
                                             NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                             
                                             
                                             NSError *error;
                                             NSDictionary *diction = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
                                             
                                             // NSString *method = [diction valueForKey:@"type"];
                                             
                                             if (connectionError!=nil){
                                                 
                                                 NSLog(@"Error happened = %@",connectionError);
                                                 
                                             }
                                             if([urlString isEqualToString:@"http://52.78.1.207:3000/latest_log"])
                                             {
                                                 NSLog(@"받아온값 %@",diction);
                                                 
                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"download_location"  object:nil userInfo:diction];
                                                 
                                                
                                             }
                                             
                                             

                                         }}] resume];
      
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
