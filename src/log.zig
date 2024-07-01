const std = @import("std");
const godot = @import("godot");
const gde = godot.GDE;

const LogFn = *const fn ([*:0]const u8, [*:0]const u8, [*:0]const u8, i32, gde.GDExtensionBool) callconv(.C) void;

pub fn print(comptime format: []const u8, args: anytype) void {
    var buf: [4096]u8 = undefined;
    const msg = std.fmt.bufPrintZ(buf[0..], format, args) catch blk: {
        const ellipsis = "...";
        @memcpy(buf[buf.len - ellipsis.len ..], ellipsis);
        break :blk buf[0 .. buf.len - 1 :0];
    };
    const msg_str = godot.String.initFromUtf8Chars(msg);
    godot.UtilityFunctions.print(godot.Variant.initFrom(msg_str), .{});
}

pub fn warn(src: std.builtin.SourceLocation, comptime format: []const u8, args: anytype) void {
    log(src, godot.printWarning, format, args);
}
pub fn err(src: std.builtin.SourceLocation, comptime format: []const u8, args: anytype) void {
    log(src, godot.printError, format, args);
}

inline fn log(src: std.builtin.SourceLocation, printFn: LogFn, comptime format: []const u8, args: anytype) void {
    var buf: [4096]u8 = undefined;
    const msg = std.fmt.bufPrintZ(buf[0..], format, args) catch blk: {
        const ellipsis = "...\x00";
        @memcpy(buf[buf.len - ellipsis.len ..], ellipsis);
        break :blk buf[0 .. buf.len - 1 :0];
    };

    printFn(msg, src.fn_name, src.file, @intCast(src.line), 0);
}
