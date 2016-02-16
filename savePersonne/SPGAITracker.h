//
//  SPGAITracker.h
//  savePersonne
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Google/Analytics.h>

@interface SPGAITracker : NSObject
+ (void)trackView:(NSString*)viewName;

@end
