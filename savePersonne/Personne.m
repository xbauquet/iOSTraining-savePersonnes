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
#define ImageName @"imageName"

@implementation Personne


- (id)initWithName:(NSString *)firstName lastName:(NSString *)lastName imageName:(NSString *) imageName{
    
    self = [super init];
    if(self){
        _firstName = firstName;
        _name = lastName;
        _imageName = imageName;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.name forKey:PersonneName];
    [coder encodeObject:self.firstName forKey:PersonneFirstName];
    [coder encodeObject:self.imageName forKey:ImageName];
}

- (id)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if(self){
        _name = [coder decodeObjectForKey:PersonneName];
        _firstName = [coder decodeObjectForKey:PersonneFirstName];
        _imageName = [coder decodeObjectForKey:ImageName];
    }
    return self;
}

- (NSString *)getClass{
    return @"Personne";
}

@end
