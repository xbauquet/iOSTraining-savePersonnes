//
//  ViewController.h
//  savePersonne
//
//  Created by xavier on 27/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *inputName;
@property (weak, nonatomic) IBOutlet UITextField *inputFirstName;
@property (weak, nonatomic) IBOutlet UISwitch *switchFormateur;
@property (weak, nonatomic) IBOutlet UISwitch *switchEtudiant;
@property (weak, nonatomic) IBOutlet UISwitch *switchIntervenant;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)annulerButton:(id)sender;
- (void)errorLabelSelector;
- (void)temporaryErrorLabelDisplayer:(NSString *) label;
- (IBAction)changeImageButton:(id)sender;
//- (NSString *)saveImage;

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;

@end

