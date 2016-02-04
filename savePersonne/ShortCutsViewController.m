//
//  ShortCutsViewController.m
//  savePersonne
//
//  Created by xavier on 04/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "ShortCutsViewController.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>


@interface ShortCutsViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@end

@implementation ShortCutsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Email

- (IBAction)emailButton:(UIButton *)sender {
    
    MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc]init];
    if([MFMailComposeViewController canSendMail]){
        [mailComposer setSubject:@"The Email Subject"];
        [mailComposer setMessageBody:@"The email body." isHTML:NO];
        mailComposer.mailComposeDelegate = self;
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultSent:

            break;
        case MFMailComposeResultCancelled:
           
            break;
        case MFMailComposeResultFailed:
            
            break;
        case MFMailComposeResultSaved:
            
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SMS

- (IBAction)smsButton:(UIButton *)sender {
    MFMessageComposeViewController * smsController = [[MFMessageComposeViewController alloc]init];
    if([MFMessageComposeViewController canSendText]){
        //[smsController setSubject:@"sujet"];
        //[smsController setBody:@"mon body"];
        smsController.messageComposeDelegate = self;
        [self presentViewController:smsController animated:YES completion:nil];
    }
}



- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:

            break;
        case MessageComposeResultFailed:
            
            break;
        case MessageComposeResultSent:
            
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Safari

- (IBAction)safariButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.google.com"]];
}


#pragma mark - Call

- (IBAction)callButton:(UIButton *)sender {
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:+33601999502"]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:+33601999502"]];
    }
}


#pragma mark - Twitter

- (IBAction)twitterButton:(UIButton *)sender {
    SLComposeViewController *socialComposerSheet;
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        socialComposerSheet = [[SLComposeViewController alloc]init];
        socialComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [socialComposerSheet setInitialText:@"My Tweet"];
        [self presentViewController:socialComposerSheet animated:YES completion:nil];
    }
    
    [socialComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result){
        NSString *output;
        switch(result){
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
    
}


#pragma mark - Facebook

- (IBAction)facebookButton:(UIButton *)sender {
    SLComposeViewController *socialComposerSheet;
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        socialComposerSheet = [[SLComposeViewController alloc]init];
        socialComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [socialComposerSheet setInitialText:@"Mon Post"];
        [self presentViewController:socialComposerSheet animated:YES completion:nil];
    }
    
    [socialComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result){
        NSString *output;
        switch(result){
            case SLComposeViewControllerResultCancelled:
                break;
            case SLComposeViewControllerResultDone:
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}
@end
