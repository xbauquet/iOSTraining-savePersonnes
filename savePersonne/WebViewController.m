//
//  WebViewController.m
//  savePersonne
//
//  Created by xavier on 04/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL * url = [[NSURL alloc]initWithString:@"https://www.google.com"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    self.webView.scalesPageToFit=YES;
    [self.webView loadRequest:request];
    
    
    
    // pour que notre controller devienne le delegate
  /*  self.webView.delegate = self;
    
    
    
    
    // Affiche une page Html dans la web view
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"localPage2" ofType:@"html" inDirectory:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
   
    // Append javascript
    //NSString *script = @"<script>alert(\"Message alert!\");</script>";
    //htmlString = [htmlString stringByAppendingString:script];
    
    // Execute java script automatically
    [self.webView stringByEvaluatingJavaScriptFromString:@"alert('trigger the JS');"];
    
    [self.webView loadHTMLString:htmlString baseURL:nil];*/
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Permet de faire un traitement de l'url avant qu'il soit affiché et d'en stopper l'affichage
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
    // take the URL from the button of the html file: localPage2.html
    NSURL *URL = [request URL];
    if ([[URL scheme] isEqualToString:@"callmycode"]) {
        NSString * urlString = [[request URL] absoluteString];
        NSArray * urlParts = [urlString componentsSeparatedByString:@":"];
        if([urlParts count]>1){
            NSArray *parameters = [[urlParts objectAtIndex:1] componentsSeparatedByString:@"&"];
            NSString *methodName = [parameters objectAtIndex:0];
            NSString *variableName = [parameters objectAtIndex:1];
            NSString *message = [NSString stringWithFormat:@"Obj-c from js with methodname=%@ and variable=%@", methodName, variableName];
            
            // display an alert in obj-c
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Great" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil,nil];
            [alert show];
        }
    }
    // if no the web page is not loaded
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
