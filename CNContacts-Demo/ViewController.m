//
//  ViewController.m
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "Contact.h"
#import "ContactsCell.h"
#import "ContactDetailVC.h"
static NSString *cellidentifier = @"ContactsCell";
@interface ViewController ()<CNContactPickerDelegate,CNContactViewControllerDelegate>
{
    NSMutableArray *contacts;
    CNContactStore *store ;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title = @"CNContact Demo";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ContactsCell class]) bundle:nil] forCellReuseIdentifier:cellidentifier];
    self.tableView.estimatedRowHeight = 147;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   
}
-(void)CheckPermissionForContacts
{
    contacts =  [NSMutableArray new];
    //ios 9+
    store = [[CNContactStore alloc] init];
    CNEntityType entityType = CNEntityTypeContacts;
    // if contacts permission is not given, request for it, else fetch contacts
    if( [CNContactStore authorizationStatusForEntityType:entityType] == CNAuthorizationStatusNotDetermined)
    {
        [store requestAccessForEntityType:entityType completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if(granted){
                [self getAllContacts];
            }
        }];
    }
    else if( [CNContactStore authorizationStatusForEntityType:entityType]== CNAuthorizationStatusAuthorized)
    {
        [self getAllContacts];
    }
    
}
-(void)getAllContacts
{
    //keys with fetching properties
    NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    NSString *containerId = store.defaultContainerIdentifier;
  //to fetch all contacts
    NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:containerId];
    
    //to fetch contacts with matching name
//    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:@"vishal"];
    NSError *error;
    NSArray *cnContacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:keys error:&error];
    if (error) {
        NSLog(@"error fetching contacts %@", error);
    } else {
        for (CNContact *contact in cnContacts) {
            // copy data to my custom Contacts class.
            Contact *newContact = [[Contact alloc] init];
            newContact.firstName = contact.givenName;
            newContact.lastName = contact.familyName;
            UIImage *image = [UIImage imageWithData:contact.imageData];
            newContact.image = image;
            for (CNLabeledValue *label in contact.phoneNumbers) {
                NSString *phone = [label.value stringValue];
                if ([phone length] > 0) {
                    [newContact.phones addObject:phone];
                }
            }
            [contacts addObject:newContact];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self CheckPermissionForContacts];
    [_tableView reloadData];
}
#pragma mark table view methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contacts.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsCell *contactCell = (ContactsCell*)[tableView dequeueReusableCellWithIdentifier:cellidentifier forIndexPath:indexPath];
    Contact *contact = [contacts objectAtIndex:indexPath.row];
    contactCell.lblContactFirstName.text = contact.firstName;
    contactCell.lblContactLastName.text  = contact.lastName;
    //contactCell.lblContactPhoneNumbers.text = contact.phones
    contactCell.contactImageView.image = contact.image;
    return contactCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc]init];
    contactPicker.delegate = self;
    contactPicker.displayedPropertyKeys = @[CNContactPhoneticGivenNameKey,CNContactPreviousFamilyNameKey,CNContactPhoneNumbersKey];
    [self.navigationController presentViewController:contactPicker animated:YES completion:nil];
}
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    CNContact *contact = contactProperty.contact;
    NSString * contactInfo = [NSString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
    [picker dismissViewControllerAnimated:YES completion:^{
        //
        ContactDetailVC *contactDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ContactDetailVC class])];
        contactDetailVC.contatInfo = contactInfo;
        [self.navigationController pushViewController:contactDetailVC animated:YES];
    }];
}

@end
