const std = @import("std");
const ArrayList = std.ArrayList;
const HashMap = std.AutoHashMap;
const Tuple = std.meta.Tuple;


pub fn count_safe_reports() !void {
    var file = try std.fs.cwd().openFile("input_day1.txt", .{});
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [512]u8 = undefined;
    var accum: i32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var report = ArrayList(i32).init(std.heap.page_allocator);
        defer report.deinit();

        var data = std.mem.split(u8, line, " ");
        try report.append(try std.fmt.parseInt(i32, data.first(), 10));
        while(data.next()) |cur_str|{
            try report.append(try std.fmt.parseInt(i32, cur_str, 10));
        }

        if (try is_report_safe_part2(report)) {
            accum += 1;
        }
    }

    std.debug.print("accum: {d}\n", .{accum});
}

fn is_report_safe_part2(report: ArrayList(i32)) !bool {
    if (try is_report_safe_part1(report)) {
        return true;
    }
    const size: usize = report.items.len;
    for(0..size) |i| {
        var copy = try report.clone();
        _ = copy.orderedRemove(i);
        if(try is_report_safe_part1(copy)) {
            return true;
        }
    }
    return false;
}

fn is_report_safe_part1(report: ArrayList(i32)) !bool{
    const size = report.items.len;
    var dir: i8 = 0; // -1 means dec, +1 means acc
    for(0..size-1) |idx| {
        const result = analyze_pair(report.items[idx], report.items[idx+1], dir);
        if (!result[0]) {
            return false;
        }
        if (dir == 0) {
            dir = result[1];
        } else if (dir != result[1]) {
            return false;
        }
    }
    return true;
}

fn analyze_pair(cur: i32, prev: i32, direction: i8) Tuple(&.{bool, i8}) {
    const diff = cur - prev;
    var dir = direction;
    if (diff < 0 and dir <= 0) {
        dir = -1; //dec
        if (diff < -3) {
            return .{false, dir};
        }
    } else if (diff > 0 and dir >= 0) {
        dir = 1; // acc
        if (diff > 3) {
            return .{false, dir};
        }
    } else if ((diff < 0 and dir > 0) or diff == 0 or (diff > 0 and dir < 0)) {
        return .{false, dir};
    }
    return .{true, dir};
}