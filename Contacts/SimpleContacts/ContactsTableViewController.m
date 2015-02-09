//
//  ContactsTableViewController.m
//  SimpleContacts
//
//  Created by Leen on 7/24/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "ContactsTableViewController.h"
#import "CoreDataStack.h"
#import "ContactEntity.h"
#import "ContactInfoViewController.h"

@interface ContactsTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation ContactsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.fetchedResultsController performFetch:nil];

}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.fetchedResultsController.sections.count;
}



-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];

    return [sectionInfo indexTitle];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    // Return the number of rows in the section.
    return  [sectionInfo numberOfObjects];
    
}

//Enable Delete
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//Delete the contact
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get the selected contact
    ContactEntity *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    //Delete internally
    [[coreDataStack managedObjectContext] deleteObject:contact];
    
    [coreDataStack saveContext];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ContactEntity *contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    cell.imageView.image = [UIImage imageWithData:contact.image];
    
    
    return cell;
}




#pragma mark - Helper Methods


-(NSFetchRequest *) entryListFetchRequest
{
    //Fetch our contacts
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ContactEntity"];
    
    //Sort descendingly based on firstName
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"nameFirstLetter" ascending:YES]];
    
    return fetchRequest;
}

-(NSFetchedResultsController *) fetchedResultsController
{
    if(_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    else
    {
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        
        NSFetchRequest *fetchRequest = [self entryListFetchRequest];
        
        _fetchedResultsController =  [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:fetchRequest
                                      managedObjectContext:coreDataStack.managedObjectContext
                                      sectionNameKeyPath:@"nameFirstLetter"
                                      cacheName:nil];
        
        
        _fetchedResultsController.delegate = self;
        
        return _fetchedResultsController;
    }
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqual:@"Edit"])
    {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        UINavigationController *navigaitonController = [segue destinationViewController];
        
        ContactInfoViewController *contactInfoViewcontroller = (ContactInfoViewController *)navigaitonController.topViewController;
        
        contactInfoViewcontroller.contact = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
}



@end
