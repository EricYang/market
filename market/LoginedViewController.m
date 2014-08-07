//
//  LoginedViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/31.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "LoginedViewController.h"
#import <MapKit/MapKit.h>
@interface LoginedViewController ()
{
    MKMapView *map;
}

@end

@implementation LoginedViewController
static void *user=&user;
static void *token=&token;
- (IBAction)chaeckBtnPressed:(id)sender {
    NSLog(@"the token:%@",[self.marketReq info][@"token"]);
    NSLog(@"the email:%@",[self.user email]);
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *c= [locations objectsAtIndexes:0];
    
    NSLog(@"緯度：%f,經度：%f,高度：%f",c.coordinate.latitude,c.coordinate.longitude,c.altitude);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    location=[[CLLocationManager alloc]init];
    location.delegate=self;
    //[location startUpdatingLocation];
    #define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    
    //In ViewDidLoad
    if(IS_OS_8_OR_LATER) {
        [location requestAlwaysAuthorization];
    }
    
    [location startUpdatingLocation];
    */
    self.marketReq=[marketHttpRequest getInstance];
    self.user=[MarketUser getInstance];
    [self.marketReq  addObserver:self forKeyPath:@"info.token" options:NSKeyValueObservingOptionNew context:token];
    [self.marketReq addObserver:self forKeyPath:@"info.profile.get.response.data" options:NSKeyValueObservingOptionNew context:user];
    [self map_init];
    
    // Do any additional setup after loading the view.
}
- (void)map_init {
    
    //建立MapView
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 40.0f, 320.0f, 400.0f)];
    
    //顯示目前位置（藍色圓點）
    map.showsUserLocation = YES;
    
    //MapView的環境設置
    map.mapType = MKMapTypeStandard;
    map.scrollEnabled = YES;
    map.zoomEnabled = YES;
    
    //將MapView顯示於畫面
    [self.view insertSubview:map atIndex:0];
    
    //取得目前MAP的中心點座標並show在對應的TextField中
    double X = map.centerCoordinate.latitude;
    double Y = map.centerCoordinate.longitude;
    
    //latitudeField.text = [NSString stringWithFormat:@"%6f", X];
    //longitudeField.text = [NSString stringWithFormat:@"%6f", Y];
    NSLog(@"緯度：%f,經度：%f",X,Y);
}


-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context==user) {
        NSLog(@"user:%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
    if (context==token) {
         NSLog(@"!!!!outside token:%@",[change objectForKey:NSKeyValueChangeNewKey]);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//自行定義的設定地圖函式
- (void)setMapRegionLongitude:(double)Y andLatitude:(double)X withLongitudeSpan:(double)SY andLatitudeSpan:(double)SX {
    
    //設定經緯度
    CLLocationCoordinate2D mapCenter;
    mapCenter.latitude = X;
    mapCenter.longitude = Y;
    
    //Map Zoom設定
    MKCoordinateSpan mapSpan;
    mapSpan.latitudeDelta = SX;
    mapSpan.longitudeDelta = SY;
    
    //設定地圖顯示位置
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapCenter;
    mapRegion.span = mapSpan;
    
    //前往顯示位置
    [map setRegion:mapRegion];
    [map regionThatFits:mapRegion];
}

- (IBAction)onNowLocacion:(id)sender {
    
    //取得現在位置
    double X = map.userLocation.location.coordinate.latitude;
    double Y = map.userLocation.location.coordinate.longitude;
    
    //show在對應的TextField中
   // latitudeField.text = [NSString stringWithFormat:@"%6f", X];
   // longitudeField.text = [NSString stringWithFormat:@"%6f", Y];
   
    NSLog(@"緯度：%f,經度：%f",X,Y);

    //自行定義的設定地圖函式
    [self setMapRegionLongitude:Y andLatitude:X withLongitudeSpan:0.05 andLatitudeSpan:0.05];
}
@end
