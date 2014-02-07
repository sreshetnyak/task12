//
//  TTPatient.m
//  Delegate
//
//  Created by sergey on 2/1/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTPatient.h"

@implementation TTPatient

- (id)initPatientWithName:(NSString *)name patientTemperature:(CGFloat)temperature problemPlace:(TTProblem)problem {
    if (self = [super init]) {
        _name = name;
        _temperature = temperature;
        _problemPlace = problem;
    }
    return self;
}

- (id)initPatientWithName:(NSString *)name patientTemperature:(CGFloat)temperature problemPlace:(TTProblem)problem patientBlock:(void (^)(TTPatient *))patientBlock {
    
    if (self = [super init]) {
        _name = name;
        _temperature = temperature;
        _problemPlace = problem;
        CGFloat delay = arc4random()%11;
        NSLog(@"%f",delay);
        [self performSelector:@selector(patientBlockMethod:) withObject:patientBlock afterDelay:delay];
    }
    return self;
}

- (void)patientBlockMethod:(void (^)(TTPatient *))patient {
    patient(self);
    
}

- (void)patientBad:(void (^)(TTPatient *))patientBlock {
    patientBlock(self);
    
}

- (void)makeInjection {
    NSLog(@"Doctor say make injection %@",self.name);
}

- (void)takePill {
    NSLog(@"Doctor say take pill %@",self.name);
}

- (void)pretender {
    NSLog(@"Doctor say pretender exit %@",self.name);
}

- (void)giveIceScream {
    NSLog(@"Doctor giving IceScream %@",self.name);
}

- (void)giveWrongPill {
    NSLog(@"Doctor giving wrong pill %@",self.name);
}

- (void)giveNothing {
    NSLog(@"Doctor giving  nothing %@",self.name);
}

- (void)takeRoentgen {
    NSLog(@"Doctor say take roentgen %@",self.name);
}

@end
