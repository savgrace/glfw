
project "GLFW" 
    kind "StaticLib" 
    language "C" 

    targetdir ("bin/" ..OutputDir .. "/%{prj.name}") 
    objdir ("bin-int/" .. OutputDir .. "/%{prj.name}")

    files {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/internal.h",
        "src/platform.h",
        "src/mappings.h", --
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c"
    }

    filter "system:windows"
        -- For C compilation  
        -- std=c11 indicates C 2011 ISO standard. This option instructs Clang to warn or reject non-standard ISO C syntax
        -- lgdi32 will link gdi32.lib 
        buildoptions { "/std:c11" }
        systemversion "latest"
        staticruntime "On" 

        files {
            "src/win32_init.c",
            "src/win32_joystick.c", 
            "src/win32_monitor.c",
            "src/win32_time.c", 
            "src/win32_thread.c", 
            "src/win32_window.c", 
            "src/wgl_context.c", 
            "src/egl_context.c", 
            "src/osmesa_context.c"
        }

        links { "gdi32.lib" }

        defines {
            "_WIN32",
            "_GLFW_WIN32", 
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter { "system:windows", "configurations:Release" } 
        buildoptions "/MT"