//
//  Player.m
//  Sprint
//
//  Created by Rakesh on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"

@implementation Player


@synthesize player = _player;
@synthesize moveAction=_moveAction;
@synthesize walkAction=_walkAction;
@dynamic playerWalkDuration;
@synthesize playerMoveDuration=_playerMoveDuration;
@synthesize playerVelocity=_playerVelocity;

- (id)init {
    self = [super init];
    if (self) {         
        
        self.playerMoveDuration = 4.0f;
        self.playerWalkDuration = 0.1f;
               
    }
    return self;
}

-(id)initWithPlayerFromFrameName:(NSString *)fr andNumberOfFrames:(int)nof{
    
    [self init];
    frame=fr;
    numFrames=nof;
    if (self) {        
        self.player = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@1.png",frame]];
        [self setWalkActionFromSpriteFrameTemplate:frame andNumberOfFrames:nof];    
    
    }
    
    return self;
}

-(void)setWalkActionFromSpriteFrameTemplate:(NSString *)file andNumberOfFrames:(int)nof{
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=nof; ++i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@%d.png",file,i]]];
    }
    walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:self.playerWalkDuration];    
    self.walkAction= [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];

}


-(void)setPlayerWalkDuration:(float)playaWalkDuration{
    _playerWalkDuration=playaWalkDuration;
    [self setWalkActionFromSpriteFrameTemplate:frame andNumberOfFrames:numFrames];
}

-(float)playerWalkDuration{
    return _playerWalkDuration;
}

-(void)setMoveActionWithPosition:(CGPoint)position{
    self.moveAction = [CCMoveTo actionWithDuration:self.playerMoveDuration position:position];
}



@end
