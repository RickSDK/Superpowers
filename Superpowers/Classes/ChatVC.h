//
//  ChatVC.h
//  Superpowers
//
//  Created by Rick Medved on 6/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatVC : UIViewController {

	IBOutlet UIWebView *webView;
}

@property (nonatomic, strong) UIWebView *webView;

@end
