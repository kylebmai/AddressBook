//
//  MMViewController.m
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMViewController.h"
#import "MMPerson.h"
#import "MMShowViewController.h"
#import "MMAddViewController.h"
#import "MMAppDelegate.h"
#import "AddressBook.h"

@interface MMViewController () <NSFetchedResultsControllerDelegate>
{
    NSFileManager *fileManager;
    NSURL *documentsDirectory;
    UIImage *photoContact;
    NSManagedObjectContext *moc;
    NSFetchedResultsController *fetchResultController;
}

@end

@implementation MMViewController
@synthesize peopleArray;
@synthesize selectedIndex;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        fileManager = [NSFileManager defaultManager];
        documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSLog(@"%@", documentsDirectory);
        
        peopleArray = [[NSMutableArray alloc] init];
    }

    return self;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [moc deleteObject:[[fetchResultController fetchedObjects] objectAtIndex:indexPath.row]];
        [moc save:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [peopleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];

    AddressBook *entry = [peopleArray objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", entry.firstName, entry.lastName];
    cell.detailTextLabel.text = entry.emailAddress;
    
    NSURL *photoURL = [NSURL URLWithString:entry.photoURL];
    NSData *photoContactImageData = [NSData dataWithContentsOfURL:photoURL];
    cell.imageView.image = [UIImage imageWithData:photoContactImageData];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"DetailView" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailView"]) {
        MMShowViewController *showVC = segue.destinationViewController;
        NSIndexPath *indexPath = [[_tableViewOutlet indexPathsForSelectedRows] objectAtIndex:0];
        showVC.person = peopleArray[indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"segueVCtoAddVC"]) {
    }
}

//- (void)addPerson:(NSDictionary *)dictionary
//{
//    AddressBook *entry = [NSEntityDescription insertNewObjectForEntityForName:@"AddressBook" inManagedObjectContext:moc];
//    entry.firstName = [dictionary objectForKey:@"firstName"];
//    entry.lastName = [dictionary objectForKey:@"lastName"];
//    entry.emailAddress = [dictionary objectForKey:@"emailAddress"];
//    entry.phoneNumber = [dictionary objectForKey:@"phoneNumber"];
//    entry.photoURL = [dictionary objectForKey:@"photoURL"];
//    
//    //Must always save the MOC
//    NSError *dataError;
//    if (![moc save:&dataError])
//    {
//        NSLog(@"Data Save Error: %@", dataError);
//    }
//    
//    [self fetchAddressBook];
//    
//}

- (void)fetchAddressBook
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AddressBook" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    //[fetchRequest setPredicate:nil];
    
    NSError *error = nil;
    //NSArray *fetchedObjects = [moc executeFetchRequest:fetchRequest error:&error];
    
    fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                managedObjectContext:moc
                                                                  sectionNameKeyPath:nil
                                                                           cacheName:nil];
    
    [fetchResultController performFetch:&error];
    fetchResultController.delegate = self;
    peopleArray = [fetchResultController fetchedObjects].mutableCopy;
    
    //[_tableViewOutlet reloadData];
}

//- (void)fetchAddressBook
//{
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AddressBook" inManagedObjectContext:moc];
//    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
//    
//    NSError *error;
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    
//    fetchRequest.entity = entityDescription;
//    fetchRequest.sortDescriptors = sortDescriptors;
//    
//    fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
//    [fetchResultController performFetch:&error];
//    fetchResultController.delegate = self;
//    
//    peopleArray = [fetchResultController fetchedObjects].mutableCopy;
//    
//    if (error)
//    {
//        NSLog(@"Fetch Error: %@", error);
//    }
//}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    peopleArray = [fetchResultController fetchedObjects].mutableCopy;
    [_tableViewOutlet reloadData];
}

- (void)viewDidLoad
{
    moc = [(MMAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    photoContact = [[UIImage alloc] init];
    
    [super viewDidLoad];

    [self fetchAddressBook];

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    if (![searchString isEqualToString:@""])
    {
        if (self.searchDisplayController.searchBar.selectedScopeButtonIndex == 0)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName CONTAINS [c] %@ OR lastName CONTAINS [c] %@", searchString, searchString];
            peopleArray = [[fetchResultController fetchedObjects] filteredArrayUsingPredicate:predicate].mutableCopy;
        }
        else
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"emailAddress CONTAINS [c] %@", searchString];
            peopleArray = [[fetchResultController fetchedObjects] filteredArrayUsingPredicate:predicate].mutableCopy;
        }
    }
    else
    {
        [fetchResultController fetchedObjects];
    }
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

-(IBAction)showPhotoLibraryAction:(id)sender
{
    UIImagePickerController *imagePickController = [[UIImagePickerController alloc]init];
    imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickController.delegate = self;
    [self presentViewController:imagePickController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    photoContact = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
