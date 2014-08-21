//
//  LoginedViewController.m
//  market
//
//  Created by Eric Yang on 2014/7/31.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import "LoginedViewController.h"
@interface LoginedViewController ()
{
    NSArray *_pickerData;
    NSString *genre;
}
@end

@implementation LoginedViewController
static void *user=&user;
static void *token=&token;
- (IBAction)chaeckBtnPressed:(id)sender {
    [self.productField resignFirstResponder];
    [self.statusField resignFirstResponder];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"product"]=self.productField.text;
    params[@"status"]= self.statusField.text;
    params[@"genre"]=genre;
    [self.marketReq marketPrice:params withCallback:^(int isSuccess){
        if(isSuccess){
            NSLog(@"got value");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.valueLabel.text=[NSString stringWithFormat:@"New one price: NT$ %@ \n And your goods: NT$ %@",self.marketReq.info[@"marketPrice"][@"response"][@"data"][@"avgsValue"],self.marketReq.info[@"marketPrice"][@"response"][@"data"][@"yoursValue"]];
            });
            NSLog(@"%@",self.marketReq.info[@"marketPrice"][@"response"][@"data"][@"yoursValue"]);
        
        }else{
            NSLog(@"wrong");
        }
    }];

}
- (IBAction) backgroundTap: (id)sender
{
    [self.productField resignFirstResponder];
    [self.statusField resignFirstResponder];
    //[sender resignFirstResponder];   // number label
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.marketReq=[marketHttpRequest getInstance];
    self.user=[MarketUser getInstance];
    [self.marketReq  addObserver:self forKeyPath:@"info.token" options:NSKeyValueObservingOptionNew context:token];
    [self.marketReq addObserver:self forKeyPath:@"info.profile.get.response.data" options:NSKeyValueObservingOptionNew context:user];
    
    // Initialize Data
    _pickerData = @[@"Phone", @"Car",@"VideoGames",@"Home Appliances",@"Cameras",@"TV",@"Motorcycle"];
    
    // Connect data
    self.genrePicker.dataSource = self;
    self.genrePicker.delegate = self;
    // Do any additional setup after loading the view.
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

#pragma mark - picker

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    genre=_pickerData[row];
    return _pickerData[row];
}

@end
