//
//  Token.h
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXKToken : NSObject

@property (nonatomic, copy) NSString *key;

- (void)dispose;

@property (nonatomic, copy) void(^onDispose)(NSString *key);

@end

NS_ASSUME_NONNULL_END
