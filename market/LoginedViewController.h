//
//  LoginedViewController.h
//  market
//
//  Created by Eric Yang on 2014/7/31.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "marketHttpRequest.h"
#import "MarketUser.h"
@interface LoginedViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic,strong) marketHttpRequest *marketReq;
@property (nonatomic,strong) MarketUser *user;
@property (weak, nonatomic) IBOutlet UITextField *productField;
@property (weak, nonatomic) IBOutlet UITextField *statusField;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *genrePicker;
@end
