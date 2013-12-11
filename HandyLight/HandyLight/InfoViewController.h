//
//  InfoViewController.h
//  HandyLight
//
//  Created by Dizdarevic, Rijad on 3/14/13.
//  Copyright (c) 2013 Dizdarevic, Rijad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "social/Social.h"
#import "accounts/Accounts.h"

@protocol InfoControllerDelegate;

@interface InfoViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) id <InfoControllerDelegate> info_delegate;

-(IBAction)backHome:(id)sender;
-(IBAction)share:(id)sender;
-(void)social: (id) type;
-(void)email;

@end

//protocol for memory maxorview controller
@protocol InfoControllerDelegate
- (void)infoDidFinish:(InfoViewController *)controller;
@end