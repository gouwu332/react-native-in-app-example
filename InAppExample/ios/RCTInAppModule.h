//
//  RCTInAppModule.h
//  InAppExample
//
//  Created by Jeremy Wright on 2023-08-17.
//

#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCT_EXTERN_MODULE(InAppModule, NSObject)

RCT_EXTERN_METHOD(launch:(NSString *)url
                  organizationId:(NSString *)organizationId
                  developerName:(NSString *)developerName
                  conversationId:(NSString *)conversationId)

@end

NS_ASSUME_NONNULL_END
