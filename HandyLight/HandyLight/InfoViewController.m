//
//  InfoViewController.m
//  HandyLight
//
//  Created by Dizdarevic, Rijad on 3/14/13.
//  Copyright (c) 2013 Dizdarevic, Rijad. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self = [sb instantiateViewControllerWithIdentifier:@"InfoView"];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backHome:(id)sender{
    [self.info_delegate infoDidFinish:self];
}

-(IBAction)share:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Share with Friends" message:@"" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Share with E-mail", @"Share to Facebook", @"Share to Twitter", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self email];
    } else if (buttonIndex == 2) {
        [self social:SLServiceTypeFacebook];
    } else if (buttonIndex == 3) {
        [self social:SLServiceTypeTwitter];
    }
}

-(void) email {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"OtakuSnap FlashLight App!"];
        NSArray *toRecipients = [NSArray arrayWithObjects:nil];
        [mailer setToRecipients:toRecipients];
        NSString *emailBody = @"Get the OtakuSnap FlashLight App https://itunes.apple.com/us/app/otakusnap-flashlight/id624053660?ls=1&mt=8";
        [mailer setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:mailer animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not open your email client" message:@"" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)social: (id) type{
    if([SLComposeViewController isAvailableForServiceType:type]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:type];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Get the OtakuSnap FlashLight App https://itunes.apple.com/us/app/otakusnap-flashlight/id624053660?ls=1&mt=8"];
        
        //Adding the URL to the facebook post value from iOS
        
        [controller addURL:[NSURL URLWithString:@""]];
        
        //Adding the Image to the facebook post value from iOS
        
        [controller addImage:[UIImage imageNamed:@"icon114.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log into your Social Network" message:@"" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
        [alert show];
    }
}

@end
