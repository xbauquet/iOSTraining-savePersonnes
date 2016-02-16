//
//  DetailViewController.m
//  savePersonne
//
//  Created by xavier on 28/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "SPImageHelper.h"
#import "SPGAITracker.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classLabelRegistered.text = self.personne.getClass;
    self.nameLabelRegistered.text = self.personne.name;
    self.firstNameLabelRegistered.text = self.personne.firstName;
    self.imageView.image = [SPImageHelper loadImage:self.personne.imageName];
}


- (void)viewWillAppear:(BOOL)animated{
    // GOOGLE ANALYTICS
    [SPGAITracker trackView:@"detailViewController"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
