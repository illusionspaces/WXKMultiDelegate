//
//  NSObject+DisposeBag.h
//  testMultiDelegate
//
//  Created by 王凯 on 2021/2/20.
//  Copyright © 2021 王凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXKDisposeBag.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WXKDisposeBag)

@property (nonatomic, strong) WXKDisposeBag *wxk_disposeBag;

@end

NS_ASSUME_NONNULL_END
