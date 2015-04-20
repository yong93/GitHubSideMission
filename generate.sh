__rvm_md5_for()
{
  if builtin command -v md5 > /dev/null; then
    echo -n $1 | md5
  elif builtin command -v md5sum > /dev/null ; then
    echo -n $1 | md5sum | awk '{print $1}'
  else
    rvm_error "Neither md5 nor md5sum were found in the PATH"
    return 1
  fi

  return 0
}

email=$1
hash="$(__rvm_md5_for $email)"
safe_email=${email//[^\.0-9a-zA-Z]/-}
#echo $email
#echo $safe_email
#echo $hash
echo "<xml>" > $safe_email
echo "<email>$email</email>" >> $safe_email
echo "<hash>$hash</hash>" >> $safe_email
echo "</xml>" >> $safe_email