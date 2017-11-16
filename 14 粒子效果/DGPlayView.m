//
//  DGPlayView.m
//  14 粒子效果
//
//  Created by MAC on 2017/9/2.
//  Copyright © 2017年 GuoDongge. All rights reserved.
//

#import "DGPlayView.h"
@interface DGPlayView()

/**
 绘制路径
 */
@property(nonatomic,strong)UIBezierPath * path;
/**小点点图层*/
@property(nonatomic,weak)CALayer * dotLayer;

/**复制层*/
@property(nonatomic,weak)CAReplicatorLayer * repLayer;

@end
@implementation DGPlayView
//粒子的数量
static int dotCount;

#pragma mark - 懒加载路径
-(UIBezierPath *)path
{
    if (_path == nil) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

#pragma mark - 懒加载点层
-(CALayer *)dotLayer
{
    if (_dotLayer == nil) {
        //创建小点点图层
        CALayer * layer = [CALayer layer];
        CGFloat wh = 10;
        //y值设为负数的作用是为了隐藏左上角显示的图层
        layer.frame = CGRectMake(0, -10, wh, wh);
        
        layer.cornerRadius = wh / 2;
        
        layer.backgroundColor = [UIColor redColor].CGColor;
        
        [_repLayer addSublayer:layer];
        
        _dotLayer = layer;

    }
    
    return _dotLayer;
}

#pragma mark - 开始动画
-(void)startAnim
{
//    NSLog(@"%s",__func__);
    
    //创建帧动画
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    //给动画设置路径，这一步很关键
    anim.path = _path.CGPath;
    anim.duration = 5;
    anim.repeatCount = MAXFLOAT;
    //给图层添加动画
    [self.dotLayer addAnimation:anim forKey:nil];
    
    //复制子层
    _repLayer.instanceCount = dotCount;
    
    _repLayer .instanceDelay = 0.2;
}

#pragma mark - 重绘
-(void)reDraw
{
    //清空绘图信息
    _path = nil;
    
    [self setNeedsDisplay];
    
    [_dotLayer removeFromSuperlayer];
    _dotLayer = nil;
    
    //清空点子层总数
    dotCount = 0;
    
    
}

#pragma mark - awakeFromNib
-(void)awakeFromNib
{
    [super awakeFromNib];
    //创建复制层
    CAReplicatorLayer * repL = [CAReplicatorLayer layer];
    
    repL.frame = self.bounds;
    [self.layer addSublayer:repL];
    
    
    _repLayer = repL;
    
}

#pragma mark - touchesBegan:
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    //获取当前触摸点
    CGPoint curP = [touch locationInView:self];
    
        //设置起点
    [self.path moveToPoint:curP];
    
    
}

#pragma mark - touchesMoved:
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    //添加线到当前点
    [self.path addLineToPoint:curP];
    
    [self setNeedsDisplay];
    
    dotCount ++;
    
}

#pragma mark - drawRect:
- (void)drawRect:(CGRect)rect {
    
    
    [_path stroke];
    
    
    
}


@end
