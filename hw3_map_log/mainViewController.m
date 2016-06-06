//
//  mainViewController.m
//  hw3_map_log
//
//  Created by KMK on 2016. 6. 6..
//  Copyright © 2016년 KMK. All rights reserved.
//

#import "mainViewController.h"
#import "Common_modules.h"
#import "AppDelegate.h"
#import "ViewController.h"

@import GoogleMaps;

@interface mainViewController ()<CLLocationManagerDelegate>
@property (nonatomic) NSTimer* timer;
@property (nonatomic, retain) UIActivityIndicatorView *registrationProgressing;
@property (strong, nonatomic) UIView * blind_view;

@end

@implementation mainViewController
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(download_success:)
                                                 name:@"download_location"
                                               object:nil];
    
}


- (void) logging_thread:(NSTimer *)theTimer
{
   
    locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    

    
    NSDateFormatter *now=[[NSDateFormatter alloc]init];
    [now setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    
    NSTimeZone *krTimeZone =[NSTimeZone timeZoneWithName:@"Asia/Seoul"];
    [now setTimeZone:krTimeZone];
    
    NSString *date =[now stringFromDate:[NSDate date]];
    
    NSArray *dictionKeys = @[@"date",@"latitude",@"longitude"];
    NSArray *dictionVals = @[date,[NSString stringWithFormat:@"%f",coordinate.latitude],[NSString stringWithFormat:@"%f",coordinate.longitude]];
    
    NSDictionary *client_data = [NSDictionary dictionaryWithObjects:dictionVals forKeys:dictionKeys];
    
    
    NSString *userJsonData = [Common_modules transToJson:client_data];
   
    NSLog(@"로그남깁니다. %@",userJsonData);
    
  [[[UIApplication sharedApplication] delegate] performSelector:@selector(connectToServer:url:) withObject:userJsonData withObject:@"http://52.78.1.207:3000/log"];
    
}
- (IBAction)request_server_log:(id)sender {
}


- (IBAction)setting_5_timer:(id)sender {
    //5분마다 log를 남기는 쓰레드 돌림
    _timer = [NSTimer scheduledTimerWithTimeInterval:300 target:self
                                            selector:@selector(logging_thread:) userInfo:nil repeats:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)latest_location:(id)sender {
    
    [[[UIApplication sharedApplication] delegate] performSelector:@selector(connectToServer:url:) withObject:nil withObject:@"http://52.78.1.207:3000/latest_log"];
   
    
    self.view.userInteractionEnabled=NO;
    _registrationProgressing = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_registrationProgressing setFrame:CGRectMake((WINDOW_WIDTH / 2) - 50, (WINDOW_HEIGHT / 2) - 50, 100, 100)];
    _registrationProgressing.hidesWhenStopped = YES;
    [_registrationProgressing startAnimating];
    
    
    _blind_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)];
    
    [_blind_view setBackgroundColor:[UIColor blackColor]];
    [_blind_view setAlpha:0.7];
    [self.view addSubview:_blind_view];
    
    [self.view addSubview:_registrationProgressing];
    
    
}

- (void) download_success:(NSNotification *) notification
{
    
    [_registrationProgressing stopAnimating];
    [_registrationProgressing removeFromSuperview];
    [_blind_view removeFromSuperview];
    self.view.userInteractionEnabled=YES;
    
    NSLog(@"딜리게이트받음");
    
   
    dispatch_async(dispatch_get_main_queue(), ^{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];

    NSString * latitude=[notification.userInfo objectForKey:@"latitude"];
    NSString * longitude=[notification.userInfo objectForKey:@"longitude"];
    
    [vc setting_gmap:[latitude floatValue]  longitude:[longitude floatValue]];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    

    });
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
