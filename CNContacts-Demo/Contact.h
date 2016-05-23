//
//  Contact.h
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Contact : NSObject

//firstName
//lastName
//image

@property(nonatomic,strong)NSString *firstName;
@property(nonatomic,strong)NSString *lastName;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSMutableArray *phones;
@end
