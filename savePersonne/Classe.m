//
//  Classe.m
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "Classe.h"
#import "Formateur.h"
#import "Etudiant.h"

@implementation Classe


/*
 * Constructeur
 */
- (id)initWithDico{
    self.usersList = [[NSMutableDictionary alloc]init];
    self.loadedUsersList = [[NSString alloc]init];
    self.nbOfEtudiant = 0;
    self.nbOfFormateur = 0;
    return self;
}

/*
 * Sauvegarde le dictionnaire contenant les objects dans un fichier en XML
 *  input: void
 *  return: void
 */
/*- (void)registerUsersList:(NSMutableDictionary * )usersList{
    NSArray * paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", documentsURL.path, @"usersList.txt"];
    [usersList writeToFile:path atomically:YES];
}*/


/*
 * Lis et décode le fichier contenant les objets sauvegardés
 */

/*- (void)loadUsersList{
 NSArray * paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
 NSURL *documentsURL = [paths lastObject];
 NSString *path = [NSString stringWithFormat:@"%@/%@", documentsURL.path, @"usersList.txt"];
 
 
 NSError * error;
 self.loadedUsersList = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
 
 
 }*/



/*
 * cree un fichier binaire encoder pour pouvoir recreer automatiquement les objects au load du fichier.
 * (fct° du prof)
 *  input: void
 *  return: void
 */
- (void)registerUsersList{
    NSMutableData * data = [[NSMutableData alloc] init];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    int i=1;
    [archiver encodeInteger:self.usersList.count forKey:@"usersList"];
    for(Personne * personne in self.usersList){
        [archiver encodeObject:personne forKey:[NSString stringWithFormat:@"%i",i++]];
    }
    [archiver finishEncoding];
    
    NSArray * paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", documentsURL.path, @"usersList.txt"];
    BOOL result = [data writeToFile:path atomically:YES];
    
         
}

/*
 * load le fichier et recré les objets.
 * (fct° du prof)
 *  input: void
 *  return: void
 */
- (void)loadUsersList{
    NSMutableArray * personnesSauvees = [[NSMutableArray alloc]init];
    NSArray * paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSString *path = [NSString stringWithFormat:@"%@/%@", documentsURL.path, @"usersList.txt"];
    
    NSData *data;
    NSKeyedUnarchiver *decoder;
    data = [NSData dataWithContentsOfFile:path];
    decoder = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    int nbPersonnes = [decoder decodeIntegerForKey:@"usersList"];
    for(int i=1; i <= nbPersonnes; i++) {
        [personnesSauvees addObject:[decoder decodeObjectForKey:[NSString stringWithFormat:@"%i",i]]];
    }
    //NSError *error;
    self.usersList = [personnesSauvees copy];
    
}



/*
 * Ajoute une personne à la liste des personnes.
 * input: void
 * return: void
 */
- (void)addUser:(Personne *)newUser{
    
    NSDictionary * dico = @{
                            @"lastName":newUser.name,
                            @"firstName":newUser.firstName,
                            };
    
    
    if([newUser isKindOfClass:[Etudiant class]]){
        NSString * key = [NSString stringWithFormat: @"Etudiant%i",_nbOfEtudiant];
        [self.usersList setValue:dico forKey:key];
        
    }else if ([newUser isKindOfClass:[Formateur class]]){
        NSString * key = [NSString stringWithFormat: @"Formateur%i",_nbOfEtudiant];
        [self.usersList setValue:dico forKey:key];
    }
   
}

@end
