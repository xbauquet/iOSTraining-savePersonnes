//
//  SPImageHelper.h
//  savePersonne
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPImageHelper : NSObject

+ (NSString*)saveImage:(UIImage *)image;
+ (UIImage *)loadImage:(NSString *)imageName;

@end
