# install wrk dulu.

NUM_THREADS="${NUM_THREADS:-2}"
NUM_CONS="${NUM_CONS:-2}"
DURATION="${DURATION:-10}"
REQS_PER_SEC="${REQS_PER_SEC:-10}"
ADDRESS="${ADDRESS:-http://hotel-reservation.127.0.0.1.sslip.io}"

# ../../../wrk2/wrk -D exp -t "$NUM_THREADS" -c "$NUM_CONS" -d "$DURATION" -L -s ./wrk2/scripts/hotel-reservation/mixed-workload_type_1.lua http://x.x.x.x:5000 -R "$REQS_PER_SEC"

wrk -D exp -t "$NUM_THREADS" -c "$NUM_CONS" -d "$DURATION" -L -s ../../wrk2/scripts/hotel-reservation/mixed-workload_type_1.lua "$ADDRESS" -R "$REQS_PER_SEC"
