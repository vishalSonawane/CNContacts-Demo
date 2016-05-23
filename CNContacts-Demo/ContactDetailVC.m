//
//  ContactDetailVC.m
//  CNContacts-Demo
//
//  Created by vishalsonawane on 20/05/16.
//  Copyright © 2016 vishalsonawane. All rights reserved.
//

#import "ContactDetailVC.h"

@interface ContactDetailVC ()

@end

@implementation ContactDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblContactInfo.text = _contatInfo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
