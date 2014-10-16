// OGDocument.h
//
// Copyright 2014 Programming Thomas
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "OGElement.h"

/**
 OGDocument instances are elements that represent the whole HTML document, including the DOCTYPE
 */
@interface OGDocument : OGElement

@property (readonly) NSString * name;
@property (readonly) NSString * publicIdentifier;
@property (readonly) NSString * systemIdentifier;

- (instancetype)initWithName:(NSString*)name publicID:(NSString*)publicID systemID:(NSString*)systemID;

@end
