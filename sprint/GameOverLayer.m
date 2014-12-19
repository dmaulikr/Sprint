//
//  GameOverLayer.m
//  Sprint
//
//  Created by Rakesh on 21/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "AppDelegate.h"
#import "GameScene.h"
#import "WelcomeLayer.h"
#import "SimpleAudioEngine.h"

@implementation GameOverLayer

+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameOverLayer node];
    [scene addChild:layer];
    return scene;
}

- (id)init {
    self = [super init];
    if (self) {
        
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Gameovr_loop.mp3"];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        
        CCSprite *gameOverBg = [CCSprite spriteWithFile:@"gameOverBg.png"];
        gameOverBg.opacity=100;
        gameOverBg.position = ccp(screenSize.width/2, screenSize.height/2);
        gameOverBg.scaleX=screenSize.width/gameOverBg.contentSize.width;
        gameOverBg.scaleY=screenSize.height/gameOverBg.contentSize.height;        
        [self addChild:gameOverBg];
        
        CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"Game Over!!" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:60];
        gameOver.position = ccp(screenSize.width/2, screenSize.height*5/7+10);
        [self addChild:gameOver];
//        CCMenuItemLabel *overLabel = [CCMenuItemLabel itemWithLabel:gameOver target:nil selector:nil];
//        overLabel.isEnabled=NO;
        
        AppDelegate *appD = [[UIApplication sharedApplication] delegate];
        NSString *scoreStr = [NSString stringWithFormat:@"Score: %d",appD.currentScore];
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:scoreStr fontName:@"Abduction" fontSize:40];
        scoreLabel.position=    ccp(screenSize.width/2, screenSize.height*4/7+10);
        scoreLabel.color=ccc3(184, 46, 0);
        [self addChild:scoreLabel];
//        CCMenuItemLabel *menuItemLabel = [CCMenuItemLabel itemWithLabel:scoreLabel target:nil selector:nil];
    
        
        CCMenuItem *back = [CCMenuItemFont itemFromString:@"Restart" target:self selector:@selector(goBack)];
        [back setValue:@"AmazS.T.A.L.K.E.R.v.3.0" forKey:@"fontName"];
        CCMenuItem *mainMenu = [CCMenuItemFont itemFromString:@"Main Menu" target:self selector:@selector(goToMainMenu)];
        [mainMenu setValue:@"AmazS.T.A.L.K.E.R.v.3.0" forKey:@"fontName"];
    
        
        CCMenu *gameOverMenu = [CCMenu menuWithItems:back,mainMenu, nil];
        gameOverMenu.position=  ccp(screenSize.width/2, screenSize.height*3/7);
        [gameOverMenu alignItemsVerticallyWithPadding:10];
        
        if (appD.currentScore>appD.highScore) {
            CCLabelTTF *newHighLabel = [CCLabelTTF labelWithString:@" New High Score!! " fontName:@"AmazS.T.A.L.K.E.R.Italic" fontSize:35];
//            newHighLabel.rotation = -15.0f;
            newHighLabel.color = ccRED;        
            newHighLabel.position = ccp(screenSize.width/2, screenSize.height*6/7);
            [newHighLabel runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:.5 scale:1.2],[CCScaleTo actionWithDuration:.5 scale:1], nil]]];
            [self addChild:newHighLabel];
        }
        
        [self addChild:gameOverMenu];
    }
    return self;
}

-(void)goBack{
    CCSequence *soundSequece = [CCSequence actions:
                                [CCCallBlock actionWithBlock:^(void)
                                 {[[SimpleAudioEngine sharedEngine] playEffect:@"Menu2.caf"];
                                 }],
                                [CCDelayTime actionWithDuration:.5],
                                [CCCallBlock actionWithBlock:^(void)
                                 {[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                                     [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"this-is-the-day-loop.mp3"];
                                     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene scene] withColor:ccBLACK]];
                                     
                                 }],
                                nil];
    [self runAction:soundSequece];
//    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu2.caf"];
//    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameScene scene] withColor:ccBLACK]];
}
-(void)goToMainMenu{    
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[WelcomeLayer scene]]];
}

@end
