//
//  GameScene.m
//  Sprint
//
//  Created by Rakesh on 11/08/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "GameOverLayer.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@implementation GameScene

+(id)scene{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}



- (id)init {
    self = [super initWithColor:ccc4(255, 255, 255, 255)];
    
    if (self) {  
        
        
        CGSize screenSize = [[CCDirector sharedDirector]winSize];        
        CCSprite *bg = [CCSprite spriteWithFile:@"Factory_Bricks.jpg"];
        bg.position = ccp(screenSize.width/2, screenSize.height/2);
        bg.scaleX=screenSize.width/bg.contentSize.width;
        bg.scaleY=screenSize.height/bg.contentSize.height;
        bg.opacity=200;
        [self addChild:bg z:0 tag:100];
        
        
        positionFlag=1; //var for checking between 10 frames        
        buttonflag=0;
        
        //the buttons
        //plus
        CCSprite *nomalPlus = [CCSprite spriteWithFile:@"plus.png"];
        CCSprite *selPlus = [CCSprite spriteWithFile:@"plus.png"];
        nomalPlus.anchorPoint= ccp(screenSize.width, 0);
        nomalPlus.scale=0.7;
        selPlus.scale=0.8;
        float spriteSizeHalved = [nomalPlus texture].contentSize.width*0.5f;        
        CCMenuItem *starMenuItem = [CCMenuItemSprite itemFromNormalSprite:nomalPlus selectedSprite:selPlus target:self selector:@selector(plus:)];        
        starMenuItem.position = ccp(screenSize.width-spriteSizeHalved/2,[nomalPlus texture].contentSize.height/2);
        

        //minus
        CCSprite *normalMinus = [CCSprite spriteWithFile:@"minus.png"];
        CCSprite *selMinus = [CCSprite spriteWithFile:@"minus.png"];
        normalMinus.scale=0.7;
        selMinus.scale=0.8;        
        CCMenuItem *minusMenuItem = [CCMenuItemSprite itemFromNormalSprite:normalMinus selectedSprite:selMinus target:self selector:@selector(minus:)];                                   
        minusMenuItem.position = ccp(screenSize.width-spriteSizeHalved/2,nomalPlus.contentSize.height/2+normalMinus.contentSize.height);
        
        //add buttons into menu and menu into layer
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem,minusMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
        
        CCLOG(@"%@: %@",NSStringFromSelector(_cmd),self);        
        self.isAccelerometerEnabled = YES;
        
        
       
        
        //spawn player
        
        //init sheets-spawn sheet
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"newSpawn.plist"];        
        CCSpriteBatchNode *playerSpawnSheet = [CCSpriteBatchNode batchNodeWithFile:@"newSpawn.png"];
        [playerSpawnSheet setTag:15];
        
        [self addChild:playerSpawnSheet];
        
        //init player
        Player *hero1 = [[Player alloc] initWithPlayerFromFrameName:@"sprite" andNumberOfFrames:11];       
        hero1.player.scale = 1.2;
        float imageHeight = [hero1.player boundingBox].size.height;
        hero1.player.position = ccp(screenSize.width/2, imageHeight/2);        
        [playerSpawnSheet addChild:hero1.player];

        
        reverseArray = [[NSMutableArray array] retain];
        for (int i=1; i<=11; ++i) {
            [reverseArray addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"sprite%d.png",i]]];
        }        
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:reverseArray delay:0.08f];    
        CCFiniteTimeAction *spawnAction= [CCAnimate actionWithAnimation:walkAnim];
        
        [hero1.player runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.5f],spawnAction,[CCCallFunc actionWithTarget:self selector:@selector(secondInit)],nil]];
        
        [reverseArray release];
        reverseArray=nil;
        //init sheet - run sheet   
        
        
        
        
    }
    return self;
}
-(void)secondInit{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"runSprites.plist"];        
    CCSpriteBatchNode *playerRunSheet = [CCSpriteBatchNode batchNodeWithFile:@"runSprites.png"];
    
    
    //init player
    hero = [[Player alloc] initWithPlayerFromFrameName:@"run" andNumberOfFrames:11];       
    hero.player.scale = 1.2;
    float imageHeight = [hero.player boundingBox].size.height;
    hero.player.position = ccp(screenSize.width/2, imageHeight/3);       
    
    
    
    
    
    //init sheet-run sheet
    
    [self addChild:playerRunSheet];
    [playerRunSheet addChild:hero.player];
    
    [hero.player runAction:hero.walkAction];//run animation
    
    [[self getChildByTag:15] removeFromParentAndCleanup:YES]; 
    
    
    
    
    
    
    
    
    [self scheduleUpdate];
    [self initSpiders];
    
    
    
    //initialize label
    scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Abduction" fontSize:20];
    scoreLabel.color = ccc3(0,0,0);
    scoreLabel.position = ccp(scoreLabel.contentSize.width/2+20, screenSize.height);
    
    scoreLabel.anchorPoint = ccp(0.5f, 1.0f);
    
    [self addChild:scoreLabel z:0];
}


