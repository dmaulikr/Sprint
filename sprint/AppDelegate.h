//
//  AppDelegate.h
//  Sprint
//
//  Created by Rakesh on 11/08/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
    
    int currentScore;
    int highScore;
}

@property (nonatomic, retain) UIWindow *window;
@property int currentScore,highScore;
@end
