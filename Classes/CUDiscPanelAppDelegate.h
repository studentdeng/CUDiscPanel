//
//  CUDiscPanelAppDelegate.h
//  CUDiscPanel
//
//  Created by curer on 12-2-23.
//  Copyright 2012 curer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CUDiscPanelViewController;

@interface CUDiscPanelAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CUDiscPanelViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CUDiscPanelViewController *viewController;

@end

