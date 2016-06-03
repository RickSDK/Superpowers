//
//  UserObj.h
//  Superpowers
//
//  Created by Rick Medved on 5/25/16.
//
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic) int userId;
@property (nonatomic) int rank;
@property (nonatomic, strong) NSString *created;
@property (nonatomic, strong) NSString *lastLogin;

+(UserObj *)objectFromLine:(NSString *)line;

@end
