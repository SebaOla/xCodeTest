//
//  HAPSAError.h
//  com.palermo.mobile
//
//  Created by Sebastian  on 02/10/14.
//  Copyright (c) 2014 hapsa. All rights reserved.
//

#import "JSONModel.h"

@interface HAPSAError : JSONModel
@property (assign, nonatomic) NSString<Optional> *message;
@property (assign, nonatomic) NSString *status;
@property (assign, nonatomic) NSString<Optional> *code;
@end
