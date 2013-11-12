//
//  MMAddViewController.h
//  AddressBook
//
//  Created by Kyle Mai on 10/14/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMAddViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;


@property (retain, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (retain, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (retain, nonatomic) IBOutlet UITextField *streetAddressTextField;
@property (retain, nonatomic) IBOutlet UITextField *cityAndZipTextField;
@property (weak, nonatomic) IBOutlet UITextField *workStreetAddress;
@property (weak, nonatomic) IBOutlet UITextField *workCityAndZip;

@property (retain, nonatomic) IBOutlet UIPickerView *pickerAddressType;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollViewBackground;

- (IBAction)actionSave:(id)sender;
- (IBAction)actionSelectPhoto:(id)sender;


@end
