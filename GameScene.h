//
//  GameScene.h
//  Sprint
//
//  Created by Rakesh on 11/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface GameScene : CCLayerColor {
    Player * hero;
    int buttonflag;
    
    CCArray *_spiders;
    int numbSpidersMoved;

    
    CCLabelTTF *scoreLabel;
    ccTime totalTime;
    int score;
           
    CGPoint nowAt;
    int positionFlag;
    
    NSMutableArray *reverseArray;
}



+(id)scene;


-(void)initSpiders;
-(void)resetSpiders;
-(void)spidersUpdate:(ccTime)delta;
-(void)runSpiderMoveSequence:(Player*)spider;
-(void)spiderDidDrop:(id)sender;
-(void)checkForCollision;
-(void)storeHighScore;

@end
