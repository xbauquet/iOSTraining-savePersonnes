//
//  TableViewController.m
//  savePersonne
//
//  Created by xavier on 29/01/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import "TableViewController.h"
#import "Classe.h"
#import "DetailViewController.h"
#import "ModifyViewController.h"
#import "TableViewCellController.h"
#import "SPPersonne.h"
#import "SPEtudiant.h"
#import "SPFormateur.h"
#import "SPIntervenant.h"
#import "AppDelegate.h"
#import "SPGAITracker.h"


@interface TableViewController ()

@end

@implementation TableViewController

//affichage de la marguerite
UIActivityIndicatorView *activityView;

NSIndexPath *tmpIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self slideRefresh];
}




- (void)slideRefresh{
    // Crée le refresh quand on tire la liste vers le bas
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshMe) forControlEvents:UIControlEventValueChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    // GOOGLE ANALYTICS
    [SPGAITracker trackView:@"tableViewController"];
    
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center =self.view.center;
    [self.view addSubview:activityView];
    activityView.color = [UIColor redColor];
    
    [activityView startAnimating];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.listOfPerson = [appDelegate.maClasse.personne allObjects];
    [activityView stopAnimating];
    [self.tableView reloadData];
}


- (void)refreshMe{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.listOfPerson = [appDelegate.maClasse.personne allObjects];

    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfPerson.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SPPersonne *personne = [self.listOfPerson objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    
    
    if([personne isKindOfClass:[SPEtudiant class]]){
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"maCelluleCustom" forIndexPath:indexPath];
        ((TableViewCellController *)cell).cellLabel.text = [NSString stringWithFormat:@"%@ %@", personne.name, personne.firstName];
        NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@", personne.imageName]]];
        ((TableViewCellController *)cell).cellImage.image = [UIImage imageWithContentsOfFile:filePath];
        
        
    }else{
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"maCellule" forIndexPath:indexPath];
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", personne.name, personne.firstName];
    
        cell.detailTextLabel.text = personne.getClass;
        
        NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@", personne.imageName]]];
        cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SPPersonne *personne = [self.listOfPerson objectAtIndex:indexPath.row];
    if([personne isKindOfClass:[SPEtudiant class]]){
        return 180;
    }else{
        return 44;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        detailVC.personne = [self.listOfPerson objectAtIndex:ip.row];
        
    }else if([segue.identifier isEqualToString:@"modifySegue"]){
        ModifyViewController * mVC = segue.destinationViewController;
        mVC.indexPath = tmpIndexPath;

    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    tmpIndexPath = indexPath;
    
    // EDIT
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        self.rowIndex = indexPath;
        [self performSegueWithIdentifier:@"modifySegue" sender:self];
        

    }];
    //[UIColor colorWithRed:14.0/255.0 green:114.0/255.0 blue:199.0/255.0 alpha:1]
    editAction.backgroundColor = [UIColor colorWithRed:129.0/255.0 green:207.0/255.0 blue:224.0/255.0 alpha:1];
    
    
    // DELETE
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       
        // threading
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate.maClasse removePersonneObject:[self.listOfPerson objectAtIndex:indexPath.row]];
            [appDelegate.managedObjectContext deleteObject:[self.listOfPerson objectAtIndex:indexPath.row]];
            [appDelegate saveContext];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.listOfPerson = [appDelegate.maClasse.personne allObjects];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
            
        });
        
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
    
}

@end
