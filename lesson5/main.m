//
//  main.m
//  lesson5
//
//  Created by Юрий Султанов on 30.01.2020.
//  Copyright © 2020 Юрий Султанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Birds.h"
#import "Fauna.h"

typedef enum Operation Operation;


int main(int argc, const char * argv[]) {
    Fauna *fauna = [[Fauna alloc] init];
    
    
    Birds *firstBirdsPack = [[Birds alloc] initWithNumber:@3 andKind:@"Java"];
    
    Birds *seconBirdsPack = [[Birds alloc] initWithNumber:@45 andKind:@"Kotlin"];

    Birds *thirdBirdsPack = [[Birds alloc] initWithNumber:@6 andKind:@"Swift"];
    
    NSArray *packs = [[NSArray alloc] initWithObjects:firstBirdsPack,
                       seconBirdsPack,
                       thirdBirdsPack, nil];
    
    [fauna configWithBirdPacks:packs];
    
    [fauna release];
    
    return 0;

    return 0;
}
