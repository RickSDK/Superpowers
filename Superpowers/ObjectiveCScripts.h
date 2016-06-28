//
//  ObjectiveCScripts.h
//  iBabyBook
//
//  Created by Rick Medved on 11/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+FontAwesome.h"
#import "UIFont+FontAwesome.h"

#define kPRODMode 1


@interface ObjectiveCScripts : NSObject {

}

+(int)getProductionMode;
+(NSString *)getProjectVersion;
+(NSString *)getProjectDisplayVersion;
+(float)screenWidth;
+(float)screenHeight;
+(NSArray *)sortArray:(NSMutableArray *)list ascendingFlg:(BOOL)ascendingFlg;
+(NSString *)escapeQuotes:(NSString *)string ;
+(NSDate *)getFirstDayOfMonth:(NSDate *)thisDay;
+(NSString *)convertNumberToMoneyString:(int)money;
+(NSString *)convertIntToMoneyString:(int)money;
+(void)setUserDefaultValue:(NSString *)value forKey:(NSString *)key;
+(NSString *)getUserDefaultValue:(NSString *)key;
+(void)showAlertPopup:(NSString *)title:(NSString *)message;
+(void)showAlertPopupWithDelegate:(NSString *)title:(NSString *)message:(id)delegate;
+(void)showConfirmationPopup:(NSString *)title:(NSString *)message:(id)delegate;
+(void)showAcceptDeclinePopup:(NSString *)title message:(NSString *)message delegate:(id)delegate;
+(NSArray *)getContentsOfFlatFile:(NSString *)filename;
//+(BOOL)limitTextViewLength:(UITextView *)textViewLocal:(NSString *)currentText:(NSString *)string:(int)limit:(UIBarButtonItem *)saveButton:(BOOL)resignOnReturn;
//+(BOOL)limitTextFieldLength:(UITextField *)textViewLocal:(NSString *)currentText:(NSString *)string:(int)limit:(UIBarButtonItem *)saveButton:(BOOL)resignOnReturn;
+(NSString *)formatForDataBase:(NSString *)str;
+(NSString *)getDayTimeFromDate:(NSDate *)localDate;
+(int)getMoneyValueFromText:(NSString *)money;
+(UIImage *)imageWithImage:(UIImage *)image newSize:(CGSize)newSize;
+(NSString *)convertImgToBase65String:(NSData *)data height:(int)height;
+(void)showActionSheet:(id)delegate view:(UIView *)view title:(NSString *)title buttons:(NSArray *)buttons;
+(NSArray *)getPiecesArray;
+(NSString *)getNameOfPiece:(int)number;
+(NSString *)getTypeOfPiece:(int)number;
+(int)getPriceOfPiece:(int)number;
+(NSString *)getPurchaseString;
+(NSArray *)getNations;
+(int)getNationId:(NSString *)nationName;
+(NSString *)getNationNameFromId:(int)terrId;
+(UIImage *)getImageForPiece:(int)piece;
+(NSString *)getSuperpowerNameFromId:(int)nation;
+(void)addColorToButton:(UIButton *)button color:(UIColor *)color;
+ (UIImage *) imageFromColor:(UIColor *)color;
+(UIBarButtonItem *)navigationButtonWithTitle:(NSString *)title selector:(SEL)selector target:(id)target;
+(UIColor *)colofForNation:(int)nation;


@end
