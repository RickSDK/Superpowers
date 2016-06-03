//
//  ChatVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateVC.h"


@interface ChatVC : TemplateVC {
}

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UILabel *usersLabel;
@property (nonatomic, strong) IBOutlet UITextField *messagetextField;
@property (nonatomic, strong) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) NSString *messages;
@property (nonatomic, strong) NSString *chat;

- (IBAction) submitButtonClicked: (id) sender;


@end