-(void)initSpiders{
    
    
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    
    //spidey animation 
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Spidey_new.plist"];
    CCSpriteBatchNode *spriteSheet= [CCSpriteBatchNode batchNodeWithFile:@"Spidey_new.png"];
    [spriteSheet setTag:10];    
    [self addChild:spriteSheet];
    
    Player *villainDumb = [[Player alloc] initWithPlayerFromFrameName:@"sprite" andNumberOfFrames:8];
    [villainDumb setPlayerWalkDuration:0.2];
   
    
    
    
    //temp spider
    CCLOG(@"%f",[villainDumb.player boundingBox].size.width);
    villainDumb.player.scale=0.7;
    float imageWidth = [villainDumb.player boundingBox].size.width;
    CCLOG(@"%f",[villainDumb.player boundingBox].size.width);

    int numSpiders = screenSize.width/imageWidth+1;
    
    _spiders = [[CCArray alloc] initWithCapacity:numSpiders];

       
    for (int i=1; i<=numSpiders; i++) {        
//        NSString *spideyName = [NSString stringWithFormat:@"sprite"];
        Player *villain = [[Player alloc] initWithPlayerFromFrameName:@"sprite" andNumberOfFrames:4];
        villain.player.scale=0.7;
        [spriteSheet addChild:villain.player z:0 tag:2];
        [_spiders addObject:villain];       
        [villain release];
        
    }
    [villainDumb release];
    [self resetSpiders];
    
}




-(void)plus:(id)sender{
    buttonflag=0;
    [self accelerometer:nil didAccelerate:nil];
}
-(void)minus:(id)sender{
    buttonflag=1;
    [self accelerometer:nil didAccelerate:nil];
}
-(void)left:(id)sender{
    
}
-(void)right:(id)sender{
    
}


-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    
    
    
    double dummyAccelerationX;
    

    dummyAccelerationX=acceleration.x;
    if (acceleration==nil) {
        dummyAccelerationX=.2;
    }
    
    
    if (buttonflag==1)dummyAccelerationX= -dummyAccelerationX;
    //    double dummyAccelerationY;
    //    double dummyAccelerationZ;
    
    
    float decceleration = 0.4f;
    float sensitivity = 6.0f;
    float maxVelocity = 200;
    
    
    CGPoint playerVelocity = hero.playerVelocity;
    playerVelocity.x = hero.playerVelocity.x*decceleration+dummyAccelerationX*sensitivity;
    
    if (playerVelocity.x>maxVelocity) {
        playerVelocity.x=maxVelocity;
    } else if(playerVelocity.x < -maxVelocity){
        playerVelocity.x = -maxVelocity;
    }
    
    hero.playerVelocity = playerVelocity;
    
    
    
    
    //    [self accelerometer:nil didAccelerate:nil];
}


-(void)update:(ccTime)delta{

    
    positionFlag++;
    if (positionFlag==10) {
        positionFlag=0;
        nowAt=hero.player.position;
    }
    CGPoint pos = hero.player.position;    
//    CCLOG(@"%f %f",pos.x,pos.y);
    pos.x+=hero.playerVelocity.x;
    CGSize screensize = [[CCDirector sharedDirector] winSize];
    
    //timer
    totalTime +=delta;
    int currentTime = (int)(totalTime*10);
    currentTime=currentTime*10;
//    if (score<currentTime) {
//        score=currentTime;
        [scoreLabel setString:[NSString stringWithFormat:@" Score: %d",currentTime]];
        scoreLabel.position = ccp(scoreLabel.contentSize.width/2, screensize.height);

//    }
    
    
    //bounds
    
    float imageWidthHalved = [hero.player boundingBox].size.width * 0.5f;
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = screensize.width-imageWidthHalved;
    if (pos.x<=leftBorderLimit) {
        pos.x=leftBorderLimit;
        hero.playerVelocity=CGPointZero;
        hero.player.position = pos;
        [self checkForCollision];
        return;
    } else if(pos.x>=rightBorderLimit) {
        pos.x=rightBorderLimit;
        hero.player.flipX=YES;
        hero.playerVelocity=CGPointZero;
        hero.player.position = pos;
        hero.player.flipX=NO;
        [self checkForCollision];
        return;
    }
    hero.player.position = pos;
    if (positionFlag==1) {
//        CCLOG(@"%f %f",pos.x,pos.y);
        CGPoint difference = ccpSub(pos, nowAt);
//        float actualDiff = ccpLength(difference);
//        CCLOG(@"%f",difference.x);
        if (difference.x<=0) {
            hero.player.flipX=YES;
        }else{
            hero.player.flipX=NO;
        }
    }
   

    //collision
    [self checkForCollision];
}


