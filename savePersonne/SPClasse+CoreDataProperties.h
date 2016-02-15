//
//  SPClasse+CoreDataProperties.h
//  savePersonne
//
//  Created by xavier on 15/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SPClasse.h"

NS_ASSUME_NONNULL_BEGIN

@interface SPClasse (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<SPPersonne *> *personne;

@end

@interface SPClasse (CoreDataGeneratedAccessors)

- (void)addPersonneObject:(SPPersonne *)value;
- (void)removePersonneObject:(SPPersonne *)value;
- (void)addPersonne:(NSSet<SPPersonne *> *)values;
- (void)removePersonne:(NSSet<SPPersonne *> *)values;

@end

NS_ASSUME_NONNULL_END
