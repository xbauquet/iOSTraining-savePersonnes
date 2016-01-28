//
//  Personne.m
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "Personne.h"

@implementation Personne

- (id)initWithName:(NSString *)firstName lastName:(NSString *)lastName{
    
    self = [super init];
    if(self){
        _firstName = firstName;
        _name = lastName;
    }
    return self;
}


@end