-(void)resetSpiders{
    
    totalTime=0;
    score=0;
    [scoreLabel setString:@"0"];

    [self runAction:[CCDelayTime actionWithDuration:1.0f]];
    
       
    //old code
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCSprite *tempSpider = [CCSprite spriteWithSpriteFrameName:@"sprite1.png"];
    tempSpider.scale=0.7;
    CGSize size = [tempSpider boundingBox].size;
    
    int numSpiders = [_spiders count];
    for (int i=0; i<numSpiders; i++) {
        Player *tempSpider = [_spiders objectAtIndex:i];
        tempSpider.player.position = ccp(size.width*i+size.width*0.5f-5, screenSize.height+size.height);
        
        [tempSpider.player stopAllActions];
        [tempSpider.player runAction:tempSpider.walkAction];
        tempSpider.playerMoveDuration = 4.0f;
    }
    
    [self unschedule:@selector(spidersUpdate:)];
    
    [self schedule:@selector(spidersUpdate:) interval:0.7f];
    
    numbSpidersMoved=0;
    
}


-(void)spidersUpdate:(ccTime)delta{

    for (int i=0; i<10; i++) {
        int randomSpiderIndex = CCRANDOM_0_1()*[_spiders count];
        Player *spider = [_spiders objectAtIndex:randomSpiderIndex];
        
        if ([spider.player numberOfRunningActions]==1) {
            [self runSpiderMoveSequence:spider];
            
            break;
        }
    }
}

-(void)runSpiderMoveSequence:(Player *)spider{
    numbSpidersMoved++;
    if (numbSpidersMoved%8==0 && spider.playerMoveDuration>0.5f) {
        if (spider.playerMoveDuration >1.5) {
            spider.playerMoveDuration-=0.1f;
        }
    }
    
    //spider move
    CGPoint belowScreenPosition = ccp(spider.player.position.x, -[spider.player boundingBox].size.height);
    spider.moveAction = [CCMoveTo actionWithDuration:spider.playerMoveDuration position:belowScreenPosition];
    
    CCCallFuncN* callDidDrop = [CCCallFuncN actionWithTarget:self selector:@selector(spiderDidDrop:)];
    CCSequence* sequence =[CCSequence actions:spider.moveAction,callDidDrop, nil];
    [spider.player runAction:sequence];
                                
}

-(void)spiderDidDrop:(id)sender{

    NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not ccsprite");
    CCSprite *spider = (CCSprite*)sender;
    
    CGPoint pos = spider.position;
    CGSize screenSize = [[CCDirector sharedDirector]winSize];
    pos.y=screenSize.height+[spider texture].contentSize.height;
    spider.position = pos;
    
}

-(void)checkForCollision{
    float playerImageSize = [hero.player boundingBox].size.width;
    Player *tempSpider = [_spiders lastObject];
    float spiderImageSize = [tempSpider.player boundingBox].size.width;
    float playerCollisionRadius = playerImageSize*0.4f;
    float spiderCollisionRadius = spiderImageSize*0.4f;
    
    
    float maxCollsionDistance = playerCollisionRadius+spiderCollisionRadius;
    
    int numSpiders = [_spiders count];
    for (int i=0; i<numSpiders; i++) {
        Player *spider = [_spiders objectAtIndex:i];
        if ([spider.player numberOfRunningActions]==0) {
            continue;
        }
        float actualDistance = ccpDistance(hero.player.position, spider.player.position);
        if (actualDistance<maxCollsionDistance) {
//            CCLOG(@"%f ,%@",actualDistance,self);
            CCArray *spideyArray = [[self getChildByTag:10]children];
            for (id spidey_dum in spideyArray ) {
                [spidey_dum stopAllActions];
            }            
            [self storeHighScore];
            
            //pause everything
            [hero.player stopAllActions];
//            [hero.player runAction:[CCJumpTo actionWithDuration:3 position:ccp(10, 10) height:100 jumps:1]];
            [spider.player stopAllActions];
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [[SimpleAudioEngine sharedEngine] playEffect:@"Death.caf"];
            
            [self unscheduleUpdate];
            
            //change scene with transition
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[GameOverLayer scene]]];
            
            
            break;
        }
    }
    
}

-(void)storeHighScore{
    
    AppDelegate *appd = [[UIApplication sharedApplication] delegate];
    int currentTime = (int)(totalTime*10);
    currentTime=currentTime*10;
       if (appd.highScore<currentTime) {           
        NSString *highScore=[NSString stringWithFormat:@"%d",currentTime];
        [[NSUserDefaults standardUserDefaults] setObject:highScore forKey:@"highScore"];

    }
    appd.currentScore=currentTime;
}

- (void)dealloc {
    CCLOG(@"%@: %@",NSStringFromSelector(_cmd),self);
    
    [_spiders release];
    _spiders=nil;
    [super dealloc];
}

@end
