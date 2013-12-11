//
//  HandyLightViewController.m
//  HandyLight
//
//  Created by Dizdarevic, Rijad on 3/13/13.
//  Copyright (c) 2013 Dizdarevic, Rijad. All rights reserved.
//
#import "HandyLightViewController.h"

#define ADMOB_ID @"addmobIDHERE"

static BOOL firstTime = YES;

@interface HandyLightViewController (){
    BOOL on;
    float level;
@private CGFloat imageAngle;
@private KnobViewSensor *knobSensor;
}
-(void) startKnobSensor;
@end

@implementation HandyLightViewController
@synthesize knobImage, iAdBannerView, wrapper;

//KnobImage position calculation as well as determining the center point
- (void) startKnobSensor {
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(knobImage.frame.origin.x + knobImage.frame.size.width / 2,
                                   knobImage.frame.origin.y + knobImage.frame.size.height / 2);
    CGFloat outRadius = knobImage.frame.size.width / 2;
    
    // outRadius / 4 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    
    knobSensor = [[KnobViewSensor alloc] initWithMidPoint: midPoint innerRadius: outRadius / 4 outerRadius: outRadius target: self];
    [wrapper addGestureRecognizer: knobSensor];
}

- (void) rotation: (CGFloat) angle
{
    //only allwo rotation if light is on 
        // calculate rotation angle
        imageAngle += angle;
        if (imageAngle > 360)
            imageAngle -= 360;
        else if (imageAngle < -360)
            imageAngle += 360;
    
        float a = imageAngle *  M_PI / 180;
    
        //figure out brightness level
        float val = (a + 2.7) / 5.4;
        if (val < 0.1) {
            val = 0.1;
        }
        [self LightBrightnessControl: val];
        // rotate image and update text field
        knobImage.transform = CGAffineTransformMakeRotation(a);
    
}

- (IBAction)LightOnOff:(id)sender {
    [self LightControl];
}

- (void) LightBrightnessControl : (float) value {
    level = value;
    if (on) {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            //value between 0.1 to 1
            [device setTorchModeOnWithLevel:level error:NULL];
            [device unlockForConfiguration];
        }
    }
    }
}

- (void) LightOff {
    on = NO;
    [knobImage setImage:[UIImage imageNamed:@"red2.png"]];
}

- (void) LightControl {
    // check if flashlight available
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (!on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device setTorchModeOnWithLevel:level error:NULL];
                //torchIsOn = YES; //define as a variable/property if you need to know status
                on = YES;
                [knobImage setImage:[UIImage imageNamed:@"green1.png"]];
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                //torchIsOn = NO;
                on = NO;
                [knobImage setImage:[UIImage imageNamed:@"red2.png"]];
            }
            [device unlockForConfiguration];
        }
    }
}

- (IBAction)GoToInfoView:(id)sender {
    InfoViewController *infoView = [[InfoViewController alloc]init];
    infoView.info_delegate = self;
    [infoView setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    self.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:infoView animated:YES completion:nil];
}

- (void)infoDidFinish:(InfoViewController *)controller {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init iAd banner
    [self initiAdBanner];
    // Init Google Ad banner
    [self initgAdBanner];
}

- (void) viewDidAppear:(BOOL)animated {
    if (firstTime) {
        firstTime = NO;
        on = NO;
        level = 0.1;
        imageAngle = MIN_ANGLE;
        [self rotation:imageAngle];
        [self startKnobSensor];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}



#pragma mark - Init methods

-(void)initiAdBanner
{
    if (!self.iAdBannerView)
    {
        CGRect rect = CGRectMake(0, self.view.frame.size.height, 0, 0);
        self.iAdBannerView = [[ADBannerView alloc]initWithFrame:rect];
        self.iAdBannerView.delegate = self;
        self.iAdBannerView.hidden = TRUE;
        [self.view addSubview:self.iAdBannerView];
    }
}

-(void)initgAdBanner
{
    if (!self.gAdBannerView)
    {
        CGRect rect = CGRectMake(0, self.view.frame.size.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height);
        self.gAdBannerView = [[GADBannerView alloc] initWithFrame:rect];
        self.gAdBannerView.adUnitID = ADMOB_ID;
        self.gAdBannerView.rootViewController = self;
        self.gAdBannerView.delegate = self;
        self.gAdBannerView.hidden = TRUE;
        [self.view addSubview:self.gAdBannerView];
    }
}

-(void)viewDidLayoutSubviews
{
    if (self.view.frame.size.height != self.iAdBannerView.frame.origin.y)
    {
        self.iAdBannerView.frame = CGRectMake(0, self.view.frame.size.height, self.iAdBannerView.frame.size.width, self.iAdBannerView.frame.size.height);
    }
    
    if (self.view.frame.size.height != self.gAdBannerView.frame.origin.y)
    {
        self.gAdBannerView.frame = CGRectMake(0, self.view.frame.size.height, self.gAdBannerView.frame.size.width, self.gAdBannerView.frame.size.height);
    }
}

#pragma mark - Banner hide and show -

// Hide the banner by sliding down
-(void)hideBanner:(UIView*)banner
{
    if (banner && ![banner isHidden])
    {
        [UIView beginAnimations:@"hideBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = TRUE;
    }
}

// Show the banner by sliding up
-(void)showBanner:(UIView*)banner
{
    if (banner && [banner isHidden])
    {
        [UIView beginAnimations:@"showBanner" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        banner.hidden = FALSE;
    }
}

#pragma mark - ADBanner delegate methods -

// Called before the add is shown, time to move the view
- (void)bannerViewWillLoadAd:(ADBannerView *)banner
{
    [self hideBanner:self.gAdBannerView];
    [self showBanner:self.iAdBannerView];
}

// Called when an error occured
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    [self hideBanner:self.iAdBannerView];
    GADRequest * req = [GADRequest request];
    //TODO - remove this later
    ///req.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, @"0269710edb508b15792f24198ceb299cb0332861",nil];
    [self.gAdBannerView loadRequest:req];
}

#pragma mark - GADBanner delegate methods -

// Called before ad is shown, good time to show the add
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    [self hideBanner:self.iAdBannerView];
    [self showBanner:self.gAdBannerView];
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    [self hideBanner:self.gAdBannerView];
}



@end
