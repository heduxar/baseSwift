//
//  Bird.h
//  lesson5
//
//  Created by Юрий Султанов on 30.01.2020.
//  Copyright © 2020 Юрий Султанов. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Birds : NSObject

- (instancetype) initWithNumber:(NSNumber *)number andKind:(NSString *)kind;

@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *kind;

@end

NS_ASSUME_NONNULL_END
