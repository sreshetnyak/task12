//
//  TTViewController.m
//  Blocks
//
//  Created by sergey on 2/7/14.
//  Copyright (c) 2014 sergey. All rights reserved.
//

#import "TTViewController.h"
#import "TTStudent.h"
#import "TTPatient.h"


typedef NSString * (^TestBlockParam)(NSString * str);
typedef  void (^PatientBlock)(TTPatient * patient);

#define MIN_TEMP 35.f
#define MAX_TEMP 42.f

@interface TTViewController ()

@property (strong,nonatomic) NSMutableArray *newarrayWithPatient;

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
#pragma mark - Level Pupil
    
//    Ученик. Фактически это повторить первую половину.
//    
//    1. В апп делегате создайте блок с без возвращаемой переменной и без параметров и вызовите его.
//    2. Создайте блоки с параметрами и передайте туда строку, которую выведите на экран в последствии.
//    3. Если вы не определили тип данных для ваших блоков, то сделайте это сейчас и используйте их
//    4. Создайте метод который принимает блок и вызывает его и вызовите этот метод.
    
    void (^testBlock) (void) = ^{
        NSLog(@"my first test block");
    };
    
    testBlock();
    
    TestBlockParam testblockParam = ^(NSString * str){
        
        NSLog(@"my first test block with parameters: %@",str);
        
        return str;
        
    };
    
    testblockParam(@"test block param");
    
    
    void (^testBlockWithBlock)(TestBlockParam) = ^(TestBlockParam test) {
    
        NSLog(@"my block in block %@",test(@"my super block"));
    };
    
    testBlockWithBlock(testblockParam);
    
    
    [self testBlockTypeMethod:^NSString *(NSString *str) {
        NSLog(@"super super block: %@",str);
        
        return str;
    }];
    
    [self testBlockTypeMethod:testblockParam];
    
#pragma mark - Level Student
    
//    Студент.
//    5. Создайте класс студент с проперти имя и фамилия.
//    6. Создайте в аппделегате 10 разных студентов, пусть у парочки будут одинаковые фамилии.
//    7. Поместите всех в массив.
//    8. Используя соответствующий метод сортировки массива (с блоком) отсортируйте массив студентов сначала по фамилии, а если они одинаковы то по имени.
    
    TTStudent *student1 = [[TTStudent alloc]initWithName:@"Aleksandr" secondName:@"Gordiman"];
    TTStudent *student2 = [[TTStudent alloc]initWithName:@"Viktor" secondName:@"Gordiman"];
    TTStudent *student3 = [[TTStudent alloc]initWithName:@"Sergey" secondName:@"Reshetnyak"];
    TTStudent *student4 = [[TTStudent alloc]initWithName:@"Evgeniy" secondName:@"Reshetnyak"];
    TTStudent *student5 = [[TTStudent alloc]initWithName:@"Vladimer" secondName:@"Egerev"];
    TTStudent *student6 = [[TTStudent alloc]initWithName:@"Georgiy" secondName:@"Koltsov"];
    TTStudent *student7 = [[TTStudent alloc]initWithName:@"Viktor" secondName:@"Krimskiy"];
    TTStudent *student8 = [[TTStudent alloc]initWithName:@"Andrey" secondName:@"Gigalko"];
    TTStudent *student9 = [[TTStudent alloc]initWithName:@"Andrey" secondName:@"Shumik"];
    TTStudent *student10 = [[TTStudent alloc]initWithName:@"Aleksey" secondName:@"Shumik"];
    
    NSMutableArray *studentArray = [NSMutableArray arrayWithObjects:student1,student2,student3,student4,student5,student6,student7,student8,student9,student10, nil];
    
    [studentArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([[obj1 secondName] isEqualToString:[obj2 secondName]]) {
            return [[obj1 name]compare:[obj2 name]];
        } else {
            return [[obj1 secondName]compare:[obj2 secondName]];
        }
        
    }];
    
    
    for (TTStudent *obj in studentArray) {
        NSLog(@"%@ %@", obj.name ,obj.secondName);
    }
    
#pragma mark - Level Master
//    Мастер.
//    9. Задание из видео. Из урока о делегатах. У пациентов удалите протокол делегат и соответствующее проперти.
//    10. Добавьте метод принимающий блок когда им станет плохо.
//    11. Блок должен передавать указатель на самого студента ну и на те параметры, которые были в задании по делегатам.
//    12. Теперь когда пациентам поплохеет, они должны вызывать блок, а в блоке нужно принимать решения что делать (доктор не нужен делайте все в апп делегате)
    
    NSMutableArray *arrayWithPatient = [[NSMutableArray alloc]init];
    NSInteger patientCount = 10;
    
    for (int i = 0; i < patientCount; i++) {
        TTPatient *patients = [[TTPatient alloc]initPatientWithName:[NSString stringWithFormat:@"patient%d",i]
                                                 patientTemperature:[self randFloatMin:MIN_TEMP andMax:MAX_TEMP]
                                                       problemPlace:(TTProblem)arc4random_uniform(3)];
        
        [arrayWithPatient addObject:patients];
    }
    
    PatientBlock patient = ^ (TTPatient * patient) {
        
        NSLog(@"name = %@ temperature = %f and problem place %d",patient.name , patient.temperature,patient.problemPlace);
        
        if ((patient.temperature < 35.9f) || (patient.temperature > 37.f && patient.temperature < 38.f)) {
            [patient takePill];
    
        } else if (patient.temperature > 38.f ) {
            [patient makeInjection];
    
        } else if (patient.problemPlace == TTProblemLeg) {
            [patient takeRoentgen];
    
        } else if (patient.problemPlace == TTProblemHead) {
            [patient takePill];
    
        } else if (patient.problemPlace == TTProblemAbdomen) {
            [patient takePill];
            
        } else {
            [patient pretender];
            
        }
    };
    
    for (TTPatient *obj in arrayWithPatient) {
        [obj patientBad:patient];
    }

#pragma mark - Level Superman
//    Супермен
//    13. Познайте истинное предназначение блоков :) Пусть пациентам становится плохо не тогда когда вы их вызываете в цикле(это убрать), а через случайное время 5-15 секунд после создания (используйте специальный метод из урока по селекторам в ините пациента).
//    14. не забудьте массив пациентов сделать проперти аппделегата, а то все помрут по выходе из функции так и не дождавшись :)
    
    NSLog(@"_______________________________________________________________________________________________________________");
    
    NSMutableArray *newarrayWithPatient = [[NSMutableArray alloc]init];
    NSInteger newpatientCount = 10;
    
    for (int i = 0; i < newpatientCount; i++) {
        TTPatient *patients = [[TTPatient alloc]initPatientWithName:[NSString stringWithFormat:@"patient%d",i]
                                                patientTemperature:[self randFloatMin:MIN_TEMP andMax:MAX_TEMP]
                                                      problemPlace:(TTProblem)arc4random_uniform(3) patientBlock:patient];
        
        [newarrayWithPatient addObject:patients];
    }
    
}

- (float)randFloatMin:(float)low andMax:(float)high {
    CGFloat diff = high - low;
    CGFloat new = (((CGFloat) rand() / RAND_MAX) * diff) + low;
    return round(10 * new) / 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
