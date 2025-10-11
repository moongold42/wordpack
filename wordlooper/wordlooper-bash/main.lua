print("make your own \"but every time a word is repeated it loops\" video")
Idx = 0
Timeidx = 0
local isbeginning = true
local pastword = 69420
Wordstorepeat = {}
local starttime = "00:00:00.000"
local currentword = "placeholder"
print("enter the name of your video: ")
local video = io.read()
print("now, enter the name of your subtitles: ")
local captions = io.read()
local file = assert(io.open(captions, "r"))
local read = file:read("*all")
Words = {}
Timeline = {}
local command = "placeholder"
local endtime = "rhombicosidodecahedron"

-- find first index of a matrix function
local function indexOfMatrix(matrix, value)
    for i, row in ipairs(matrix) do
        for j, v in ipairs(row) do
            if v == value then
                return i
            end
        end
    end
    return 0
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

-- make video timeline
Idx = 1

while Idx <= #Words do
    currentword = Words[Idx][5]
    endtime = Words[Idx][2]
    pastword = indexOfMatrix(Words, currentword)
    starttime = Words[pastword][2]
    if pastword < Idx then
        Timeidx = Timeidx + 1
        if isbeginning == true then
            table.insert(Wordstorepeat, "00:00:00.000")
            table.insert(Wordstorepeat, endtime)
            table.insert(Wordstorepeat, starttime)
            table.remove(Words, pastword)
            Idx = pastword - 1
            isbeginning = false
        else
            table.insert(Wordstorepeat, endtime)
            table.insert(Wordstorepeat, starttime)
        table.remove(Words, pastword)
        Idx = pastword - 1
    end
end
Idx = Idx + 1
end

print("finished")

-- make video
Timeidx = 1
while Timeidx < #Wordstorepeat do
    os.execute(string.format("ffmpeg -i %s -ss %s -to %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, Wordstorepeat[Timeidx], Wordstorepeat[Timeidx+1], Timeidx))
    os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Timeidx))
    Timeidx = Timeidx + 2
end

Timeidx = Timeidx + 2
os.execute(string.format("ffmpeg -i %s -ss %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, Wordstorepeat[#Wordstorepeat], Timeidx))
os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Timeidx))
os.execute("ffmpeg -f concat -i array.txt -c:v copy -c:a copy output.mkv")
os.execute("rm -rf tempry/*")
os.execute("echo \"\" > array.txt")

