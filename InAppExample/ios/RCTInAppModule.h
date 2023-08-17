//
//  RCTInAppModule.h
//  InAppExample
//
//  Created by Jeremy Wright on 2023-08-17.
//

#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTInAppModule: NSObject <RCTBridgeModule>

- (void)launch;

@end

NS_ASSUME_NONNULL_END
