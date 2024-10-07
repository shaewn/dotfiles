return {
    {
        "Civitasv/cmake-tools.nvim",
        keys = {
            {
                "<leader>Cb",
                "<cmd>CMakeBuild<CR>",
                desc = "Build CMake Target",
            },
            { "<leader>Cr", "<cmd>CMakeRun<CR>", desc = "Run CMake Target" },
            {
                "<leader>Cd",
                "<cmd>CMakeDebug<CR>",
                desc = "Debug CMake Target",
            },
            {
                "<leader>Ct",
                "<cmd>CMakeTargetSettings<CR>",
                desc = "Edit CMake Target Settings",
            },
            {
                "<leader>Csbd",
                "<cmd>CMakeSelectBuildDir<CR>",
                desc = "Select CMake Build Dir",
            },
            {
                "<leader>Csbt",
                "<cmd>CMakeSelectBuildTarget<CR>",
                desc = "Select CMake Build Target",
            },
            {
                "<leader>CsbT",
                "<cmd>CMakeSelectBuildType<CR>",
                desc = "Select CMake Build Type",
            },
            {
                "<leader>Csc",
                "<cmd>CMakeSelectCwd<CR>",
                desc = "Select CMake Cwd",
            },
            {
                "<leader>Csk",
                "<cmd>CMakeSelectKit<CR>",
                desc = "Select CMake Kit",
            },
            {
                "<leader>Cst",
                "<cmd>CMakeSelectLaunchTarget<CR>",
                desc = "Select CMake Launch Target",
            },
        },
    },
}
