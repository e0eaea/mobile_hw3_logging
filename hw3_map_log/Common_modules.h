//
//  Common_modules.h
//  IAM_IOS_ObjectiveC
//
//  Created by KMK on 2016. 4. 11..
//  Copyright © 2016년 KMK. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface Common_modules : NSObject

+(NSString*)transToJson:(NSDictionary*) userData;

+ (UIAlertController*) alert_show:(NSString*)title message:(NSString*)message yes:(NSString*)yes no:(NSString*)no;
@end
