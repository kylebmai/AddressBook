//
//  MMAddViewController.m
//  AddressBook
//
//  Created by Kyle Mai on 10/14/13.
//  Copyright (c) 2013 Kyle Mai. All rights reserved.
//

#import "MMAddViewController.h"
#import "MMAppDelegate.h"
#import "AddressBook.h"
#import "Location.h"

@interface MMAddViewController ()
{
    NSFileManager *fileManager;
    NSURL *documentsDirectory;
    NSManagedObjectContext *moc;
    NSArray *pickerArray;
}
@end

@implementation MMAddViewController
@synthesize firstNameTextField,
            lastNameTextField,
            emailAddressTextField,
            phoneNumberTextField,
            streetAddressTextField,
            cityAndZipTextField,
            pickerAddressType,
            scrollViewBackground,
            workStreetAddress,
            workCityAndZip;


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
    
    scrollViewBackground.contentSize = CGSizeMake(scrollViewBackground.frame.size.width, 700);
    //scrollViewBackground.scrollEnabled = YES;
    
    pickerArray = @[@"Home", @"Work"];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    fileManager = [NSFileManager defaultManager];
    documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
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

- (IBAction)actionSave:(id)sender
{
    AddressBook *person = [NSEntityDescription insertNewObjectForEntityForName:@"AddressBook"
                                                        inManagedObjectContext:moc];
    
    NSString *photoFileName = [NSString stringWithFormat:@"%@%@.png", documentsDirectory, emailAddressTextField.text];
    [UIImagePNGRepresentation(_contactImageView.image) writeToURL:[NSURL URLWithString:photoFileName] atomically:YES];
        
    person.firstName = firstNameTextField.text;
    person.lastName = lastNameTextField.text;
    person.emailAddress = emailAddressTextField.text;
    person.phoneNumber = phoneNumberTextField.text;
    person.photoURL = photoFileName;
    
    Location *homeAddress = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc];
    homeAddress.streetAddress = streetAddressTextField.text;
    homeAddress.cityAndZip = cityAndZipTextField.text;
    homeAddress.typeAddress = @"Home";
    [person addLocationObject:homeAddress];
    
    Location *workAddress = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc];
    workAddress.streetAddress = workStreetAddress.text;
    workAddress.cityAndZip = workCityAndZip.text;
    workAddress.typeAddress = @"Work";
    [person addLocationObject:workAddress];
    
    [moc save:nil];
    
    NSLog(@"Set: %@", person.location);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissKeyboard
{
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [emailAddressTextField resignFirstResponder];
    [phoneNumberTextField resignFirstResponder];
    [streetAddressTextField resignFirstResponder];
    [cityAndZipTextField resignFirstResponder];
    [workStreetAddress resignFirstResponder];
    [workCityAndZip resignFirstResponder];
    scrollViewBackground.frame = CGRectMake(0, 0, 320, 568);
}

- (void)addingToolbarToKeyboardOfTextField:(UITextField *)textField
{
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard)];
    NSMutableArray *toolBarItems = [[NSMutableArray alloc] initWithObjects:spaceButton, doneButton, nil];
    [toolBar setItems:toolBarItems.mutableCopy];
    textField.inputAccessoryView = toolBar;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    scrollViewBackground.frame = CGRectMake(0, 0, 320, 304);
    [scrollViewBackground scrollRectToVisible:textField.frame animated:YES];
    //[self expandScrollView];
    [self addingToolbarToKeyboardOfTextField:textField];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
        {
            [lastNameTextField becomeFirstResponder];
            break;
        }
        case 2:
        {
            [emailAddressTextField becomeFirstResponder];
            break;
        }
        case 3:
        {
            [phoneNumberTextField becomeFirstResponder];
            break;
        }
        case 4:
        {
            [streetAddressTextField becomeFirstResponder];
            break;
        }
        case 5:
        {
            [cityAndZipTextField becomeFirstResponder];
            break;
        }
        case 6:
        {
            scrollViewBackground.frame = CGRectMake(0, 0, 320, 568);
            //[self shrinkScrollView];
            [textField resignFirstResponder];
            break;
        }
    }
    
    return YES;
}

- (void)expandScrollView
{
    scrollViewBackground.contentSize = CGSizeMake(self.view.frame.size.width, 1004);
}

- (void)shrinkScrollView
{
    scrollViewBackground.contentSize = CGSizeMake(self.view.frame.size.width, 700);
}

- (IBAction)actionSelectPhoto:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageFromLib = [info objectForKey:UIImagePickerControllerOriginalImage];
    _contactImageView.image = imageFromLib;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
