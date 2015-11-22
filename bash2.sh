#!/bin/bash
read N
if [ ${N} -gt 5 -o ${N} -lt 1 ]; then
  echo "input number must be =< 5 & => 1"
fi
###design
## vertical
for((countY=0;countY<${N};countY++)); do
  USE_VERTICAL=$((${USE_VERTICAL} + 2 * $((16 / 2 ** ${countY}))))
done
MARGIN_V=$((63 - ${USE_VERTICAL}))

## test area
echo "use vertical:${USE_VERTICAL} & margin vertical:${MARGIN_V}"

##<simple line>##################
for i in $(seq 1 100); do
  NORMAL_LINE="${NORMAL_LINE}_"
done
for i in $(seq 1 ${MARGIN_V}); do
    echo ${NORMAL_LINE}
  done
####################################

##horizontal
for((n=${N};n>0;n--)); do
  H_LEFT_POINT=0
for((p=0;p<${n};p++)); do
  H_LEFT_POINT=$((${H_LEFT_POINT} + $((2 ** $((4 - ${p}))))))
done
H_START=$((49 - ${H_LEFT_POINT}))
H_INITIAL_DISTANCE=$((2 * $((2 ** $((5 - ${n})))) - 1))
H_YCOUNT=$((2 ** $((${n} - 1))))

#echo "H_LEFT_POINT is ${H_LEFT_POINT}"
#echo "H_START is ${H_START}"
#echo "H_INITIAL_DISTANCE is ${H_INITIAL_DISTANCE}"
####################################
H_DYNAMIC_DISTANCE=${H_INITIAL_DISTANCE}

for q in $(seq 1 $((2 * $((2 ** $((5 - ${n})))))));do
  TEST_LINE=""
  if [ ${H_INITIAL_DISTANCE} -gt 0 ];then
    H_RIGHT_MARGIN=$((100 - ${H_START} - $((${H_INITIAL_DISTANCE} * ${H_YCOUNT})) - $(($((${H_YCOUNT} - 1)) * ${H_DYNAMIC_DISTANCE})) - $((${H_YCOUNT} * 2))))
  fi
  for i in $(seq 1 ${H_START}); do
    TEST_LINE="${TEST_LINE}_"
  done
  TEST_LINE="${TEST_LINE}1"
  if [ ${n} -eq 1 ]; then
    if [ ${H_INITIAL_DISTANCE} -gt 0 ]; then
      for p in $(seq 1 ${H_INITIAL_DISTANCE}); do
        TEST_LINE="${TEST_LINE}_"
      done
      TEST_LINE="${TEST_LINE}1"
      for b in $(seq 1 ${H_RIGHT_MARGIN}); do
        TEST_LINE="${TEST_LINE}_"
      done
    else
      for b in $(seq 0 ${H_RIGHT_MARGIN}); do
        TEST_LINE="${TEST_LINE}_"
      done
    fi      
  else
    if [ ${H_INITIAL_DISTANCE} -gt 0 ]; then
      for a in $(seq 1 $((${H_YCOUNT} - 1))); do
        for p in $(seq 1 ${H_INITIAL_DISTANCE}); do
          TEST_LINE="${TEST_LINE}_"
        done
        TEST_LINE="${TEST_LINE}1"
        for o in $(seq 1 ${H_DYNAMIC_DISTANCE}); do
          TEST_LINE="${TEST_LINE}_"
        done
        TEST_LINE="${TEST_LINE}1"
      done
      for p in $(seq 1 ${H_INITIAL_DISTANCE}); do
        TEST_LINE="${TEST_LINE}_"
      done
      TEST_LINE="${TEST_LINE}1"
      for b in $(seq 1 ${H_RIGHT_MARGIN}); do
        TEST_LINE="${TEST_LINE}_"
      done
    else
      for a in $(seq 1 $((${H_YCOUNT} - 1))); do
        for o in $(seq 1 ${H_DYNAMIC_DISTANCE}); do
          TEST_LINE="${TEST_LINE}_"
        done				
        TEST_LINE="${TEST_LINE}1"
      done    
      for b in $(seq 0 ${H_RIGHT_MARGIN}); do
        TEST_LINE="${TEST_LINE}_"
      done
    fi
  fi
  echo "${TEST_LINE}"
  if [ ${H_INITIAL_DISTANCE} -gt 0 ];then  
    H_START=$((${H_START} + 1))
    H_DYNAMIC_DISTANCE=$((${H_DYNAMIC_DISTANCE} + 2))
  fi
  H_INITIAL_DISTANCE=$((${H_INITIAL_DISTANCE} - 2))
done
done
