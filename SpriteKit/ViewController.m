//
//  ViewController.m
//  SpriteKit
//
//  Created by Zakk Hoyt on 6/13/14.
//  Copyright (c) 2014 Zakk Hoyt. All rights reserved.
//

#import "ViewController.h"
//@import SceneKit;
@import SpriteKit;

#import "MyScene.h"
#import "HelloScene.h"


@interface ViewController ()
@property (strong, nonatomic) SKView *skView;
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.skView = [[SKView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.skView];
    self.skView.showsDrawCount = YES;
    self.skView.showsNodeCount = YES;
    self.skView.showsFPS = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    HelloScene *hello = [[HelloScene alloc]initWithSize:self.view.frame.size];
    [self.skView presentScene:hello];
    
}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//-(void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    
//    // Configure the view.
//    if (!self.skView.scene) {
//        self.skView.showsFPS = YES;
//        self.skView.showsNodeCount = YES;
//        
//        // Create and configure the scene.
//        SKScene * scene = [MyScene sceneWithSize:self.skView.bounds.size];
//        scene.scaleMode = SKSceneScaleModeAspectFill;
//        
//        // Present the scene.
//        [self.skView presentScene:scene];
//    }
//}
@end
