const std = @import("std");
const Godot = @import("godot");
const log_helper = @import("log.zig");
const testnode = @import("testnode.zig");
const Engine = Godot.Engine;
const zware = @import("zware");
const Self = @This();
pub usingnamespace Godot.Node3D;

godot_object: *Godot.Node3D,

pub fn _enter_tree(self: *Self) void {
    if (Godot.Engine.is_editor_hint(self)) return;
    try testnode.instanti();
    try initializ_xr(self);
}

pub fn _process(self: *Self, delta: f64) void {
    _ = self;
    _ = delta;
    //std.debug.print("delta: {d}\n", .{delta});
}

pub fn _notification(self: *Self, what: i32) void {
    if (what == Godot.Node.NOTIFICATION_WM_CLOSE_REQUEST) {
        self.get_tree().quit(0);
    }
}

pub fn _bind_methods() void {
    Godot.registerMethod(Self, "log_help");
}

pub fn log_help(_: *Self) void {
    log_helper.print("testing_method_bind", .{});
}

// pub fn add10(self: *Self, val: u64) u64 {
//     std.log.info("add10 {s}", .{@typeName(@TypeOf(self))});
//     return val + 10;
// }

fn initializ_xr(self: *Self) !void {
    // const xr_server = Godot.XRServer.find_interface(self, "OpenXR");
    const xr_interface = Godot.XRInterface.is_initialized(self);
    if (xr_interface) {
        log_helper.print("OpenXR: is initialized is statement: {}", .{xr_interface});
    } else {
        log_helper.print("OpenXR: is not initialized {} ", .{xr_interface});
    }
    Godot.Node.get_viewport(self).set_use_xr(true);
}

pub fn instanti() !void {
    log_helper.print("public func init", .{});
}
