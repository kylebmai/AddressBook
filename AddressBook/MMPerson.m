//
//  MMPerson.m
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMPerson.h"

@implementation MMPerson

@synthesize firstName;
@synthesize lastName;
@synthesize emailAddress;
@synthesize phoneNumber;
@synthesize photoURL;
@synthesize delegate;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self)
    {
        firstName = dictionary[@"firstName"];
        lastName = dictionary[@"lastName"];
        emailAddress = dictionary[@"emailAddress"];
        phoneNumber = dictionary[@"phoneNumber"];
        photoURL = dictionary[@"photoURL"];
    }
    
    return self;
}


- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary[@"firstName"] = firstName;
    dictionary[@"lastName"] = lastName;
    dictionary[@"emailAddress"] = emailAddress;
    dictionary[@"phoneNumber"] = phoneNumber;
    dictionary[@"photoURL"] = photoURL;
    
    return dictionary;
}

@end
