//
//  WelcomeLayer.m
//  Sprint
//
//  Created by Rakesh on 21/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomeLayer.h"
#import "GameScene.h"
#import "SimpleAudioEngine.h"
#import "SettingsLayer.h"

@implementation WelcomeLayer

+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [WelcomeLayer node];
    [scene addChild:layer];
    return scene;
}


- (id)init {
    self = [super initWithColor:ccc4(0 , 0, 0, 0)];
    if (self) {
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Welcome.mp3"];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.4f];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0f];
        
        settingsL=[[SettingsLayer scene]retain];
        
        scene=[[GameScene scene]retain];
//       
        
//        CCSprite *bg = [CCSprite spriteWithFile:@"spidey_main_bg1.png"];
//        bg.opacity=200;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
//        
//        bg.scaleX=screenSize.width/bg.contentSize.width;
//        bg.scaleY=screenSize.height/bg.contentSize.height;
//        bg.position=ccp(screenSize.width/2, screenSize.height/2);
        
//        [self addChild:bg z:0 tag:25];
        
        
        
        //bg animation
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bg.plist"];
        CCSpriteBatchNode *bgNode = [CCSpriteBatchNode batchNodeWithFile:@"bg.png"];
        [bgNode setTag:25];
        [self addChild:bgNode];
        
        NSMutableArray *frameArray = [NSMutableArray array];
        for (int i =1; i<12; i++) {
            NSString *bgSpriteName = [NSString stringWithFormat:@"bg%d.png",i];
            [frameArray addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:bgSpriteName]];
        }
        CCAnimation *bgAnimation = [CCAnimation animationWithFrames:frameArray delay:.1f];
        CCAction *bgAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:bgAnimation]];
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"bg1.png"];
        bg.scaleX=screenSize.width/bg.contentSize.width;
        bg.scaleY=screenSize.height/bg.contentSize.height;
        bg.position=ccp(screenSize.width/2, screenSize.height/2);
        [bg runAction:bgAction];
        [bgNode addChild:bg];
        
        
        
        CCLabelTTF *play = [[CCLabelTTF alloc] initWithString:@"Play" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        play.color=ccBLACK;
                       
        CCLabelTTF *highScore = [[CCLabelTTF alloc] initWithString:@"HighScore" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        highScore.color=ccBLACK;
        
        CCLabelTTF *settings = [[CCLabelTTF alloc] initWithString:@"Settings" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        settings.color=ccBLACK;
        
        CCMenuItem *menuPlay = [CCMenuItemLabel itemWithLabel:play target:self selector:@selector(beginPlay)];
        CCMenuItem *menuScore = [CCMenuItemLabel itemWithLabel:highScore target:self selector:@selector(showScore)];
        CCMenuItem *menuSettings = [CCMenuItemLabel itemWithLabel:settings target:self selector:@selector(showSettings)];
        
        mainMenu = [CCMenu menuWithItems:menuPlay,menuScore,menuSettings, nil];
        
        [mainMenu alignItemsVerticallyWithPadding:10];
        [self addChild:mainMenu z:1];
        [mainMenu setTag:20];

        
    }
    return self;
}
-(void)beginPlay{
    CCSequence *soundSequece = [CCSequence actions:
                                [CCCallBlock actionWithBlock:^(void)
                                 {[[SimpleAudioEngine sharedEngine] playEffect:@"Menu2.caf"];
                                 }],
                                [CCDelayTime actionWithDuration:.5],
                                [CCCallBlock actionWithBlock:^(void)
                                 {[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
                                     [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"this-is-the-day-loop.mp3"];
                                     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:scene withColor:ccBLACK]];

                                 }],
                                nil];
    
    [self runAction:soundSequece];
    
}
-(void)showScore{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    [mainMenu setOpacity:0];
    mainMenu.isTouchEnabled = NO;
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    NSString *highScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
    if (highScore==NULL) {
        highScore=@"0";
    }
    NSString *highScoreString = [NSString stringWithFormat:@"High Score: %@ ",highScore] ;
    
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:highScoreString fontName:@"AmazS.T.A.L.K.E.R.Italic" fontSize:50];
    scoreLabel.position = ccp(screenSize.width/2, screenSize.height*3/7.0f);
    scoreLabel.color=ccBLACK;
    
    
    CCLabelTTF *backButton = [CCLabelTTF labelWithString:@"Back" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:35];
    backButton.color=ccBLACK;
    
    CCMenuItem *back = [CCMenuItemLabel itemWithLabel:backButton target:self selector:@selector(goBack)];   
    
    CCMenu *scoreMenu = [CCMenu menuWithItems:back, nil];
    scoreMenu.position = ccp(screenSize.width/2, screenSize.height*4/7.0f);
    
        
