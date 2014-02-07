//
//  TTPatient.h
//  Delegate
//
//  Created by sergey on 2/1/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TTProblemHead,
    TTProblemLeg,
    TTProblemAbdomen
} TTProblem;

@protocol TTPatientDelegate;

@interface TTPatient : NSObject

@property (assign,nonatomic) CGFloat temperature;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) TTProblem problemPlace;
@property (assign,nonatomic) BOOL satisfied;

- (id)initPatientWithName:(NSString *)name patientTemperature:(CGFloat)temperature problemPlace:(TTProblem)problem;
- (id)initPatientWithName:(NSString *)name patientTemperature:(CGFloat)temperature problemPlace:(TTProblem)problem patientBlock:(void (^)(TTPatient *))patientBlock;
- (void)patientBad:(void (^)(TTPatient *))patientBlock;
- (void)takePill;
- (void)makeInjection;
- (void)pretender;
- (void)giveIceScream;
- (void)giveWrongPill;
- (void)giveNothing;
- (void)takeRoentgen;

@end