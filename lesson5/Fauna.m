//
//  Fauna.m
//  lesson5
//
//  Created by Юрий Султанов on 30.01.2020.
//  Copyright © 2020 Юрий Султанов. All rights reserved.
//

#import "Fauna.h"
#import "Birds.h"

@implementation Fauna

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"Create birds fauna");
    }
    return self;
}
- (void)configWithBirdPacks:(Birds *)birds {
    [birds retain];
    [birds release];
    _birds = birds;
    for (Birds *bird in birds) {
        NSLog(@"Add %@ %@ at fauna", bird.number, bird.kind);
    }
}

- (void)remove {
    NSLog(@"Birds migration");
    for (Birds *bird in _birds) {
        [bird release];
    }
    [_birds release];
}
- (void)dealloc {
    [self remove];
    NSLog(@"Dealloc fauna");
    [super dealloc];
}

@end
