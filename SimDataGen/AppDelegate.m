//
//  AppDelegate.m
//  SimDataGen
//
//  Created by 宋炬峰 on 2017/4/5.
//  Copyright © 2017年 宋炬峰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end
// 美术馆
//static CGFloat baseX = 116.4026;
//static CGFloat baseY = 39.9315;
// 亮马桥
static CGFloat baseX = 116.4680;
static CGFloat baseY = 39.9484;
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    NSString* filePath = @"/Users/songjufeng/Desktop/AnnoData2";
    //NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    NSDictionary* dic = [self dicForData];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&err];
    BOOL flag = [[NSFileManager defaultManager] createFileAtPath:filePath contents:jsonData attributes:nil];
    NSLog(@"log flag = %d", flag);
}

-(NSDictionary*)dicForData{
    NSArray* arr = [self arrForNumberOfPoint:400];
    NSDictionary* dic = @{
        @"code": @0,
        @"biketype": @"0",
        @"object": arr,
        };
    return dic;
}

-(NSArray*)arrForNumberOfPoint:(NSInteger)n{
    NSInteger rowNum = sqrt(n);
    NSInteger colNum = rowNum;
    NSMutableArray* arr = [NSMutableArray array];
    for (int i = 1; i <= colNum; i++) {
        NSMutableArray* subarr = [NSMutableArray array];
        for (int j = 1; j <= rowNum; j++) {
            NSInteger rand1 = [self getRandomNumber:-5 to:5];
            NSInteger rand2 = [self getRandomNumber:-5 to:5];
            CGPoint p = CGPointMake(j * 0.00015*rand1, i * 0.00015*rand2);
            NSDictionary* one = [self dicForSinglePoint:p];
            [subarr addObject:one];
        }
        [arr addObjectsFromArray:subarr];
    }
    return arr;
}


-(NSDictionary*)dicForSinglePoint:(CGPoint)p{
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:@{
                                 @"distX": @116.4680,
                                 @"distY": @39.94844,
                                 @"distId": @"0106999996",
                                 @"distance": @"2",
                                 @"bikeIds": @"0106999996#",
                                 @"biketype": @1,
                                 @"distNum": @1,
                                 @"type": @0
                                 }];
    
    dic[@"distX"] = [NSNumber numberWithDouble:baseX + p.x];
    dic[@"distY"] = [NSNumber numberWithDouble:baseY + p.y];
    
    return dic;
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to-from + 1)));
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
