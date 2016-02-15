//
//  SPPersonne+CoreDataProperties.h
//  savePersonne
//
//  Created by xavier on 15/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SPPersonne.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPPersonne (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *imageName;
@property (nullable, nonatomic, retain) NSString *name;

- (NSString *)getClass;

@end

NS_ASSUME_NONNULL_END
