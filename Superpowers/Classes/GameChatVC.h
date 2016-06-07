//
//  GameChatVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/6/16.
//
//

#import "TemplateVC.h"

@interface GameChatVC : TemplateVC

@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) IBOutlet UILabel *usersLabel;
@property (nonatomic, strong) IBOutlet UITextField *messagetextField;
@property (nonatomic, strong) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) IBOutlet UIButton *allButton;
@property (nonatomic, strong) IBOutlet UIButton *playerButton;
@property (nonatomic, strong) IBOutlet UIImageView *flagImageView;
@property (nonatomic, strong) NSString *messages;
@property (nonatomic, strong) NSString *chat;
@property (nonatomic) int allButtonNum;
@property (nonatomic) int playerButtonNum;

- (IBAction) submitButtonClicked: (id) sender;
- (IBAction) allButtonClicked: (id) sender;
- (IBAction) playerButtonClicked: (id) sender;

@end
