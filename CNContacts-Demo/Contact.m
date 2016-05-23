//
//  Contact.m
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (instancetype)init
{
    self = [super init];
    if (self) {
        _phones = [NSMutableArray new];
    }
    return self;
}
@end
