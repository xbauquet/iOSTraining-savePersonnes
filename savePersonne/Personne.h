//
//  Personne.h
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Personne : NSObject

/*
 * Properties
 */
@property NSString *name;
@property NSString *firstName;
@property NSString *type;

- (id)initWithName:(NSString *)firstName lastName:(NSString *)lastName;

@end
