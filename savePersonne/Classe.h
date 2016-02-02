//
//  Classe.h
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Personne.h"

@interface Classe : NSObject

@property NSArray * listOfUsers;

- (void)registerUsersList;
- (void)addUser:(Personne *)newUser;
- (void)loadUsersList;
//- (id)initWithDico;
- (NSString *)documentPath;
- (void)removeUserAtIndex:(NSUInteger) index;
- (NSString *)saveImage:(UIImage *)image;

// singleton
+ (Classe*)sharedCLassManager;
@end

