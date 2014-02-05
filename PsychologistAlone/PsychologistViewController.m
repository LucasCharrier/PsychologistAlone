//
//  PsychologistViewController.m
//  PsychologistAlone
//
//  Created by Lucas Charrier on 03/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessAloneViewController.h"

@interface PsychologistViewController ()
@property(nonatomic) int fantasy;
@end

@implementation PsychologistViewController

@synthesize fantasy = _fantasy;

- (id <splitViewControllerDelegateProtocol>)splitViewBarButtonItemPresenter
{
    id detailVC = [self.splitViewController.viewControllers lastObject];
    if (![detailVC conformsToProtocol:@protocol(splitViewControllerDelegateProtocol)]) {
        detailVC = nil;
    }
    return detailVC;
}
  


- (void)transferSplitViewBarButtonItemToViewController:(id)destinationViewController
{
    UIBarButtonItem *splitViewBarButtonItem = [[self splitViewBarButtonItemPresenter] splitViewControllerBarButtonItem];
    [[self splitViewBarButtonItemPresenter] setSplitViewControllerBarButtonItem:nil];
    if (splitViewBarButtonItem) {
        [destinationViewController setSplitViewControllerBarButtonItem:splitViewBarButtonItem];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{  
    if([segue.identifier isEqualToString:@"HappinessForFantasy"])
    { [segue.destinationViewController setHappiness:self.fantasy];
    }else if([segue.identifier isEqualToString:@"cherry"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:100];
    }else if([segue.identifier isEqualToString:@"apple"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:60];
    }else if([segue.identifier isEqualToString:@"strawberry"]){
        [self transferSplitViewBarButtonItemToViewController:segue.destinationViewController];
        [segue.destinationViewController setHappiness:20];
    }
}


- (HappinessAloneViewController *)splitViewHappinessViewController
{
    id hvc = [self.splitViewController.viewControllers lastObject];
    if (![hvc isKindOfClass:[HappinessAloneViewController class]]) {
        hvc = nil;
    }
    return hvc;
}

- (void) setTheHappiness:(int)happiness
{ 
    self.fantasy = happiness;
    if([self splitViewHappinessViewController]){
        [self splitViewHappinessViewController].happiness = happiness;
    }else{
        [self performSegueWithIdentifier:@"HappinessForFantasy" sender:self]; 
    }
}

- (IBAction)cgirl {
     NSLog(@"setOrigin");
    [self setTheHappiness:90];
}
- (IBAction)elephant {
    [self setTheHappiness:10];
}
- (IBAction)cougar {
    [self setTheHappiness:100];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
