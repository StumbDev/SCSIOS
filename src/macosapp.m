#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong, nonatomic) NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSRect frame = NSMakeRect(0, 0, 480, 270);
    self.window = [[NSWindow alloc] initWithContentRect:frame
                                               styleMask:(NSWindowStyleMaskTitled |
                                                          NSWindowStyleMaskClosable |
                                                          NSWindowStyleMaskResizable)
                                                 backing:NSBackingStoreBuffered
                                                   defer:NO];
    [self.window setTitle:@"SCSIOS Utility"];
    [self.window makeKeyAndOrderFront:nil];
    
    NSButton *button = [[NSButton alloc] initWithFrame:NSMakeRect(20, 200, 200, 40)];
    [button setTitle:@"Perform Utility Task"];
    [button setTarget:self];
    [button setAction:@selector(performUtilityTask:)];
    [self.window.contentView addSubview:button];
}

- (void)performUtilityTask:(id)sender {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Utility Task"];
    [alert setInformativeText:@"Performing a utility task..."];
    [alert addButtonWithTitle:@"OK"];
    [alert runModal];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        AppDelegate *delegate = [[AppDelegate alloc] init];
        [app setDelegate:delegate];
        [app run];
    }
    return EXIT_SUCCESS;
}