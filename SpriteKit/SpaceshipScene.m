//
//  SpaceshitScene.m
//  SpriteKit
//
//  Created by Zakk Hoyt on 6/13/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "SpaceshipScene.h"


static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}


@interface SpaceshipScene ()
@property BOOL contentCreated;
@end

@implementation SpaceshipScene
- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];
    
    SKAction *makeRocks = [SKAction sequence: @[[SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.02 withRange:0.02]
                                                ]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];

}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    SKNode *spaceshipNode = [self childNodeWithName:@"spaceship"];
    if(spaceshipNode != nil){
        CGPoint point = [[touches anyObject] locationInNode:spaceshipNode.parent];
        
        SKAction *move = [SKAction moveByX:point.x - spaceshipNode.position.x y:point.y - spaceshipNode.position.y  duration:0.3];
        [spaceshipNode runAction:move completion:^{
            
        }];
    }
//    SKNode *helloNode = [self childNodeWithName:@"helloNode"];
//    if (helloNode != nil)
//    {
//        helloNode.name = nil;
//        SKAction *moveUp = [SKAction moveByX: 0 y: 100.0 duration: 0.5];
//        SKAction *zoom = [SKAction scaleTo: 2.0 duration: 0.25];
//        SKAction *pause = [SKAction waitForDuration: 0.5];
//        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
//        SKAction *remove = [SKAction removeFromParent];
//        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
//        [helloNode runAction: moveSequence completion:^{
//            SKScene *spaceshipScene  = [[SpaceshipScene alloc] initWithSize:self.size];
//            SKTransition *doors = [SKTransition flipHorizontalWithDuration:0.5];
//            [self.view presentScene:spaceshipScene transition:doors];
//        }];
//    }
}

- (void)addRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(4,4)];
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    rock.physicsBody.charge = -1.0;
    [self addChild:rock];
}

- (SKSpriteNode *)newSpaceship
{
//    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    SKSpriteNode *hull = [SKSpriteNode spriteNodeWithImageNamed:@"rocket.png"];

    hull.size = CGSizeMake(80, 80);
    hull.position = CGPointMake(10,10);
//    [self addChild:hull];
    hull.name = @"spaceship";
//    hull.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody = [SKPhysicsBody bodyWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"rocket.png"]] alphaThreshold:0.5 size:CGSizeMake(80, 80)];
    hull.physicsBody.dynamic = NO;
    
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-10.0, -10.0);
    [hull addChild:light1];
    
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(6.0, -10.0);
    [hull addChild:light2];
    
    SKAction *hover = [SKAction sequence:@[[SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    
    SKFieldNode *gravity = [SKFieldNode magneticField];
    gravity.strength = 10;
    [hull addChild:gravity];
    return hull;
}

- (SKSpriteNode *)newLight
{
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}

@end