//
//  MeMapController.m
//  琥珀旅行
//
//  Created by mac on 16/2/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MeMapController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MeMapController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, weak) MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *mgr;
@end

@implementation MeMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    self.mapView = mapView;

    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(0, 0), 2000, 2000);
    [self.mapView setRegion:region animated:YES];
    //我要做一个获取自身坐标的属性
    
    if ([[UIDevice currentDevice].systemVersion doubleValue]>= 8.0) {
        //如果大于ios大于8.0，就请求获取地理位置授权
        self.mgr = [[CLLocationManager alloc] init];
        [self.mgr requestAlwaysAuthorization];
        self.mgr.delegate = self;
        self.mgr.distanceFilter
        = 10.0f;//
        [self.mgr startUpdatingLocation];
    }
    self.mapView.delegate = self;
//    self.mapView.userTrackingMode =  MKUserTrackingModeFollow;
}

#pragma mark - MKMapViewDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_6, __MAC_NA, __IPHONE_2_0, __IPHONE_6_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED
{
    NSLog(@"改变了");
    
}

//- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"will");
//}
//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"finish");
//}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{
    //获取用户的位置
//    CLLocationCoordinate2D center = userLocation.coordinate;
    // 指定经纬度的跨度
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.009310,0.007812);
    // 将用户当前的位置作为显示区域的中心点, 并且指定需要显示的跨度范围
    
    self.mapView.centerCoordinate = userLocation.coordinate;
}
@end
