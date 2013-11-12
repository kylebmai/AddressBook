//
//  MMAppDelegate.h
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSManagedObjectContext *)managedObjectContext;

@end
