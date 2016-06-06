//
//  Common_modules.m
//  IAM_IOS_ObjectiveC
//
//  Created by KMK on 2016. 4. 11..
//  Copyright © 2016년 KMK. All rights reserved.
//

#import "Common_modules.h"


@implementation Common_modules

+(NSString*)transToJson:(NSDictionary*) userData{
    
    NSError *error = nil;
    //Serialize the JSON data
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userData options:0 error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        //Create a string from the JSON Data
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@", jsonString);
        return jsonString;
    }
    else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after the serialization");
    }
    else if (error != nil){
        NSLog(@"An error happened = %@",error);
    }
    return nil;
}


+ (UIAlertController*) alert_show:(NSString*)title message:(NSString*)message yes:(NSString*)yes no:(NSString*)no
{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    if([yes isEqualToString:@""])
        yes=@"확인";
    
           
           UIAlertAction* yesButton = [UIAlertAction
                                       actionWithTitle:yes
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           //Handel your yes please button action here
                                           
                                           
                                       }];
           
            [alert addAction:yesButton];
    
    
    
    if(![no isEqualToString:@""])
    {
        
           
           UIAlertAction* noButton = [UIAlertAction
                                      actionWithTitle:no
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          //Handel no, thanks button
                                          
                                      }];
           
          
           [alert addAction:noButton];
       }
    
    return alert;
}
       

@end
