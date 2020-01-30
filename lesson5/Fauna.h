//
//  Fauna.h
//  lesson5
//
//  Created by Юрий Султанов on 30.01.2020.
//  Copyright © 2020 Юрий Султанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Birds.h"

NS_ASSUME_NONNULL_BEGIN

@interface Fauna : NSObject

- (void)configWithBirdPacks:(Birds *)birds;

@property (nonatomic, strong) Birds *birds;

@end

NS_ASSUME_NONNULL_END
