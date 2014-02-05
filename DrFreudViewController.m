//
//  DrFreudViewController.m
//  PsychologistAlone
//
//  Created by Lucas Charrier on 14/10/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import "DrFreudViewController.h"

@interface DrFreudViewController ()


@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation DrFreudViewController

@synthesize webView = _webView;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
