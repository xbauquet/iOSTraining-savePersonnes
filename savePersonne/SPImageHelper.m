//
//  SPImageHelper.m
//  savePersonne
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "SPImageHelper.h"

@implementation SPImageHelper


+ (NSString*)saveImage:(UIImage *)image{
    NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *guid = [[NSUUID new]UUIDString];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", guid]];
    NSData * imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:filePath atomically:YES];
    return guid;
}

+ (UIImage *)loadImage:(NSString *)imageName{
    NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
    return [UIImage imageWithContentsOfFile:filePath];
}

@end
