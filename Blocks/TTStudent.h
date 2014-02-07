//
//  TTStudent.h
//  Blocks
//
//  Created by sergey on 2/7/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTStudent : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *secondName;

- (id)initWithName:(NSString *)name secondName:(NSString *)secondname;

@end