//    [mainMenu removeFromParentAndCleanup:YES];
    
    
    [self addChild:scoreLabel z:2];
    [self addChild:scoreMenu z:2]; 
    
}


-(void)showSettings{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1 scene:settingsL]];
//    [mainMenu setOpacity:0];
//    mainMenu.isTouchEnabled = NO;
//
//    
//    
//    CCLabelTTF *soundON = [CCLabelTTF labelWithString:@"Music - ON" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
//    soundON.color=ccBLACK;
//    CCLabelTTF *soundOFF = [CCLabelTTF labelWithString:@"Music - OFF" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
//    soundOFF.color = ccBLACK;
//    
//    CCLabelTTF *backButton = [CCLabelTTF labelWithString:@"Back" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:35];
//    backButton.color=ccBLACK;    
//    CCMenuItem *back = [CCMenuItemLabel itemWithLabel:backButton target:self selector:@selector(goBack)];
//    
//    CCMenuItem *soundMenuItemON = [CCMenuItemLabel itemWithLabel:soundON];
//    CCMenuItem *soundMenuItemOFF = [CCMenuItemLabel itemWithLabel:soundOFF];
//    CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundOnOff:) items:soundMenuItemON,soundMenuItemOFF, nil];
//    
//    
//    CCLabelTTF *effectsOn = [CCLabelTTF labelWithString:@"Effects - ON" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
//    effectsOn.color=ccBLACK;
//    CCLabelTTF *effectsOff = [CCLabelTTF labelWithString:@"Effects - OFF" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
//    effectsOff.color = ccBLACK;
//
//    
//    CCMenuItem *effectsMenuItemON = [CCMenuItemLabel itemWithLabel:effectsOn];
//    CCMenuItem *effectsMenuItemOff = [CCMenuItemLabel itemWithLabel:effectsOff];
//    CCMenuItemToggle *effectsToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(effectsOnOff:) items:effectsMenuItemON,effectsMenuItemOff, nil];
//    
//    
//    
//    CCMenu *scoreMenu = [CCMenu menuWithItems:back,soundToggle,effectsToggle, nil];
//    [scoreMenu alignItemsVerticallyWithPadding:10];
//    [self addChild:scoreMenu];
    
    
//    [soundScene addChild:scoreMenu];
//    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1 scene:soundScene]];
  
}

//-(void)popBack{
//    [[CCDirector sharedDirector] popScene];
//    
//}




-(void)goBack{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    CCArray *chilArray = [self children];
    for (CCNode *child in chilArray) {
        
        if (!([child isEqual:[self getChildByTag:20]])) {
            if (!([child isEqual:[self getChildByTag:25]]   )) {
                CCLOG(@"%@",child);
                [child removeFromParentAndCleanup:YES];
            }
           
        }        
    }
    [mainMenu setOpacity:255];
    mainMenu.isTouchEnabled = YES;

}

-(void)dealloc{
    [scene release];
    scene=nil;
    [settingsL release];
    settingsL=nil;
    [super dealloc];
}
@end
