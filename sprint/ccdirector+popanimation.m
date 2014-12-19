//
//  CCDirector+popAnimation.m
//  Sprint
//
//  Created by Rakesh on 04/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCDirector+popAnimation.h"
#import "cocos2d.h"

@implementation CCDirector (popAnimation)



-(void) popSceneWithTransition: (Class)transitionClass duration:(ccTime)t
{
    NSAssert( runningScene_ != nil, @"A running Scene is needed");
    [scenesStack_ removeLastObject];
    NSUInteger c = [scenesStack_ count];
    if( c == 0 ) {
        [self end];
    } else {
        CCScene* scene = [transitionClass transitionWithDuration:t scene:[scenesStack_ objectAtIndex:c-1]];
        [scenesStack_ replaceObjectAtIndex:c-1 withObject:scene];
        nextScene_ = scene;
    }
}
@end
