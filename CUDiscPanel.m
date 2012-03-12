//
//  CUDiscPanel.m
//  CUDiscPanel
//
//  Created by curer on 12-2-23.
//  Copyright 2012 curer. All rights reserved.
//

#import "CUDiscPanel.h"
#import "KTOneFingerRotationGestureRecognizer.h"

#define RADIANSMAX 2 * M_PI
#define RADIUS     120

static CGPoint RotateCGPointAroundCenter(CGPoint point, CGPoint center, float angle)
{
    CGAffineTransform translation = CGAffineTransformMakeTranslation(center.x, center.y);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(angle);
    CGAffineTransform transformGroup = CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformInvert(translation), rotation), translation);
    return CGPointApplyAffineTransform(point, transformGroup);    
}

//将弧度修正未i / icount 倍数

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
static CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180 / M_PI;};

static int ReCulRotateToDegree(float aRotate)
{
    // 默认的坐标系，太坑爹，左半边<0 右半边 >0 这里，我们修正方向 为 顺时针方向。
    int rot = RadiansToDegrees(aRotate);
    
    if (rot < 0) {
        rot += 360;
    }
    
    return rot;
}

@implementation CUDiscPanel

@synthesize backgroundView;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        KTOneFingerRotationGestureRecognizer *rotationGesture = 
            [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self 
                                                                  action:@selector(rotating:)];
        [self addGestureRecognizer:rotationGesture];
        [rotationGesture release];
        
        UIImageView *aImageView = [[UIImageView alloc] initWithFrame:frame];
        self.backgroundView = aImageView;
        [aImageView release];
        
        [self addSubview:self.backgroundView];
        
        self.userInteractionEnabled = YES;
        self.backgroundView.userInteractionEnabled = YES;
        
        buttonList = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [backgroundView release];
    [buttonList release];
    
    [super dealloc];
}

- (void)setBackgroundImage:(UIImage *)image
{
    self.backgroundView.image = image;
}

- (void)addButton:(UIButton *)button
{
    if (button == nil) {
        return ;
    }
    
    [buttonList addObject:button];
}

- (void)setButtonListPosition
{
    int iCount = [buttonList count];
    if (iCount == 0) {
        return;
    }
    
    int x = self.bounds.size.width / 2;
    int y = self.bounds.size.height / 2;
    
    CGPoint startPoint = CGPointMake(x, y);
    
    int i = 0;
    for (UIButton *item in buttonList) {
        
        [item removeFromSuperview];
        
        CGPoint endPoint = CGPointMake(startPoint.x + RADIUS * sinf(RADIANSMAX * i / iCount), 
                                       startPoint.y - RADIUS * cosf(RADIANSMAX * i / iCount));
        
        endPoint = RotateCGPointAroundCenter(endPoint, startPoint, 0);
        
        item.center = endPoint;
        
        [self addSubview:item];
        
        ++i;
    }
}

- (void)addRotate:(float_t)aRotate
{
    [self setTransform:CGAffineTransformRotate([self transform],aRotate)];
    rotation =  [[self.layer valueForKeyPath:@"transform.rotation.z"] 
                 floatValue];
    
    CGFloat childRotation = -1 * (aRotate);
    for (UIButton *item in buttonList) {
        [item setTransform:CGAffineTransformRotate([item transform], childRotation)];
    }
}

- (void)setRoatate:(float_t)aRotate
{
    [self setTransform:CGAffineTransformMakeRotation(aRotate)];
    
    rotation =  [[self.layer valueForKeyPath:@"transform.rotation.z"] 
                 floatValue];
}

- (void)roundPos
{
    maxSpeed = 0;
    int iCount = [buttonList count];
    int unit = 360 / iCount;
    int rot = ReCulRotateToDegree(rotation);
    
    int y = rot / unit;
    
    
    int dif = rot % unit;
    if (dif >= unit / 2) {
        y++;
    }
    
    [UIView animateWithDuration:.5f 
                     animations:^{
                         
                         float r2 = DegreesToRadians(y) * unit;
                         
                         CGFloat childRotation = -1 * (r2);
                         for (UIButton *item in buttonList) {
                             [item setTransform:CGAffineTransformMakeRotation(childRotation)];
                         }
                         
                         [self setRoatate:r2];
                     }];
}

- (void)calculateSpeed
{
    if (0) {
        [UIView animateWithDuration:.4 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseOut 
                         animations:^{
                             
                             [self addRotate:DegreesToRadians(90)];
                             
                             
                         } completion:^(BOOL b){
                             [self roundPos];
                         }];
    }
    else {
        [self roundPos]; 
    }
    
    startRotation = rotation;
    maxSpeed = 0;
}

- (void)changeColor
{
    for (UIButton *item in buttonList) {
        item.backgroundColor = [UIColor redColor];
    }
    
    if ([buttonList count] == 0) {
        return;
    }
    
    int degree = ReCulRotateToDegree(rotation);
    int index = 0;
    int unit = 360 / [buttonList count];
    if (degree > unit / 2 && degree <= 360 - unit / 2) {
        degree -= unit / 2;
        index = [buttonList count]-1 - degree / unit;
    }
    
    UIButton *item = [buttonList objectAtIndex:index];
    item.backgroundColor = [UIColor blackColor];
}

- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self calculateSpeed];
    }
    else {
        [self addRotate:[recognizer rotation]];
    }
    
    [self changeColor];
}

@end
