//
//  ViewController.m
//  WebView
//
//  Created by Jhaybie on 9/23/13.
//  Copyright (c) 2013 Jhaybie. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    __weak IBOutlet UIWebView               *webView;
    __weak IBOutlet UIActivityIndicatorView *spinner;
    __weak IBOutlet UIBarButtonItem         *backButton;
    __weak IBOutlet UIBarButtonItem         *forwardButton;
}


@property (weak, nonatomic) IBOutlet UITextField *addressBar;

- (IBAction)forwardPressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)addressEntered:(id)sender;

@end



@implementation ViewController

@synthesize addressBar;


NSURLRequest *request;
NSURL        *url;


#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];
    addressBar.frame = CGRectMake(68, 7, 250, 30);
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [spinner startAnimating];
    addressBar.frame = CGRectMake(68, 7, 225, 30);
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)address
{
    url     = [NSURL URLWithString: [NSString stringWithFormat: @"%@", addressBar.text]];
    request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
    [self.view endEditing:YES];
    return YES;
}


//Enables and disables the forward and back buttons -- invoked by a timer
- (void) updateBackAndForwardButtons: (NSTimer *) t
{
    if ([webView canGoForward])
        [forwardButton setEnabled: YES];
    else
        [forwardButton setEnabled: NO];
    if ([webView canGoBack])
        [backButton setEnabled: YES];
    else
        [backButton setEnabled: NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    spinner.hidesWhenStopped = YES;
    addressBar.delegate = self;
    self->webView.scalesPageToFit = YES;
    __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval: 0.5
                                                               target: self
                                                             selector: @selector(updateBackAndForwardButtons:)
                                                             userInfo: nil
                                                              repeats: YES];
}


- (IBAction)forwardPressed:(id)sender
{
    [webView goForward];
}


- (IBAction)backPressed:(id)sender
{
    [webView goBack];
}


- (IBAction)addressEntered:(id)sender
{}

@end
