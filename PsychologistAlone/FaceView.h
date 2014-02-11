//
//  FaceView.h
//  HappinessAlone
//
//  Created by Lucas Charrier on 01/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDataSource
- (float) smileForFaceView:(FaceView *)sender;
@end

@interface FaceView : UIView 

@property (nonatomic) CGFloat scale;

- (void)pinch:(UIPinchGestureRecognizer*)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> datasource;

@end
