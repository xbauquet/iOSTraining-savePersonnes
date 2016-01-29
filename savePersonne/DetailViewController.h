//
//  DetailViewController.h
//  savePersonne
//
//  Created by xavier on 28/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Personne.h"

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *classLabelRegistered;
@property (weak, nonatomic) IBOutlet UILabel *nameLabelRegistered;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabelRegistered;

@property Personne * personne;

- (IBAction)returnCloseDetailViewControler:(id)sender;

@end
