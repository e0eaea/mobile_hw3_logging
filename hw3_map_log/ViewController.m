//
//  ViewController.m
//  hw3_map_log
//
//  Created by KMK on 2016. 6. 6..
//  Copyright © 2016년 KMK. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;

@interface ViewController ()<GMSMapViewDelegate,CLLocationManagerDelegate>

@end

@implementation ViewController{
    
     GMSMapView *mapView_;
     CLLocationManager *locationManager;
     CLLocation *currentLocation;
}


- (void)viewDidLoad {
  
    [super viewDidLoad];
   

}


- (void) setting_gmap:(float)latitude longitude:(float)longitude
{
    
     GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:12];
     mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     mapView_.myLocationEnabled = YES;
    NSLog(@"User's location: %@", mapView_.myLocation);

     self.view = mapView_;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
