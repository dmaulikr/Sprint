//
//  SettingsLayer.m
//  Sprint
//
//  Created by Rakesh on 04/09/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsLayer.h"
#import "SimpleAudioEngine.h"
#import "WelcomeLayer.h"
#import "CCDirector+popAnimation.h"

@implementation SettingsLayer


+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [SettingsLayer node];
    [scene addChild:layer];
    return scene;
}


- (id)init {
    self = [super initWithColor:ccc4(0 , 0, 0, 0)];
    if (self) {
        
            
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
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
        
        
        
        CCLabelTTF *soundON = [CCLabelTTF labelWithString:@"Music - ON" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        soundON.color=ccBLACK;
        CCLabelTTF *soundOFF = [CCLabelTTF labelWithString:@"Music - OFF" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        soundOFF.color = ccBLACK;
        
        CCLabelTTF *backButton = [CCLabelTTF labelWithString:@"Back" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:35];
        backButton.color=ccBLACK;    
        CCMenuItem *back = [CCMenuItemLabel itemWithLabel:backButton target:self selector:@selector(goBack)];
        
        CCMenuItem *soundMenuItemON = [CCMenuItemLabel itemWithLabel:soundON];
        CCMenuItem *soundMenuItemOFF = [CCMenuItemLabel itemWithLabel:soundOFF];
        CCMenuItemToggle *soundToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundOnOff:) items:soundMenuItemON,soundMenuItemOFF, nil];
        
        
        CCLabelTTF *effectsOn = [CCLabelTTF labelWithString:@"Effects - ON" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        effectsOn.color=ccBLACK;
        CCLabelTTF *effectsOff = [CCLabelTTF labelWithString:@"Effects - OFF" fontName:@"AmazS.T.A.L.K.E.R.v.3.0" fontSize:50];
        effectsOff.color = ccBLACK;
        
        
        CCMenuItem *effectsMenuItemON = [CCMenuItemLabel itemWithLabel:effectsOn];
        CCMenuItem *effectsMenuItemOff = [CCMenuItemLabel itemWithLabel:effectsOff];
        CCMenuItemToggle *effectsToggle = [CCMenuItemToggle itemWithTarget:self selector:@selector(effectsOnOff:) items:effectsMenuItemON,effectsMenuItemOff, nil];
        
        
        
        CCMenu *scoreMenu = [CCMenu menuWithItems:back,soundToggle,effectsToggle, nil];
        [scoreMenu alignItemsVerticallyWithPadding:10];
        [self addChild:scoreMenu];

        
        
    }
    return self;
}

-(void)soundOnOff:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    CCMenuItemToggle *soundToggle = (CCMenuItemToggle *)sender;
    if(soundToggle.selectedIndex==0){
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1.0f];
    }
    else{
        [[SimpleAudioEngine sharedEngine]setBackgroundMusicVolume:0.0f];
    }
}

-(void)effectsOnOff:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    CCMenuItemToggle *soundToggle = (CCMenuItemToggle *)sender;
    if(soundToggle.selectedIndex==0){
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0f];
    }
    else{
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.0f];
    }
}

-(void)goBack{
    [[SimpleAudioEngine sharedEngine] playEffect:@"Menu1.caf"];
    [[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] duration:1];
    
}


@end
