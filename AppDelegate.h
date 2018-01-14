//
//  AppDelegate.h
//  CrytoPortfolio
//
//  Created by Ray de Rose on 2017/12/25.
//  Copyright © 2017 Ray de Rose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MDProfileSliderVC.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navVC;
    MDProfileSliderVC *profileVC;
}

@property (strong, nonatomic) UIWindow *window;
@property ( strong, nonatomic) UINavigationController *navVC;
@property( strong, nonatomic) MDProfileSliderVC *profileVC;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

