latest=`date +%s%N | cut -b1-13`

wget $1 -O "images/${latest}.jpg"

echo "http://blog.jordan.matelsky.com/photo-journal/images/${latest}.jpg)" | pbcopy
