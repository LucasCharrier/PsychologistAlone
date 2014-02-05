//
//  HappinessAloneViewController.m
//  HappinessAlone
//
//  Created by Lucas Charrier on 01/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import "HappinessAloneViewController.h"
#import "FaceView.h"

@interface HappinessAloneViewController () <FaceViewDataSource>
@property(nonatomic,weak) IBOutlet FaceView* faceView;
@property(nonatomic,weak) IBOutlet UIToolbar* toolbar;
@end

@implementation HappinessAloneViewController
@synthesize happiness = _happiness;
@synthesize faceView = _faceView;
@synthesize splitViewControllerBarButtonItem = _splitViewControllerBarButtonItems;
@synthesize toolbar = _toolbar;

- (void) setSplitViewControllerBarButtonItem:(UIBarButtonItem *)splitViewControllerBarButtonItem
{
    if(_splitViewControllerBarButtonItems != splitViewControllerBarButtonItem){
        NSMutableArray* toolbarItems = [self.toolbar.items mutableCopy];
        if(_splitViewControllerBarButtonItems)[toolbarItems removeObject:_splitViewControllerBarButtonItems];
        if(splitViewControllerBarButtonItem)[toolbarItems insertObject:splitViewControllerBarButtonItem atIndex:0];
        self.toolbar.items = toolbarItems;
        _splitViewControllerBarButtonItems = splitViewControllerBarButtonItem;
    }
}

- (float) smileForFaceView:(FaceView *)sender
{
    NSLog(@"smileForFaceView");
    NSLog(@"%f",(self.happiness - 50)/50.0);
    
    return (self.happiness - 50)/50.0; 
    
}

- (void) setHappiness:(int)happiness
{
    NSLog(@"setHappiness");
    if(happiness == 90) NSLog(@"happines == 90");
    if(_happiness!= happiness){
        _happiness = happiness;
        [self.faceView setNeedsDisplay]; // everytime my model change I redraw my view
    }
    
}
- (void) handleHappinessGesture:(UIPanGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged)||(gesture.state == UIGestureRecognizerStateEnded))
    {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness += translation.y;
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
    
}

- (void) setFaceView:(FaceView *)faceView
{
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];
    self.faceView.datasource = self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
