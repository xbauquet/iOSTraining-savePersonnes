//
//  SPGAITracker.m
//  savePersonne
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "SPGAITracker.h"

@implementation SPGAITracker
+ (void)trackView:(NSString*)viewName{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:viewName];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

@end
