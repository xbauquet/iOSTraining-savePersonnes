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
#import "Intervenant.h"
#import "Classe.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface ViewController () <UIImagePickerControllerDelegate>

@end

@implementation ViewController

//affichage de la marguerite
//UIActivityIndicatorView *activityView;

/*
 * Méthode executé au démarage de l'app (constructeur de la view).
 * input: void
 * return: void
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self annulerButton:nil];
    [self.errorLabel setText:@""];
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
- (void)temporaryErrorLabelDisplayer:(NSString *) label{
    [self.errorLabel setText:label];
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector: @selector(errorLabelSelector) userInfo:nil repeats:NO];
}



/*
 * En cas de MemoryWarning essaye de liberer de la memoire.
 * input: void
 * return: void
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    self.switchIntervenant.on = NO;
    self.imageView.image = nil;
    
}

// Test les erreurs et appel temporaryErrorLabelDisplayer
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if((self.switchFormateur.on && self.switchEtudiant.on)){
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer:NSLocalizedString(@"errorMoreThanOneClass", nil)];
        return NO;
        
    }else if (![self.inputName hasText]){
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer:NSLocalizedString(@"errorMissingName", nil)];
        return NO;
    }else if (![self.inputFirstName hasText]){
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer:NSLocalizedString(@"errorMissingFirstName", nil)];
        return NO;
    }else if(!self.switchFormateur.on && !self.switchEtudiant.on && !self.switchIntervenant.on){
        [self annulerButton:nil];
        [self temporaryErrorLabelDisplayer:NSLocalizedString(@"errorMissingClass", nil)];
        return NO;
    }
    
    return YES;
}

- (IBAction)touchOutside:(id)sender {
    self.inputName.selected = NO;
    self.inputFirstName.selected = NO;
    [self.inputName resignFirstResponder];
    [self.inputFirstName resignFirstResponder];
}



/*
 * Actions effectuées lors de l'appuis sur le bouton Valider.
 - Test les erreurs de saisie dans le formulaire
 - Crée les nouveaux objets Personnage (Formateur, Etudiant ...)
 - Enregistre la liste des Personnages dans un fichier
 * input: (id)
 * return: void
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
    if([segue.identifier isEqualToString:@"detailViewControllerSegue"]){
        
        DetailViewController *detailVC = segue.destinationViewController;
        NSString * type;
        if(self.switchFormateur.on){ // FORMATEUR
            type = @"SPFormateur";
//            Formateur *newFormateur = [[Formateur alloc] initWithName:[self.inputName text] lastName:[self.inputFirstName text] imageName:[[Classe sharedCLassManager] saveImage:self.imageView.image]];
//            
//            // threading
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                
//                [[Classe sharedCLassManager] addUser:newFormateur];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //blabla
//                });
//                
//            });
//            
//            
//            detailVC.personne = newFormateur;
            
        }else if(self.switchEtudiant.on){ // ETUDIANT
            type = @"SPEtudiant";
//            Etudiant *newEtudiant = [[Etudiant alloc] initWithName:[self.inputName text] lastName:[self.inputFirstName text] imageName:[[Classe sharedCLassManager] saveImage:self.imageView.image]];
//            
//            // threading
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                
//                [[Classe sharedCLassManager] addUser:newEtudiant];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //blabla
//                });
//                
//            });
//            
//
//            detailVC.personne = newEtudiant;
            
        }else if(self.switchIntervenant.on){ // INTERVENANT
            type = @"SPIntervenant";
//            Intervenant *newIntervenant = [[Intervenant alloc] initWithName:[self.inputName text] lastName:[self.inputFirstName text] imageName:[[Classe sharedCLassManager] saveImage:self.imageView.image]];
//            
//            
//            // threading
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                
//                [[Classe sharedCLassManager] addUser:newIntervenant];
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //blabla
//                });
//                
//            });
//            
//            detailVC.personne = newIntervenant;
//            
//            
        }
        
        
        // New method to use
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [appDelegate managedObjectContext];
        NSManagedObject *newPersonne;
        
        newPersonne = [NSEntityDescription insertNewObjectForEntityForName:type inManagedObjectContext:context];
        [newPersonne setValue:self.inputName.text forKey:@"name"];
        [newPersonne setValue:self.inputFirstName.text forKey:@"firstName"];
        
        //save image
        NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *guid = [[NSUUID new]UUIDString];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", guid]];
        NSData * imageData = UIImagePNGRepresentation(self.imageView.image);
        [imageData writeToFile:filePath atomically:YES];
        
        [newPersonne setValue:[NSString stringWithFormat:@"%@.png", guid] forKey:@"name"];
        NSError *error;
        [context save:&error]; // save the context
        
        [classe addNewRelationshipObject:(SPPersonne*)newPersonne];
        
        
        [self annulerButton:nil];
        
        
    }
}

/* --------------------------------------
 * Image
 * --------------------------------------
 */

/*
 * Changement de l'image dans imageView
 */
- (void)imagePickerController:(UIImagePickerController *) picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

/*
 * onClick sur changeImageButton déclanche le selecteur d'image du téléphone
 */
- (IBAction)changeImageButton:(id)sender{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self; // dit au téléphone de renvoyer la photo selectionnée avec picker vers nous.
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)takePictureButton:(id)sender{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.delegate = self; // dit au téléphone de renvoyer la photo selectionnée avec picker vers nous.
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:picker animated:YES completion:NULL];
}






@end
