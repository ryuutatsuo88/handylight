//
//  HandyLightViewController.h
//  HandyLight
//
//  Created by Dizdarevic, Rijad on 3/13/13.
//  Copyright (c) 2013 Dizdarevic, Rijad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import "GADBannerView.h"
#import "KnobViewSensor.h"
#import "InfoViewController.h"

@interface HandyLightViewController : UIViewController<KnobViewSensorDelegate, InfoControllerDelegate, ADBannerViewDelegate, GADBannerViewDelegate>
@property  (nonatomic, strong) IBOutlet UIImageView *knobImage;

@property  (nonatomic, strong) IBOutlet UIView *wrapper;

@property (strong, nonatomic) ADBannerView *iAdBannerView;
@property (strong, nonatomic) GADBannerView *gAdBannerView;

- (IBAction)LightOnOff:(id)sender;
- (IBAction)GoToInfoView:(id)sender;

- (void) LightControl;
- (void) LightBrightnessControl : (float) value;
- (void) LightOff;
@end
