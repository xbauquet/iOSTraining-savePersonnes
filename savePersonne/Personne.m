//
//  Personne.m
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "Personne.h"
#define PersonneName @"name"
#define PersonneFirstName @"firstName"

@implementation Personne


- (id)initWithName:(NSString *)firstName lastName:(NSString *)lastName{
    
    self = [super init];
    if(self){
        _firstName = firstName;
        _name = lastName;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:PersonneName];
    [coder encodeObject:self.firstName forKey:PersonneFirstName];
    
}

- (id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if(self){
        _name = [coder decodeObjectForKey:PersonneName];
        _firstName = [coder decodeObjectForKey:PersonneFirstName];
    }
    return self;
}

- (NSString *)getClass{
    return @"Personne";
}

@end
