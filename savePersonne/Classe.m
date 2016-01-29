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
    self.listOfUsers = [NSArray new];
    self.nbOfEtudiant = 0;
    self.nbOfFormateur = 0;
    return self;
}


- (NSString *)documentPath{
    NSArray * paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    return [NSString stringWithFormat:@"%@/%@", documentsURL.path, @"usersList.txt"];
}


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
    [archiver encodeInteger:self.listOfUsers.count forKey:@"usersList"];
    for(Personne * personne in self.listOfUsers){
        [archiver encodeObject:personne forKey:[NSString stringWithFormat:@"%i",i++]];
    }
    [archiver finishEncoding];
    
    NSString *path = [self documentPath];
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
    
    NSString *path = [self documentPath];
    
    NSData *data;
    NSKeyedUnarchiver *decoder;
    data = [NSData dataWithContentsOfFile:path];
    decoder = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    int nbPersonnes = [decoder decodeIntegerForKey:@"usersList"];
    for(int i=1; i <= nbPersonnes; i++) {
        [personnesSauvees addObject:[decoder decodeObjectForKey:[NSString stringWithFormat:@"%i",i]]];
    }
    //NSError *error;
    self.listOfUsers = [personnesSauvees copy];
    
}


/*
 * Ajoute une personne à la liste des personnes.
 * input: void
 * return: void
 */
- (void)addUser:(Personne *)newUser{
    NSMutableArray * tmp = [[NSMutableArray alloc]init];
    [tmp addObjectsFromArray:self.listOfUsers];
    [tmp addObject:newUser];
    self.listOfUsers = [tmp copy];
   
}

@end
