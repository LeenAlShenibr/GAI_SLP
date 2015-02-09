//
//  ContactInfoViewController.m
//  SimpleContacts
//
//  Created by Leen on 7/24/14.
//  Copyright (c) 2014 Leen AlShenibr. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "ContactEntity.h"
#import "CoreDataStack.h"

@interface ContactInfoViewController () <UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>


//TextFields
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *contactImageButton;

//Actions
- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedDone:(id)sender;


//Other
@property (nonatomic, strong) UIImage *pickedImage;
- (IBAction)pressedContactImageButton:(id)sender;


@end

@implementation ContactInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //If editing contact info
    if(self.contact != nil)
    {
        [self setViewDataFromContactData];
        
        
    }
    
    
    //Round the coreners of our image button
    self.contactImageButton.layer.cornerRadius = CGRectGetWidth(self.contactImageButton.frame)/2.0f;
}


#pragma mark - Helper Methods
-(void) setContactDataFromViewData: (ContactEntity *) contact
{

        NSString *firstName = self.firstNameTextField.text;
        contact.firstName = firstName;
        
        contact.lastName = self.lastNameTextField.text;
        contact.phoneNumber = self.phoneNumberTextField.text;
        contact.address = self.addressTextField.text;
        contact.email = self.emailTextField.text;
        
        unichar firstLetter = [firstName characterAtIndex:0] ;
        contact.nameFirstLetter = [NSString stringWithCharacters:&firstLetter length:1];
        
        NSLog(@"Char is %@", contact.nameFirstLetter);
        
        
        if(self.pickedImage != nil)
            contact.image = UIImageJPEGRepresentation(self.pickedImage, 0.75);

}

-(void) setViewDataFromContactData
{
    self.firstNameTextField.text = self.contact.firstName;
    self.lastNameTextField.text = self.contact.lastName;
    self.phoneNumberTextField.text = self.contact.phoneNumber;
    self.addressTextField.text = self.contact.address;
    self.emailTextField.text = self.contact.email;
    
}


-(void) updateContact
{
    
    //There might be better ways to doing this, but this is just a basic demo
    [self setContactDataFromViewData:self.contact];
    
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [coreDataStack saveContext];
    
    [self dismiss];
    
}

-(void) addContact
{
    if([self.firstNameTextField.text length] > 0)
    {
        //Adding an entry to our database
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        
        
        //Create a new object to save in coreData; must have the same name as the enity in the model.
        //Same as inserting a new row in a database.
        ContactEntity *contact = [NSEntityDescription insertNewObjectForEntityForName:@"ContactEntity" inManagedObjectContext:coreDataStack.managedObjectContext];
        
        [self setContactDataFromViewData:contact];
        
        
        //Save the new object
        [coreDataStack saveContext];
        
        [self dismiss];
    }
    else
    {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Create Contact!!" message:@"A contact must have a first name."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alert show];
    }
}


- (IBAction)pressedCancel:(id)sender
{
    [self dismiss];
}


- (IBAction)pressedDone:(id)sender
{
    
    if (self.contact != nil)
    {
        [self updateContact];
        
    }
    else
    {
        [self addContact];
    }
    
    
}


- (IBAction)pressedContactImageButton:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self promptForSource];
    }
    else
    {
        [self promptForPhotoRoll];
    }
}

-(void) dismiss
{
    NSLog(@"Dismissing View");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Image Picker Methods
-(void)promptForSource
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"PhotoRoll", nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForPhotoRoll];
        }
        else
        {
            [self promptForCamera];
        }
    }
}

-(void)promptForCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)promptForPhotoRoll
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image =  info[UIImagePickerControllerOriginalImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setPickedImage:(UIImage *)pickedImage
{
    _pickedImage = pickedImage;
    if (pickedImage == nil) {
        [self.contactImageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.contactImageButton setImage:pickedImage forState:UIControlStateNormal];
    }
    
}

@end
