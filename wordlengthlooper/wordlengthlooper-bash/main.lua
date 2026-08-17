print("make your own \"but every word repeats by its character length\" video")
Idx = 0
Timeidx = 1
local isbeginning = true
local starttime = "placeholder"
local endtime = "placeholder"
print("enter the name of your video: ")
local video = io.read()
print("enter the name of your subtitles: ")
local captions = io.read()
print("exponent? (type \'1\' if you don't want any exponential growth)")
local exponent = tonumber(io.read())
if exponent > 3 then
 print(string.format("ARE YOU SURE YOU WANT TO CONTINUE? big words like \"everybody\" loop %d TIMES!", 9^exponent))
 print("type \"Y\" to continue, anything else to stop")
 local condition = io.read()
 if condition == "Y" or condition == "y" then
  print("continuing the program...")
 else
 print("exiting the program...")
  os.exit()
end
end
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
    return nil
end

-- find out if a file exists
function fileIsExistent(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- convert .srt file to a matrix
for matrix in read:gmatch("%S+") do
    local b = (Idx % 5) + 1
local a = math.floor(1 + (Idx / 5))
if b == 1 then
    Words[a] = {}
else if b == 2 or b == 4 then
    matrix = string.gsub(matrix, ",", ".")
end
end
Words[a][b] = matrix
Idx = Idx + 1
end

os.execute("rm -rf tempry/*")
os.execute("echo \"\" > array.txt")

-- make videos
Idx = 1
starttime =  Words[Idx][2]
endtime = Words[Idx][4]
os.execute(string.format("ffmpeg -i %s -ss 0.0 -to %s -c:v libx264 -crf 20 -preset veryfast tempry/0.mkv", video, endtime))
os.execute("echo \"file tempry/0.mkv\" >> array.txt")
while Idx <= #Words do
    starttime =  Words[Idx][2]
    endtime = Words[Idx][4]
    local wordlen = tonumber(string.len(Words[Idx][5]))
    wordlen = wordlen^exponent
    os.execute(string.format("ffmpeg -i %s -ss %s -to %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, starttime, endtime, Idx))
    for i=1,wordlen do
        os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Idx))
    end
    Idx = Idx + 1
    if #Words > Idx then
    starttime = Words[Idx][2]
    os.execute(string.format("ffmpeg -i %s -ss %s -to %s -c:v libx264 -crf 20 -preset veryfast tempry/%d.mkv", video, endtime, starttime, Idx+10^9))
    os.execute(string.format("echo \"file tempry/%d.mkv\" >> array.txt", Idx+10^9))
end
end

-- clean up array.txt (remove all non-existent files)
local dasji = assert(io.open("array.txt", "r"))
local dirtyText = dasji:read("*all")
os.execute("echo \"\" > array.txt")
for cleanup in dirtyText:gmatch("[^\r\n]+") do
    cleanup = string.gsub(cleanup, "file ", "")
    print(cleanup)
    if fileIsExistent(cleanup) then
        os.execute(string.format("echo \"file %s\" >> array.txt", cleanup))
    end
end

os.execute("ffmpeg -f concat -i array.txt -c:v copy -c:a copy output.mkv")
os.execute("rm -rf tempry/*")
os.execute("echo \"\" > array.txt")


