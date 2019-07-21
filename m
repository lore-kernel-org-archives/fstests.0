Received: from mail-pl1-f194.google.com ([209.85.214.194]:41082 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfGUQrz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Jul 2019 12:47:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so17895964pls.8
        for <fstests@vger.kernel.org>; Sun, 21 Jul 2019 09:47:55 -0700 (PDT)
Date: Mon, 22 Jul 2019 00:47:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
Message-ID: <20190721164748.GK7943@desktop>
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719041231.26500-1-deepa.kernel@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: fstests@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 18, 2019 at 09:12:31PM -0700, Deepa Dinamani wrote:
> The mount behavior will not be altered because of the unsupported
> timestamps on the filesystems.

It'd be better to provide more details in the commit log, e.g. what
kind of mount behavior and what's the changes being made to the tests.

> 
> Adjust the test accordingly.
> 
> An updated series to be posted after the merge window is hosted at
> <https://github.com/deepa-hub/vfs/tree/limits>
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Thanks for the update! But I'd like to wait for the kernel patches
merged into mainline first. Would you please send out a notification by
replying this thread then? Thanks a lot!

Eryu

> ---
>  common/rc             | 36 +++++++++---------
>  tests/generic/402     | 87 ++++++++++++++++---------------------------
>  tests/generic/402.out |  2 +-
>  3 files changed, 53 insertions(+), 72 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 25203bb4..39a2deb0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1959,16 +1959,9 @@ _run_aiodio()
>      return $status
>  }
>  
> -# this test requires y2038 sysfs switch and filesystem
> -# timestamp ranges support.
> -_require_y2038()
> +_require_timestamp_range()
>  {
>  	local device=${1:-$TEST_DEV}
> -	local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
> -
> -	if [ ! -e $sysfsdir ]; then
> -		_notrun "no kernel support for y2038 sysfs switch"
> -	fi
>  
>  	local tsmin tsmax
>  	read tsmin tsmax <<<$(_filesystem_timestamp_range $device)
> @@ -1980,23 +1973,32 @@ _require_y2038()
>  _filesystem_timestamp_range()
>  {
>  	local device=${1:-$TEST_DEV}
> +	u32max=$(((1<<32)-1))
> +	s32min=-$((1<<31))
> +	s32max=$(((1<<31)-1))
> +	s64max=$(((1<<63)-1))
> +	s64min=$((1<<63))
> +
>  	case $FSTYP in
> -	ext4)
> +	ext2)
> +		echo "$s32min $s32max"
> +		;;
> +	ext3|ext4)
>  		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
> -			echo "-2147483648 15032385535"
> +			printf "%d %d\n" $s32min 0x37fffffff
>  		else
> -			echo "-2147483648 2147483647"
> +			echo "$s32min $s32max"
>  		fi
>  		;;
>  
> -	xfs)
> -		echo "-2147483648 2147483647"
> -		;;
>  	jfs)
> -		echo "0 4294967295"
> +		echo "0 $u32max"
>  		;;
> -	f2fs)
> -		echo "-2147483648 2147483647"
> +	xfs)
> +		echo "$s32min $s32max"
> +		;;
> +	btrfs)
> +		echo "$s64min $s64max"
>  		;;
>  	*)
>  		echo "-1 -1"
> diff --git a/tests/generic/402 b/tests/generic/402
> index f742fedd..dd136ec2 100755
> --- a/tests/generic/402
> +++ b/tests/generic/402
> @@ -4,15 +4,10 @@
>  #
>  # FS QA Test 402
>  #
> -# Tests to verify policy for filesystem timestamps for
> -# supported ranges:
> -# 1. Verify filesystem rw mount according to sysctl
> -# timestamp_supported.
> -# 2. Verify timestamp clamping for timestamps beyond max
> -# timestamp supported.
> +# Test to verify filesystem timestamps for supported ranges.
>  #
> -# Exit status 1: either or both tests above fail.
> -# Exit status 0: both the above tests pass.
> +# Exit status 1: test failed.
> +# Exit status 0: test passed.
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -49,47 +44,59 @@ check_stat()
>  	prev_timestamp="$timestamp;$timestamp"
>  	if [ $prev_timestamp != $stat_timestamp ]; then
>  		echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
> +		return 1
>  	fi
> +	return 0
>  }
>  
>  run_test_individual()
>  {
> +	fail=0
>  	file=$1
>  	timestamp=$2
>  	update_time=$3
>  
>  	# check if the time needs update
>  	if [ $update_time -eq 1 ]; then
> -		echo "Updating file: $file to timestamp `date -d @$timestamp`"  >> $seqres.full
> +		echo "Updating file: $file to timestamp $timestamp"  >> $seqres.full
>  		$XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
>  		if [ $? -ne 0 ]; then
>  			echo "Failed to update times on $file" | tee -a $seqres.full
> +			fail=1
>  		fi
>  	fi
>  
> -	tsclamp=$(($timestamp>$tsmax?$tsmax:$timestamp))
> -	echo "Checking file: $file Updated timestamp is `date -d @$tsclamp`"  >> $seqres.full
> -	check_stat $file $tsclamp
> +	tsclamp=$((timestamp<tsmin?tsmin:timestamp>tsmax?tsmax:timestamp))
> +	echo "Checking file: $file Updated timestamp is $tsclamp"  >> $seqres.full
> +	if ! check_stat $file $tsclamp; then
> +		fail=1
> +	fi
> +	return $fail
>  }
>  
>  run_test()
>  {
> +	fail=0
>  	update_time=$1
>  
>  	n=1
>  
>  	for TIME in "${TIMESTAMPS[@]}"; do
> -		run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
> +		if ! run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time; then
> +			fail=1
> +		fi
>  		((n++))
>  	done
> +
> +	return $fail
>  }
>  
>  _scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> -_require_y2038 $SCRATCH_DEV
> +_require_timestamp_range $SCRATCH_DEV
>  
>  read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
> -echo min supported timestamp $tsmin $(date --date=@$tsmin) >> $seqres.full
> -echo max supported timestamp $tsmax $(date --date=@$tsmax) >> $seqres.full
> +echo min supported timestamp $tsmin >> $seqres.full
> +echo max supported timestamp $tsmax >> $seqres.full
>  
>  # Test timestamps array
>  
> @@ -97,45 +104,14 @@ declare -a TIMESTAMPS=(
>  	$tsmin
>  	0
>  	$tsmax
> +	$((tsmax/2))
>  	$((tsmax+1))
> -	4294967295
> -	8589934591
> -	34359738367
>  )
>  
> -# Max timestamp is hardcoded to Mon Jan 18 19:14:07 PST 2038
> -sys_tsmax=2147483647
> -echo "max timestamp that needs to be supported by fs for rw mount is" \
> -	"$((sys_tsmax+1)) $(date --date=@$((sys_tsmax+1)))" >> $seqres.full
> -
> -read ts_check <<<$(cat /proc/sys/fs/fs-timestamp-check-on)
> -
>  _scratch_mount
>  result=$?
>  
> -if [ $ts_check -ne 0 ]; then
> -	echo "sysctl filesystem timestamp check is on" >> $seqres.full
> -	# check for mount failure if the minimum requirement for max timestamp
> -	# supported is not met.
> -	if [ $sys_tsmax -ge $tsmax ]; then
> -		if [ $result -eq 0 ]; then
> -			echo "mount test failed"  | tee -a $seqres.full
> -			exit
> -		fi
> -	else
> -		if [ $result -ne 0 ]; then
> -			echo "failed to mount $SCRATCH_DEV"  | tee -a $seqres.full
> -			exit
> -		fi
> -	fi
> -else
> -	# if sysctl switch is off then mount should succeed always.
> -	echo "sysctl filesystem timestamp check is off" >> $seqres.full
> -	if [ $result -ne 0 ]; then
> -		echo "failed to mount $SCRATCH_DEV and timestamp check is off"  >> $seqres.full
> -		exit
> -	fi
> -fi
> +status=0
>  
>  # Begin test case 1
>  echo "In memory timestamps update test start" >> $seqres.full
> @@ -143,7 +119,9 @@ echo "In memory timestamps update test start" >> $seqres.full
>  # update time on the file
>  update_time=1
>  
> -run_test $update_time
> +if ! run_test $update_time; then
> +	status=1
> +fi
>  
>  echo "In memory timestamps update complete" >> $seqres.full
>  
> @@ -162,12 +140,13 @@ update_time=0
>  echo "On disk timestamps update test start" >> $seqres.full
>  
>  # Re-run test
> -run_test $update_time
> +if ! run_test $update_time; then
> +	status=1
> +fi
>  
>  echo "On disk timestamps update test complete" >> $seqres.full
>  
> -echo "y2038 inode timestamp tests completed successfully"
> +echo "inode timestamp tests completed status $status"
>  
>  # success, all done
> -status=0
> -exit
> +exit $status
> diff --git a/tests/generic/402.out b/tests/generic/402.out
> index 6c5b9308..4500e6c7 100644
> --- a/tests/generic/402.out
> +++ b/tests/generic/402.out
> @@ -1,2 +1,2 @@
>  QA output created by 402
> -y2038 inode timestamp tests completed successfully
> +inode timestamp tests completed status 0
> -- 
> 2.17.1
> 
