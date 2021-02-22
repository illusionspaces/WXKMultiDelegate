//
//  WXKDisposeBag.h
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXKToken.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXKDisposeBag : NSObject

- (void)addToken:(WXKToken *)token;

@end

NS_ASSUME_NONNULL_END
