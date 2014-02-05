//
//  RotativeViewController.m
//  PsychologistAlone
//
//  Created by Lucas Charrier on 04/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import "RotativeViewController.h"
#import "splitViewControllerDelegateProtocol.h"
#import "HappinessAloneViewController.h"

@interface RotativeViewController ()

@end

@implementation RotativeViewController

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.splitViewController.delegate = self;
}

- (id <splitViewControllerDelegateProtocol>) splitViewControllerBar 
{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if(![detailVC conformsToProtocol:@protocol(splitViewControllerDelegateProtocol)]){
        detailVC = nil;
    }
    return detailVC;

}
- (BOOL)splitViewController:(UISplitViewController *)svc 
   shouldHideViewController:(UIViewController *)vc 
              inOrientation:(UIInterfaceOrientation)orientation
{
    return [self splitViewControllerBar] ? UIInterfaceOrientationIsPortrait(orientation) : NO;
}

- (void) splitViewController:(UISplitViewController *)svc 
      willHideViewController:(UIViewController *)aViewController 
           withBarButtonItem:(UIBarButtonItem *)barButtonItem 
        forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"psychologist";
    [self splitViewControllerBar].splitViewControllerBarButtonItem = barButtonItem;
}

- (void) splitViewController:(UISplitViewController *)svc 
      willShowViewController:(UIViewController *)aViewController 
   invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self splitViewControllerBar].splitViewControllerBarButtonItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
