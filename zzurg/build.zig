const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zzurg_module = b.addModule("zzurg", .{
        .root_source_file = b.path("root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const shared_lib = b.addLibrary(.{
        .name = "zzurg",
        .root_module = zzurg_module,
        .linkage = .dynamic,
    });

    b.installArtifact(shared_lib);

    const unit_tests = b.addTest(.{
        .root_module = zzurg_module,
    });

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_unit_tests.step);
}
