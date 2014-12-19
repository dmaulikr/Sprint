//
//  Player.h
//  Sprint
//
//  Created by Rakesh on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : NSObject{

    CCSprite *_player;
    CCAction *_walkAction;
    CCFiniteTimeAction *_moveAction;

    
    float _playerMoveDuration;
    float _playerWalkDuration;
    
    CGPoint _playerVelocity;
    CCAnimation *walkAnim;
    
    NSString *frame;
    int numFrames;
}


@property (nonatomic,retain) CCSprite *player;
@property (nonatomic,retain) CCAction *walkAction;
@property (nonatomic,retain) CCFiniteTimeAction *moveAction;
@property CGPoint playerVelocity;
@property float playerMoveDuration;
@property float playerWalkDuration;



-(id)initWithPlayerFromFrameName:(NSString *)frame andNumberOfFrames:(int)nof;
-(void)setWalkActionFromSpriteFrameTemplate:(NSString *)file andNumberOfFrames:(int)nof;
-(void)setMoveActionWithPosition:(CGPoint )position;
@end
