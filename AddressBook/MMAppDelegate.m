//
//  MMAppDelegate.m
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMAppDelegate.h"
#import <CoreData/CoreData.h>

@implementation MMAppDelegate
{
    NSManagedObjectContext *moc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setupCoreData];
    
    return YES;
}

- (NSManagedObjectContext *)managedObjectContext
{
    return moc;
}
							
- (void)setupCoreData
{
    //Needs document directory folder
    NSURL *documentsDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    //Needs URL for Core Data file Model.momd (Model.xcdatamodeld)
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //Needs URL for output SQLite
    NSURL *sqliteURL = [documentsDirectoryURL URLByAppendingPathComponent:@"Model.sqlite"];
    
    //Needs instance of NSManagedObjectModel to handle the model file
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    //NSManagedObjectModel go in hands with NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    //If everything is correct, set persistent store coordinator to NSManagedObjectContext (moc)
    if ([persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:nil])
    {
        moc = [[NSManagedObjectContext alloc] init];
        [moc setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
}


@end
