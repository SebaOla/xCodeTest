//
//  User.m
//  com.palermo.mobile
//
//  Created by Sebastian  on 02/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "HAPSAUser.h"

@implementation HAPSAUser

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"Token": @"token",
                                 @"DNI": @"dni",
                                 @"Phone": @"phone",
                                 @"Name": @"firstName",
                                 @"LastName": @"lastName",
                                 @"PlayerID": @"playerId",
                                 @"Mail": @"mail",
                                 @"Ranking": @"ranking",
                                 @"Error": @"error"
                                 }];
}

@end
