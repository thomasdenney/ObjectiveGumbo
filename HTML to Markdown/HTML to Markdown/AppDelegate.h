//
//  AppDelegate.h
//  HTML to Markdown
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ObjectiveGumbo.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *markdownField;
- (IBAction)convert:(id)sender;
@property (weak) IBOutlet NSTextField *htmlField;

@end
