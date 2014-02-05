//
//  HappinessAloneViewController.h
//  HappinessAlone
//
//  Created by Lucas Charrier on 01/08/12.
//  Copyright (c) 2012 UTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "splitViewControllerDelegateProtocol.h"

@interface HappinessAloneViewController : UIViewController <splitViewControllerDelegateProtocol>
@property(nonatomic) int happiness; //model
@end
