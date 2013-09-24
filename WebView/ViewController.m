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
    __weak IBOutlet UIActivityIndicatorView *isLoading;
    __weak IBOutlet UIBarButtonItem         *backButton;
    __weak IBOutlet UIBarButtonItem         *forwardButton;
}

@property (weak, nonatomic) IBOutlet UITextField *addressBar;

- (IBAction)forwardPressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)addressEntered:(id)sender;
- (IBAction)goButton:(id)sender;

@end

@implementation ViewController

NSURLRequest *request;
NSURL        *url;

#pragma mark UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [isLoading stopAnimating];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [isLoading startAnimating];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)addressBar
{
    
    url     = [NSURL URLWithString: [NSString stringWithFormat: @"%@", addressBar.text]];
    request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
    [self.view endEditing:YES];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    isLoading.hidesWhenStopped = YES;
    _addressBar.delegate = self;
    //[backButton setEnabled:NO];
    //[forwardButton setEnabled:NO];
}

- (IBAction)forwardPressed:(id)sender
{
    if ([webView canGoForward])
        [webView goForward];
    //else
    //    [forwardButton setEnabled:YES];
}

- (IBAction)backPressed:(id)sender
{
    if ([webView canGoBack])
        [webView goBack];
    //else
    //    [backButton setEnabled:NO];
}

- (IBAction)addressEntered:(id)sender
{
}

- (IBAction)goButton:(id)sender
{
    [self.view endEditing:YES];
    url     = [NSURL URLWithString: [NSString stringWithFormat: @"%@", _addressBar.text]];
    request = [NSURLRequest requestWithURL: url];
    [webView loadRequest: request];
}


@end
