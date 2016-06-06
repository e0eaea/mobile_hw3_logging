//
//  AppDelegate.h
//  hw3_map_log
//
//  Created by KMK on 2016. 6. 6..
//  Copyright © 2016년 KMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Size_Define.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)connectToServer:(NSString*)jsonString url:(NSString *)urlString;


@end

