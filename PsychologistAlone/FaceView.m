//
//  FaceView.m
//  HappinessAlone
//
//  Created by Lucas Charrier on 01/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import "FaceView.h"



@implementation FaceView

@synthesize scale = _scale;
@synthesize datasource = _datasource;

#define DEFAULT_SIZE 0.90

- (CGFloat) scale 
{
    if(!_scale){
        return DEFAULT_SIZE; 
    }else{
        return _scale;
    }
}

- (void) setScale:(CGFloat)scale
{
    if (_scale != scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (void)pinch:(UIPinchGestureRecognizer*)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged)|| (gesture.state == UIGestureRecognizerStateEnded)){
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib 
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef)context 
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x , p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // drawing the head
    CGPoint midPoint;
    midPoint.x = self.bounds.size.width/2;
    midPoint.y = self.bounds.size.height/2;
    CGFloat size = self.bounds.size.width/2;
    if(self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height/2;
    size *= self.scale;
    CGContextSetLineWidth(context, 5);
    [[UIColor redColor] setStroke];
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
#define EYES_H 0.40
#define EYES_V 0.45
#define EYES_SIZE 0.20
    
    // drawing the eyes
    CGPoint eyePoint = midPoint;
    eyePoint.x -= size * EYES_H;
    eyePoint.y -= size * EYES_V;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYES_SIZE inContext:context];
    eyePoint.x += 2 * size * EYES_H;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYES_SIZE inContext:context];
    
#define MOUTH_H 0.40
#define MOUTH_V 0.45
#define MOUTH_SMILE 0.20
    
    // drawing the mouth
    CGPoint mouthStart = midPoint;
    mouthStart.x -= MOUTH_H * size;
    mouthStart.y += MOUTH_V * size;
    
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += 2 * MOUTH_H * size;
    
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += size * MOUTH_H * 2/3;
    
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= size * MOUTH_H * 2/3;
    
    float smile = [self.datasource smileForFaceView:self];
    NSLog(@"%f",smile);
    if (smile < -1) smile = -1;
    if(smile > 1) smile = 1;
    
    mouthCP1.y += smile * MOUTH_SMILE * size;
    mouthCP2.y += smile * MOUTH_SMILE * size;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}


@end
