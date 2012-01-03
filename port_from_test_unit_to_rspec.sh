#!/bin/bash

# A bash shell script for making the initial changes toward
# (hopefully) porting a TestUnit test to rspec.

tu_file=$1
rspec_file=`echo $tu_file | sed 's/test/spec/g' | sed 's/unit/models/g'`
class_name=`grep -o 'class.*Test ' $tu_file | sed 's/class //g' | sed 's/Test//g'`

cp $tu_file $rspec_file

sed -i '~' 's/test_helper/spec_helper/g' $rspec_file
sed -i '~' "s/class.*Test /describe ${class_name}Test /g" $rspec_file
sed -i '~' 's/Test < ActiveSupport::TestCase/do/g' $rspec_file
sed -i '~' 's/should \"/it "should /g' $rspec_file
sed -i '~' 's/setup/before/g' $rspec_file
sed -i '~' 's/teardown/after/g' $rspec_file
sed -i '~' 's/assert_equal\([^(]*\),\([^)]*\)/\2.should == \1/g' $rspec_file
sed -i '~' 's/assert\s\+!\(.*\)/\1.should be_false/g' $rspec_file
sed -i '~' 's/assert\s\+\(.*\)/\1.should be_true/g' $rspec_file
sed -i '~' 's/assert_nil\s\+\(.*\)/\1.should be_nil/g' $rspec_file
sed -i '~' 's/assert_not_equal\s\+\(.*\),\(.*\)/\2.should_not == \1/g' $rspec_file
sed -i '~' "s/should \'/it \'should /g" $rspec_file
sed -i '~' 's/stubs\(\(.*\)\).returns\(\(.*\)\)/stub\1.and_return\3/g' $rspec_file
sed -i '~' 's/stubs(\(.*\)=>\(.*\))/stub(\1).and_return(\2)/g' $rspec_file
sed -i '~' 's/\.expects/.should_receive/g' $rspec_file
sed -i '~' 's/stubs/stub/g' $rspec_file
sed -i '~' 's/assert_not_\([a-z]\+\)\(.*\)/\2.should_not be_\1/g' $rspec_file
sed -i '~' 's/assert_match(\(.*\),\(.*\))/\2.should match \1/g' $rspec_file
# sed -i '~' 's/assert_\([a-z]\+\)\(.*\)/\2.should be_\1/g' $rspec_file
sed -i '~' 's/\.raises/.should raise_exception/g' $rspec_file

git rm $tu_file
git add $rspec_file

rm $rspec_file~
