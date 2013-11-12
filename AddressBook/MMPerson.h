//
//  MMPerson.h
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMPersonDelegate.h"

@interface MMPerson : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *photoURL;

@property (strong, nonatomic) id <MMPersonDelegate> delegate;


- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary*)dictionary;




@end
