const std = @import("std");

const ArrayList = std.ArrayList;
const HashMap = std.AutoHashMap;
const Tuple = std.meta.Tuple;

const Cursor = struct {
    w: f32,
    h: f32,
};

pub fn count_sums() !void {
    // var file = try std.fs.cwd().openFile("input_day2.txt", .{});
    // defer file.close();
    //
    // const file_size = try file.metadata().size();
    // var buf_reader = std.io.bufferedReader(file.reader());
    // var in_stream = buf_reader.reader();
    // var buf: [file_size]u8 = undefined;
    // in_stream.readAll(&buf);

    // for (buf) | row | {
    //     for (row) | char | {
    //
    //     }
    // }


    std.debug.print("input {s}\n", .{});
}

fn check_quadrants(buf: [][]u8, cursor: *Cursor) !i32 {
    const height = buf.len();
    const width = buf[0].len();
    var accum = 0;

    const mas: []u8 = "MAS";
    // (0, -1), (1, -1), (1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1)
    // (0, -2), (2, -2), (2, 0), (2, 2), (0, 2), (-2, -2), (-2, 0), (-2, -2)
    for (mas) | char | {
        for (0..8) | idx | {

        }
    }


    if (cursor.h >= 4) {
        // Check going up
        if (buf[cursor.h-1][cursor.w] == 'M' and buf[cursor.h-2][cursor.w] == 'A' and buf[cursor.h-1][cursor.w] == 'S' ) {
            accum += 1;
        }
    }

    if (cursor.h)

    return 0;
}
