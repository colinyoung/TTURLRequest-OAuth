#import "TTURLRequest+OAuth.h"

@implementation TTURLRequest (OAuth)

-(void)oauthifyWithConsumerKey:(NSString *)_consumerKey
                         token:(NSString *)_token
               signatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod
                       version:(NSString *)_version {
    
    [self.headers setObject:_consumerKey forKey:@"oauth_consumer_key"];
    if (_token) [self.headers setObject:_token forKey:@"oauth_token"];
    [self.headers setObject:[[self class] stringForSignatureMethod:_signatureMethod] forKey:@"oauth_signature_method"];
    [self.headers setObject:[NSString stringWithFormat:@"%@", [[NSDate alloc] timeIntervalSince1970]] forKey:@"oauth_timestamp"];
    // @todo oauth_nonce
    if (_version) [self.headers setObject:_version forKey:@"oauth_version"];
}

+(NSString *)stringForSignatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod {
    NSString *__ = @"";
    switch (_signatureMethod) {
        case TTURLRequestOAuthSignatureMethodPlaintext:
            __ = @"Plaintext";
            break;
            
        default:
            __ = @"Plaintext";
            break;
    }
    return __;
}

@end
