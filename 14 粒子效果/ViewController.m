//
//  ViewController.m
//  14 粒子效果
//
//  Created by MAC on 2017/9/2.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "ViewController.h"
#import "DGPlayView.h"

@interface ViewController ()

@property(nonatomic,strong)DGPlayView * playView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
}

- (IBAction)startAnim {
    
    
    _playView = (DGPlayView*)self.view;
    
    [_playView startAnim];
    
    
    
}



- (IBAction)reDraw {
    
     _playView = (DGPlayView*)self.view;
    [_playView reDraw];
    
    
}




@end
