//
//  MZGoogleStyleButton.m
//  Pods
//
//  Created by Monzy Zhang on 5/12/16.
//
//

#import "MZGoogleStyleButton.h"
@interface MZGoogleStyleButton ()
@property (nonatomic, strong) CALayer *circleLayer;
@end

@implementation MZGoogleStyleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer addSublayer:self.circleLayer];
        self.layerOpaque = 0.6;
        self.duration = 0.3;
        self.layerColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.circleLayer.opacity = self.layerOpaque;
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.circleLayer.position = touchPoint;
    [CATransaction commit];
    [CATransaction setDisableActions:NO];
    [self enlargeFromPoint: touchPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self endAnimation];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self endAnimation];
}

- (void)endAnimation
{
    [self.circleLayer removeAllAnimations];
    self.circleLayer.opacity = 0.0;
    self.circleLayer.transform = CATransform3DIdentity;
}

- (void)enlargeFromPoint:(CGPoint)point
{
    CABasicAnimation *enlargeAnimation = [CABasicAnimation animation];
    enlargeAnimation.keyPath = @"transform";
    CGFloat radius = ceil([self radiusFromPoint:point]);
    enlargeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(radius, radius, 1)];
    enlargeAnimation.duration = self.duration;
    enlargeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.circleLayer addAnimation:enlargeAnimation forKey:@"googleLikeButtonAnimation"];
    self.circleLayer.transform = CATransform3DMakeScale(radius, radius, 1);
}

- (CGFloat)radiusFromPoint:(CGPoint)point
{
    CGFloat max = [self distance:point p2:self.bounds.origin];
    CGFloat new = [self distance:point p2:CGPointMake(0, CGRectGetHeight(self.bounds))];
    max = MAX(new, max);

    new = [self distance:point p2:CGPointMake(CGRectGetWidth(self.bounds), 0)];
    max = MAX(new, max);

    new = [self distance:point p2:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    max = MAX(new, max);
    return max * 2;
}

- (CGFloat)distance:(CGPoint)p1 p2:(CGPoint)p2
{
    return sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
}

- (CALayer *)circleLayer
{
    if (!_circleLayer) {
        _circleLayer = [CAShapeLayer layer];
        _circleLayer.frame = CGRectMake(0, 0, 1, 1);
        _circleLayer.cornerRadius = 0.5;
        _circleLayer.masksToBounds = YES;
    }
    return _circleLayer;
}

- (void)setLayerColor:(UIColor *)layerColor
{
    _layerColor = layerColor;
    _circleLayer.backgroundColor = _layerColor.CGColor;
}
@end
