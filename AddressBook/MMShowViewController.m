//
//  MMShowViewController.m
//  AddressBook
//
//  Created by Kyle Mai on 9/30/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMShowViewController.h"
#import "MMAppDelegate.h"
#import "Location.h"

@class Location;

@interface MMShowViewController ()
{
    NSManagedObjectContext *moc;
    NSArray *pickerArray;
    Location *address0;
    Location *address1;
}

@end

@implementation MMShowViewController
@synthesize person;
@synthesize titleNameOutlet;
@synthesize textFieldEmailAddress;
@synthesize textFieldFirstName;
@synthesize textFieldLastName;
@synthesize textFieldPhoneNumber;
@synthesize textFieldStreetAddress;
@synthesize textFieldCityAndZip;
@synthesize pickerAddressType;
@synthesize scrollViewBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    moc = [(MMAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    pickerArray = @[@"Home", @"Work"];
    scrollViewBackground.contentSize = CGSizeMake(scrollViewBackground.frame.size.width, 800);
    
    address0 = (Location *)[[person.location allObjects] objectAtIndex:0];
    address1 = (Location *)[[person.location allObjects] objectAtIndex:1];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@ %@", person.firstName, person.lastName];
    
    titleNameOutlet.text = person.firstName;
    
    textFieldFirstName.text = person.firstName;
    textFieldLastName.text = person.lastName;
    textFieldEmailAddress.text = person.emailAddress;
    textFieldPhoneNumber.text = person.phoneNumber;
    
    [pickerAddressType selectRow:0 inComponent:0 animated:YES];
    NSString *selectedTitle = [[pickerAddressType delegate] pickerView:pickerAddressType titleForRow:[pickerAddressType selectedRowInComponent:0] forComponent:0];
    
    if ([address0.typeAddress isEqualToString:selectedTitle])
    {
        textFieldStreetAddress.text = address0.streetAddress;
        textFieldCityAndZip.text = address0.cityAndZip;
    }
    else
    {
        textFieldStreetAddress.text = address1.streetAddress;
        textFieldCityAndZip.text = address1.cityAndZip;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectedTitle = [[pickerAddressType delegate] pickerView:pickerAddressType titleForRow:row forComponent:0];
    
    if ([selectedTitle isEqualToString:@"Home"])
    {
        if ([address0.typeAddress isEqualToString:selectedTitle]) {
            textFieldStreetAddress.text = address0.streetAddress;
            textFieldCityAndZip.text = address0.cityAndZip;
        }
        else {
            textFieldStreetAddress.text = address1.streetAddress;
            textFieldCityAndZip.text = address1.cityAndZip;
        }
    }
    else
    {
        if ([address0.typeAddress isEqualToString:selectedTitle]) {
            textFieldStreetAddress.text = address0.streetAddress;
            textFieldCityAndZip.text = address0.cityAndZip;
        }
        else {
            textFieldStreetAddress.text = address1.streetAddress;
            textFieldCityAndZip.text = address1.cityAndZip;
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag >= 4)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame = CGRectMake(0, -200, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    if (textField.tag == 3)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame = CGRectMake(0, -100, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    if (textField.tag < 3)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            [textFieldLastName becomeFirstResponder];
            break;
        }
        case 2:
        {
            [textFieldEmailAddress becomeFirstResponder];
            break;
        }
        case 3:
        {
            [textFieldPhoneNumber becomeFirstResponder];
            break;
        }
        case 4:
        {
            [textFieldStreetAddress becomeFirstResponder];
            break;
        }
        case 5:
        {
            [textFieldCityAndZip becomeFirstResponder];
            break;
        }
        case 6:
        {
            [UIView animateWithDuration:0.3f animations:^{
                self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            }];
            
            [textField resignFirstResponder];
            break;
        }
        default:
            break;
    }
    
    return YES;
}

- (IBAction)actionSave:(id)sender
{
    person.firstName = textFieldFirstName.text;
    person.lastName = textFieldLastName.text;
    person.emailAddress = textFieldEmailAddress.text;
    person.phoneNumber = textFieldPhoneNumber.text;
    
    NSString *selectedPicker = [[pickerAddressType delegate] pickerView:pickerAddressType titleForRow:[pickerAddressType selectedRowInComponent:0] forComponent:0];
    
    if ([selectedPicker isEqualToString:@"Home"])
    {
        if ([address0.typeAddress isEqualToString:selectedPicker]) {
            address0.streetAddress = textFieldStreetAddress.text;
            address0.cityAndZip = textFieldCityAndZip.text;
        }
        else {
            address1.streetAddress = textFieldStreetAddress.text;
            address1.cityAndZip = textFieldCityAndZip.text;
        }
    }
    else
    {
        if ([address0.typeAddress isEqualToString:selectedPicker]) {
            address0.streetAddress = textFieldStreetAddress.text;
            address0.cityAndZip = textFieldCityAndZip.text;
        }
        else {
            address1.streetAddress = textFieldStreetAddress.text;
            address1.cityAndZip = textFieldCityAndZip.text;
        }
    }
    
    [moc save:nil];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
    [textFieldFirstName resignFirstResponder];
    [textFieldLastName resignFirstResponder];
    [textFieldEmailAddress resignFirstResponder];
    [textFieldPhoneNumber resignFirstResponder];
    [textFieldStreetAddress resignFirstResponder];
    [textFieldCityAndZip resignFirstResponder];
}

- (IBAction)actionMap:(id)sender
{
    NSLog(@"Map");
    
    //**** Get location by apple URL scheme
    NSString *addressString = [NSString stringWithFormat:@"%@+%@", textFieldStreetAddress.text, textFieldCityAndZip.text];
    NSString *addressStringWithoutSpaces = [addressString stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSString *coordinatesString = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", addressStringWithoutSpaces];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:coordinatesString]];
}


@end
