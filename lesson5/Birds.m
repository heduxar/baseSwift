//
//  Bird.m
//  lesson5
//
//  Created by Юрий Султанов on 30.01.2020.
//  Copyright © 2020 Юрий Султанов. All rights reserved.
//

#import "Birds.h"

@implementation Birds

- (instancetype)initWithNumber:(NSNumber *)number andKind:(NSString *)kind{
    self = [super init];
    if (self) {
        [number retain];
        [number release];
        _number = number;
        
        [kind retain];
        [kind release];
        _kind = kind;
        NSLog(@"Create %@ birds of %@", number, kind);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Dealloc birds - %@", _number);
    [_number release];
    [super dealloc];
}

@end
