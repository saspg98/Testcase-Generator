#! /bin/bash
if [ -d 'testcases' ]; then
	rm -r testcases
fi
mkdir testcases
mkdir testcases/inputs
mkdir testcases/outputs
input=$1
tc=$2
filename=${input%%.cpp}
g++ $input -o $filename.out
while [ $tc -gt 0 ]
do
	tc_input='i'
	tc_input+=$tc
	tc_output='o'
	tc_output+=$tc
	ul_t=10000
	t=$(shuf -i 1-$ul_t -n 1)
	echo $t > testcases/inputs/$tc_input
	cnt=$t
	while [ $cnt -gt 0 ]
	do
		ul_n=1000000000
		n=$(shuf -i 1-$ul_n -n 1)
		echo $n >> testcases/inputs/$tc_input
		cnt=$(( $cnt-1 ))
	done
	cat testcases/inputs/$tc_input | ./$filename.out > testcases/outputs/$tc_output
	tc=$(( $tc-1 ))
done
zip_file=$filename
zip_file+='_testcases'
zip -r $zip_file.zip testcases