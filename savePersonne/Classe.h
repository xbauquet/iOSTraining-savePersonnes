//
//  Classe.h
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Personne.h"

@interface Classe : NSObject

@property NSMutableDictionary *usersList;
@property NSString *loadedUsersList;
@property int nbOfFormateur;
@property int nbOfEtudiant;

//- (void)registerUsersList:(NSMutableDictionary * )usersList ;
- (void)registerUsersList;
- (void)addUser:(Personne *)newUser;
- (void)loadUsersList;
- (id)initWithDico;
@end

