//
//  DetailViewController.m
//  savePersonne
//
//  Created by xavier on 28/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.classLabelRegistered setText:[NSString stringWithCString:object_getClassName(self.personne.class) encoding:NSUTF8StringEncoding]];
    [self.classLabelRegistered setText:[self.personne getClass]];
    [self.nameLabelRegistered setText:self.personne.name];
    [self.firstNameLabelRegistered setText:self.personne.firstName];

     }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Ferme la vu.
 */
- (IBAction)returnCloseDetailViewControler:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
