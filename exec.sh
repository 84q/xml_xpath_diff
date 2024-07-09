read -p "Enter the dir name: " dir_base
dir=_$dir_base

mkdir $dir

if [ $? -ne 0 ]; then
  echo "Error in creating the directory($dir)"
  exit 2
fi

input1="test1.xml"
input2="test2.xml"
ruby ./main.rb $input1 $input2 $dir

if [ $? -ne 0 ]; then
  echo "Error in running the script"
  rm -rf $dir
  exit 3
fi

cd $dir
xmllint --encode utf-8 --format $input1 --output $input1
xmllint --encode utf-8 --format $input2 --output $input2
diff $input1 $input2 > diff.txt
