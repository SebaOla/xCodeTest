//
//  HAPSAError.m
//  com.palermo.mobile
//
//  Created by Sebastian  on 02/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "HAPSAError.h"

@implementation HAPSAError

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc]
            initWithDictionary:@{
                                 @"Mensaje": @"message",
                                 @"Status": @"status",
                                 @"Codigo": @"code"
                                 }];
}
@end
