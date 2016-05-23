//
//  ContactDetailVC.h
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *lblContactInfo;
@property (strong, nonatomic)NSString *contatInfo;
@end
