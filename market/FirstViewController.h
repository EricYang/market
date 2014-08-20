//
//  FirstViewController.h
//  market
//
//  Created by Eric Yang on 2014/7/19.
//  Copyright (c) 2014年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonObject.h"
#import "marketHttpRequest.h"
#import "UserDataViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBLoginView *fbloginView;
-(void)nextpage;
- (IBAction)registerBtnPressed:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *registerView;

@end

