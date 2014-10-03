//
//  User.h
//  com.palermo.mobile
//
//  Created by Sebastian  on 02/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "HAPSAError.h"

@interface HAPSAUser : JSONModel
@property (assign, nonatomic) NSString *token;
@property (assign, nonatomic) NSString *dni;
@property (assign, nonatomic) NSString<Optional> *phone;
@property (assign, nonatomic) NSString *firstName;
@property (assign, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSString *playerId;
@property (assign, nonatomic) NSString<Optional> *mail;
@property (assign, nonatomic) NSString *ranking;
@property (assign, nonatomic) HAPSAError *error;
@end
