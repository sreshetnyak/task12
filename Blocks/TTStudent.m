//
//  TTStudent.m
//  Blocks
//
//  Created by sergey on 2/7/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTStudent.h"

@implementation TTStudent

- (id)initWithName:(NSString *)name secondName:(NSString *)secondname {
    if (self = [super init]) {
        _name = name;
        _secondName = secondname;
    }
    return self;
}

@end
