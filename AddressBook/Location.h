//
//  Location.h
//  AddressBookCoreData
//
//  Created by Kyle Mai on 10/16/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AddressBook;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * streetAddress;
@property (nonatomic, retain) NSString * cityAndZip;
@property (nonatomic, retain) NSString * typeAddress;
@property (nonatomic, retain) AddressBook *addressBook;

@end
