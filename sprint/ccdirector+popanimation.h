//
//  CCDirector+popAnimation.h
//  Sprint
//
//  Created by Rakesh on 04/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCDirector.h"

@interface CCDirector (popAnimation)
-(void) popSceneWithTransition: (Class)transitionClass duration:(ccTime)t;

@end
