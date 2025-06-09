set -x

TARGETS=("control_unity" "receiver" "transmitter")

cli() {
	arduino-cli compile $1 \
		-v \
		--fqbn $2 \
		--log \
		--log-level trace

	(( $? != 0 )) && exit 1

	dir="${1%/*}"
	port=""

	if [ $dir == ${TARGETS[0]} ]; then
		port="/dev/ttyACM0"
	fi

	if [ $dir == ${TARGETS[1]} ]; then
		port="/dev/ttyUSB0"
	fi

	if [ $dir == ${TARGETS[2]} ]; then
		port="/dev/ttyUSB2"
	fi

	arduino-cli upload $1 \
		--fqbn $2 \
		-p $port

	return 0
}

build() {
	(( $# != 1 )) && return 1

	board=""
	file=""

	if [ "$1" == "${TARGETS[0]}/" ]; then
		file="$1${1%/}.ino"
		board="esp32:esp32:esp32"

		cli $file $board

		return 0
	fi

	if [ "$1" == "${TARGETS[1]}/" ]; then
		file="$1${1%/}.ino"
		board="esp32:esp32:heltec_wifi_lora_32_V2"

		cli $file $board

		return 0
	fi

	if [ "$1" == "${TARGETS[2]}/" ]; then
		file="$1${1%/}.ino"
		board="esp32:esp32:heltec_wifi_lora_32_V2"

		cli $file $board

		return 0
	fi
}

build $1
set +x
