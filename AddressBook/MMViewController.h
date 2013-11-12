//
//  MMViewController.h
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAddViewController.h"

@interface MMViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *peopleArray;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@property int selectedIndex;


-(IBAction)showPhotoLibraryAction:(id)sender;

@end
