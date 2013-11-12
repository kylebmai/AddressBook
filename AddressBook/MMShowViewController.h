//
//  MMShowViewController.h
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MMPerson.h"
#import "MMShowViewController.h"
#import "AddressBook.h"

@interface MMShowViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleNameOutlet;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *textFieldStreetAddress;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCityAndZip;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerAddressType;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollViewBackground;

@property (strong, nonatomic) AddressBook *person;


- (IBAction)actionSave:(id)sender;
- (IBAction)actionMap:(id)sender;

@end
