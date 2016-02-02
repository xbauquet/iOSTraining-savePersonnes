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

@interface TableViewController ()

@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Crée le refresh quand on tire la liste vers le bas
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshMe) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [[Classe sharedCLassManager] loadUsersList];
    [self.tableView reloadData];
    
}


- (void)refreshMe{
    [[Classe sharedCLassManager] loadUsersList];
    [self.tableView reloadData];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"maCellule" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", personne.name, personne.firstName];
    
    cell.detailTextLabel.text = personne.getClass;
    
    NSString *documentsDirectory =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@", personne.imageName]]];
    cell.imageView.image = [UIImage imageWithContentsOfFile:filePath];
    
   
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"]){
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        detailVC.personne = [[Classe sharedCLassManager].listOfUsers objectAtIndex:ip.row];
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
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        ModifyViewController * mVC = [[ModifyViewController alloc] initWithIndexPath:indexPath];
        [self performSegueWithIdentifier:@"modifySegue" sender:self];
        
    }];
    
    editAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [[Classe sharedCLassManager] removeUserAtIndex:indexPath.row];
        
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
