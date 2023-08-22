//
//  RCTInAppModule.h
//  InAppExample
//
//  Created by Jeremy Wright on 2023-08-17.
//

#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCT_EXTERN_MODULE(InAppModule, NSObject)

RCT_EXTERN_METHOD(configure:(NSString *)url
                  organizationId:(NSString *)organizationId
                  developerName:(NSString *)developerName
                  conversationId:(NSString *)conversationId)

RCT_EXTERN_METHOD(launch)
RCT_EXTERN_METHOD(destroyDB)

RCT_EXTERN_METHOD(retrieveConversations)

@end

NS_ASSUME_NONNULL_END
