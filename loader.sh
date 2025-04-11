#!/bin/bash


res=''
inputFile=''
tempText=''
urlVideo=''
urlAudio=''
numLine=''
resList=''
checkFlag=false
dataFlag=false
maxFlag=false
resFlag=false
volume='2'
nameOutput='output'
fixCode='VideoPlayerScrubberPreviewImageOnCanvas.react'

OPTS=$(getopt -o cdf:hmr:v: --long check,datasaver,file:,help,maximum,resolution:,volume: -n 'parse-options' -- "$@") || exit 1
eval set -- "$OPTS"

findUrl(){
tempText=$(grep -oE '"base_url":"[^"]*"' <<< "$tempText" | \
      sed 's/"base_url":"//g;s/"$//;s/\\\//\//g') 
}

downloadFile(){
  curl -L -o "video.mp4" "$urlVideo"
  curl -L -o "audio.mp4" "$urlAudio"
  echo "Combining video and audio..."
  if [ ! -f "video.mp4" ] || [ ! -f "audio.mp4" ]; then
      echo "Error: The downloaded video.mp4 or audio.mp4 may not have completed successfully." >&2
      exit 1
  fi
  ffmpeg -i video.mp4 -i audio.mp4 -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -af "volume="${volume}"" "${nameOutput}.mp4" -y
  rm -f "video.mp4" "audio.mp4"
}

checkRes(){
  echo "Running in check resolution with file: $inputFile"
  echo "Title : "${nameOutput}""
  resList=$(grep -oE 'FBQualityLabel=\\"[0-9]{3,4}p\\"' <<< "$tempText" | grep -oE '[0-9]+p' || echo "This video might be in SD quality.")
}

helpFunc(){
  echo "hello"
  exit 0
}

while true; do
  case "$1" in 
    -c | --check)
      checkFlag=true
      shift
      ;;
    -d | --datasaver)
      dataFlag=true
      shift
      ;;
    -h | --help ) 
      helpFunc
      shift
      ;;
    -f | --file)
      inputFile="$2"
      shift 2
      ;;
    -m | --maximum)
      maxFlag=true
      shift
      ;;
    -r | --resolution) 
      res="$2"
      resFlag=true
      shift 2 
      ;;
    -v | --volume) 
    volume="$2"
    shift 2
    ;;
    --) 
    shift 
    break;;
    *)echo "Invalid option:" >&2; exit 1 ;;
  esac
done

if [[ ! -f "$inputFile" ]]; then
  echo "Error: File '$inputFile' not found" >&2
  exit 1
fi
tempText=$(grep -m 1 "$fixCode" "$inputFile")


raw=$(sed -n 's/.*\("color_ranges":\[\],"text":"[^"]*"\).*/\1/p' "${inputFile}" | sed -n '2p' | sed 's/.*"text":"\([^"]*\)".*/\1/')
nameOutput=$(printf "%b" "$raw")

if $checkFlag; then
  checkRes
  echo ${resList}
  exit 0  
fi

if $dataFlag; then
  findUrl
  {
    read -r urlVideo
    read -r urlAudio
  } < <(sed -n '1p;$p' <<< "$tempText")
  downloadFile
  exit 0
elif $maxFlag; then
  findUrl
  {
    read -r urlVideo
    read -r urlAudio
  } < <(tail -n 2 <<< "$tempText")
  downloadFile
  exit 0
fi

if $resFlag; then
  checkRes
  numLine=$(grep -n "^${res}$" <<< "${resList}" | awk -F: '{print $1}' || echo "This resolution is not available for this video.")
  findUrl
  urlVideo=$(sed -n "${numLine}p" <<< "${tempText}")
  urlAudio=$(tail -n 1 <<<"${tempText}")
  downloadFile
  exit 0
fi

echo "something weird" >&2
exit 1
