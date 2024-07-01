const std = @import("std");
const Godot = @import("godot");
const log_helper = @import("log.zig");
const Self = @This();

pub fn instanti() !void {
    log_helper.print("OpenXR: is initialized test", .{});
}
