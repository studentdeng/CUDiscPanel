//
//  CUDiscPanel.h
//  CUDiscPanel
//
//  Created by curer on 12-2-23.
//  Copyright 2012 curer. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CUDiscPanel : UIView {
    UIImageView *backgroundView;
    
    NSMutableArray *buttonList;
    
    float rotation;
    float startRotation;
    
    float maxSpeed;
}

- (void)addButton:(UIButton *)button;
//- (void)showButtonList;
- (void)setBackgroundImage:(UIImage *)image;
- (void)roundPos;
- (void)setButtonListPosition;

@property (nonatomic, retain) UIImageView *backgroundView;

@end
