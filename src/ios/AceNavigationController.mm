//-------------------------------------------------------------------------------------------------------
// Copyright (C) Microsoft. All rights reserved.
// Licensed under the MIT license. See LICENSE.txt file in the project root for full license information.
//-------------------------------------------------------------------------------------------------------
#import "AceNavigationController.h"
#import "Utils.h"

@implementation AceNavigationController

- (id)init {
    self = [super init];

    self.NavigationMode = NavigationModeNone;
    self.InsideNativeInitiatedBackNavigation = false;

    return self;
}

- (void)viewWillLayoutSubviews {
    // This is done here rather than in AceViewController so it impacts
    // every view controller, including the default Cordova one.

    NSArray* subviews = [self.topViewController.view subviews];

    // Only resize to fullscreen if there's a single (non-TabBar) subview.
    if (subviews.count == 1) {
        ((UIView*)subviews[0]).frame = [UIScreen mainScreen].bounds;
    }
    else if (subviews.count == 2) {
        if ([subviews[0] isKindOfClass:[UITabBar class]]) {
            CGRect r = [UIScreen mainScreen].bounds;
            UITabBar* tabBar = (UITabBar*)subviews[0];
            [tabBar sizeToFit];
            tabBar.frame = CGRectMake(r.origin.x, r.size.height - tabBar.frame.size.height, r.size.width, tabBar.frame.size.height);
            ((UIView*)subviews[1]).frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height - tabBar.frame.size.height);
        }
        else if ([subviews[1] isKindOfClass:[UITabBar class]]) {
            CGRect r = [UIScreen mainScreen].bounds;
            UITabBar* tabBar = (UITabBar*)subviews[1];
            [tabBar sizeToFit];
            tabBar.frame = CGRectMake(r.origin.x, r.size.height - tabBar.frame.size.height, r.size.width, tabBar.frame.size.height);
            ((UIView*)subviews[0]).frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height - tabBar.frame.size.height);
        }
    }
}

// Only works when navigation bar is shown. The view controller handles the other case.
-(UIStatusBarStyle)preferredStatusBarStyle{
/*TODO
    if (theme == Default || theme == Dark)
*/
        return UIStatusBarStyleDefault;
/*  else
        return UIStatusBarStyleLightContent;
*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
