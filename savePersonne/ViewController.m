//
//  ViewController.m
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "ViewController.h"
#import "Formateur.h"
#import "Etudiant.h"
#import "Personne.h"
#import "Classe.h"

@interface ViewController ()

@end

@implementation ViewController
Classe * classe;

/*
 * Méthode executé au démarage de l'app (constructeur de la view).
 * input: void
 * return: void
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.inputName setText:@""];
    [self.inputFirstName setText:@""];
    [self.errorLabel setText:@""];
    self.switchEtudiant.on = NO;
    self.switchFormateur.on = NO;
    classe = [[Classe alloc]initWithDico];
    
    [classe loadUsersList];
}



/*
 * Selector utiliser dans temporaryErrorLabelDisplayer, set errorLabel à vide.
 * input: void
 * return: void
 */
- (void)errorLabelSelector{
    [self.errorLabel setText:@""];
}


/*
 * Change la valeur de errorLabel à "Erreur" pendant 3 secondes.
 * input: void
 * return: void
 */
- (void)temporaryErrorLabelDisplayer{
    [self.errorLabel setText:@"Erreur"];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector: @selector(errorLabelSelector) userInfo:nil repeats:NO];
}



/*
 * En cas de MemoryWarning essaye de liberer de la memoire.
 * input: void
 * return: void
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 * Actions effectuées lors de l'appuis sur le bouton Valider.
    - Test les erreurs de saisie dans le formulaire
    - Crée les nouveaux objets Personnage (Formateur, Etudiant ...)
    - Enregistre la liste des Personnages dans un fichier
 * input: (id)
 * return: void
 */
- (IBAction)validerButton:(id)sender {
    
    // Test les erreurs et appel temporaryErrorLabelDisplayer
    if((self.switchFormateur.on && self.switchEtudiant.on) || ![self.inputName hasText]  || ![self.inputFirstName hasText]){
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer];
        
    }else if(self.switchFormateur.on){
        
        Formateur *newFormateur = [[Formateur alloc] initWithName:[self.inputName text] lastName:[self.inputFirstName text]];
        
        [classe addUser:newFormateur];
        
    }else if(self.switchEtudiant.on){
        Etudiant *newEtudiant = [[Etudiant alloc] initWithName:[self.inputName text] lastName:[self.inputFirstName text]];

        [classe addUser:newEtudiant];
        
    }else{
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer];
    }

    [classe registerUsersList];
    
    [self annulerButton:nil];
}



/*
 * Vide les champs du formulaire.
 * input: void
 * return: void
 */
- (IBAction)annulerButton:(id)sender {
    [self.inputName setText:@""];
    [self.inputFirstName setText:@""];
    self.switchEtudiant.on = NO;
    self.switchFormateur.on = NO;
    
}

@end
