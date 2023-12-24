local version = "v1.0"

-- Peripherals
local monitor = peripheral.wrap("left")
local target = peripheral.find("create_target")

-- Functions
local function calculateLevel(totalExperience)
    local a = 4.5
    local b = -162.5
    local c = 2220 - totalExperience

    -- Calculate the discriminant
    local discriminant = b ^ 2 - 4 * a * c

    -- Check if the discriminant is non-negative
    if discriminant < 0 then
        return nil -- No real solutions (level is undefined)
    else
        -- Calculate the positive root of the quadratic equation
        local level = (-b + math.sqrt(discriminant)) / (2 * a)
        return math.ceil(level)
    end
end

-- Init
local function init()
    -- Pre-execution checks
    if not target then
        return error("No target found")
    end

    -- Terminal setup
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1, 1)

    -- Monitor setup
    monitor.setBackgroundColor(colors.white)
    monitor.setTextColor(colors.black)
    monitor.clear()

    print("EXPtoLVL " .. version .. " is running...")
end

-- Program
local function main()
    local expCountString = target.getLine(1)
    local expCount = tonumber(string.match(expCountString, "(%d+) mB"))
    local levelCount = calculateLevel(expCount)

    -- Print EXP
    monitor.setCursorPos(1, 2)
    monitor.clearLine()
    if expCount then
        monitor.write("EXP: " .. expCountString)
    else
        monitor.write("EXP: N/A mB")
    end

    -- Print LVL
    monitor.setCursorPos(1, 3)
    monitor.clearLine()
    if levelCount then
        monitor.write("LVL: " .. tostring(levelCount))
    else
        monitor.write("LVL: N/A")
    end
end

-- Main execution loop
local ok_init, err_init = pcall(init)
if ok_init then
    while true do
        -- Clear monitor
        monitor.setCursorPos(1, 1)
        monitor.clearLine()

        -- Execute program
        local ok_main, err_main = pcall(main)

        -- Iteration yield
        sleep(0.05)
    end
else
    printError(err_init)
    return
end
