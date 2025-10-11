print("make your own \"but every next word restarts\" video")
Idx = 0
Timeidx = 1
local isbeginning = true
local pasttime = "00:00:00.000"
print("enter the name of your video: ")
local video = io.read()
print("then, enter the name of your video that's gonna play at every word: ")
local videotoplay = io.read()
print("now, enter the name of your subtitles: ")
local captions = io.read()
local file = assert(io.open(captions, "r"))
local read = file:read("*all")
Words = {}
Timeline = {}
local currenttime = "rhombicosidodecahedron"

-- find first index of a matrix function
local function indexOfMatrix(matrix, value)
    for i, row in ipairs(matrix) do
        for j, v in ipairs(row) do
            if v == value then
                return i
            end
        end
    end
    return nil
end

-- convert .srt file to a matrix
for matrix in read:gmatch("%S+") do
    local b = (Idx % 5) + 1
local a = math.floor(1 + (Idx / 5))
if b == 1 then
    Words[a] = {}
end
Words[a][b] = matrix
Idx = Idx + 1
end

os.execute("rm -rf tempry/*")
os.execute("echo \"\" > array.txt")

-- make videos
Idx = 1

while Idx <= #Words do
    currenttime = Words[Idx][4]
    os.execute(string.format("ffmpeg -i %s -ss %s -to %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, pasttime, currenttime, Idx))
    os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Idx))
    os.execute(string.format("echo \"file %s\" >> array.txt", videotoplay))
    pasttime = currenttime
    Idx = Idx + 1
end

Idx = Idx + 1
os.execute(string.format("ffmpeg -i %s -ss %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, currenttime, Idx))
os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Idx))
os.execute("ffmpeg -f concat -i array.txt -c:v copy -c:a copy output.mkv")
os.execute("rm -rf tempry/*")
os.execute("echo \"\" > array.txt")

