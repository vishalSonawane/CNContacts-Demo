//
//  ContactsCell.h
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactImageView;
@property (weak, nonatomic) IBOutlet UILabel *lblContactFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblContactLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblContactPhoneNumbers;
@end
