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
#import "Personne.h"
#import "Etudiant.h"
#import "Formateur.h"
#import "Intervenant.h"

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
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.center =self.view.center;
    [self.view addSubview:activityView];
    activityView.color = [UIColor redColor];
    
    [activityView startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [[Classe sharedCLassManager] loadUsersList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [activityView stopAnimating];
            
            
        });
        
    });
    
}


- (void)refreshMe{
    
    //affichage de la marguerite
    [activityView startAnimating];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [[Classe sharedCLassManager] loadUsersList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [activityView stopAnimating];
            
        });
        
    });
    [self.refreshControl endRefreshing];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Classe sharedCLassManager].listOfUsers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Personne *personne = [[Classe sharedCLassManager].listOfUsers objectAtIndex:indexPath.row];
    UITableViewCell *cell;
    
    
    
    if([personne isKindOfClass:[Etudiant class]]){
        
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
    Personne *personne = [[Classe sharedCLassManager].listOfUsers objectAtIndex:indexPath.row];
    if([personne isKindOfClass:[Etudiant class]]){
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
        detailVC.personne = [[Classe sharedCLassManager].listOfUsers objectAtIndex:ip.row];
        
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



// Override to support editing the table view.
/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [[Classe sharedCLassManager] removeUserAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}*/



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
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
            
        [[Classe sharedCLassManager] removeUserAtIndex:indexPath.row];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //blabla
            });
            
        });
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[deleteAction,editAction];
    
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
 
}
*/


/*// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}*/



@end
