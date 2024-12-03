const std = @import("std");
const ArrayList = std.ArrayList;
const HashMap = std.AutoHashMap;

pub fn search1() !void {
    var file = try std.fs.cwd().openFile("input_day0.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [512]u8 = undefined;
    var rights = ArrayList(i32).init(std.heap.page_allocator);
    defer rights.deinit();

    var links = ArrayList(i32).init(std.heap.page_allocator);
    defer links.deinit();

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var splits = std.mem.split(u8, line, "   ");
        if (splits.buffer.len == 0)
            continue;
        try rights.append(try std.fmt.parseInt(i32, splits.first(), 10));
        try links.append(try std.fmt.parseInt(i32, splits.next().?, 10));
    }


    std.sort.heap(i32, rights.items, {}, std.sort.asc(i32));
    std.sort.heap(i32, links.items, {}, std.sort.asc(i32));

    var accum: i32 = 0;
    for (rights.items, 0..) |value, idx| {
        if (value > links.items[idx]) {
            accum += value - links.items[idx];
        } else {
            accum += links.items[idx] - value;
        }
    }

    std.debug.print("accum: {d}\n", .{accum});
}

pub fn search2() !void {
    var file = try std.fs.cwd().openFile("input_day0.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    var buf: [512]u8 = undefined;
    var rights = HashMap(i32, i32).init(std.heap.page_allocator);
    defer rights.deinit();

    var links = ArrayList(i32).init(std.heap.page_allocator);
    defer links.deinit();

    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var splits = std.mem.split(u8, line, "   ");
        if (splits.buffer.len == 0)
            continue;
        try links.append(try std.fmt.parseInt(i32, splits.first(), 10));

        const right_val = try std.fmt.parseInt(i32, splits.next().?, 10);
        if (rights.contains(right_val)) {
            const accum = rights.get(right_val).?;
            try rights.put(right_val, accum + 1);
        } else {
            try rights.put(right_val, 1);
        }
    }

    var accum: i32 = 0;
    for (links.items) |value| {
        if (rights.contains(value)) {
            accum += value*rights.get(value).?;
        }
    }

    std.debug.print("accum: {d}\n", .{accum});
}
