//
//  WelcomeLayer.h
//  Sprint
//
//  Created by Rakesh on 21/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"

@class SettingsLayer;

@interface WelcomeLayer : CCLayerColor {
    CCScene *scene;
    CCMenu *mainMenu;
    CCScene *settingsL;
}
-(void)beginPlay;
-(void)showScore;
-(void)showSettings;
+(id)scene;
@end
