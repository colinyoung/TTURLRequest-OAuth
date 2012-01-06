#import "TTURLRequest+OAuth.h"
#import "RandomString.h"

#define kDefaultNonceLength 20

@implementation TTURLRequest (OAuth)

-(void)oauthifyWithConsumerKey:(NSString *)consumerKey
                         token:(NSString *)token
               signatureMethod:(TTURLRequestOAuthSignatureMethod)signatureMethod
                       version:(NSString *)version {
    
    NSMutableDictionary *HTTPAuthorization = [NSMutableDictionary dictionaryWithCapacity:4];
    [HTTPAuthorization setObject:consumerKey forKey:@"oauth_consumer_key"];
    if (token) [HTTPAuthorization setObject:token forKey:@"oauth_token"];
    [HTTPAuthorization setObject:[[self class] stringForSignatureMethod:signatureMethod] forKey:@"oauth_signature_method"];
    [HTTPAuthorization setObject:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]] forKey:@"oauth_timestamp"];
    [HTTPAuthorization setObject:[[self class] nonce:kDefaultNonceLength] forKey:@"oauth_nonce"];
    if (version) [HTTPAuthorization setObject:version forKey:@"oauth_version"];
    
    // Doing this inline so this lib doesn't have any dependencies
    NSMutableString *HTTPAuthorizationString = [NSMutableString string];
    
    int i = 0;
    for (NSString *key in HTTPAuthorization) {
        i++;        
        [HTTPAuthorizationString appendFormat:@"%@=%@", key, [HTTPAuthorization objectForKey:key]];
        if (i < [[HTTPAuthorization allKeys] count]) [HTTPAuthorizationString appendString:@"&"];
    }
    
    TTDPRINT(@"%@", HTTPAuthorizationString);
    
    [self.headers setObject:HTTPAuthorizationString forKey:@"HTTP_AUTHORIZATION"];
}

#pragma mark - Private
+(NSString *)stringForSignatureMethod:(TTURLRequestOAuthSignatureMethod)_signatureMethod {
    switch (_signatureMethod) {
        case TTURLRequestOAuthSignatureMethodHMAC:
            return @"HMAC-SHA1";
            break;
            
        case TTURLRequestOAuthSignatureMethodRSA:
            return @"RSA-SHA1";
            break;
            
        case TTURLRequestOAuthSignatureMethodPlaintext:
        default:
            return @"PLAINTEXT";
    }
    return @"PLAINTEXT";
}
     
+(NSString *)nonce:(int)length {
    char cNonce[length];
    randomString(cNonce, length);
    NSString *nonce = [[[NSString alloc] initWithUTF8String:cNonce] autorelease];
    if (!TTIsStringWithAnyText(nonce)) return @"";    
    return nonce;
}

@end
