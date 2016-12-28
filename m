Received: from mx1.redhat.com ([209.132.183.28]:39360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbcL1LFL (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Dec 2016 06:05:11 -0500
Date: Wed, 28 Dec 2016 19:05:09 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/390: Add tests for inode timestamp policy
Message-ID: <20161228110509.GA1859@eguan.usersys.redhat.com>
References: <1482637093-13139-1-git-send-email-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1482637093-13139-1-git-send-email-deepa.kernel@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: fstests@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 24, 2016 at 07:38:13PM -0800, Deepa Dinamani wrote:
> The test helps to validate clamping and mount behaviors
> according to supported file system timestamp ranges.
> 
> Note that the test can fail on 32-bit systems for a
> few file systems. This will be corrected when vfs is
> transitioned to use 64-bit timestamps.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
> The branch of the kernel tree can be located at
> 
> https://github.com/deepa-hub/vfs refs/heads/vfs_timestamp_policy
> 
> The xfs_io patch to add utimes is at
> 
> https://www.spinics.net/lists/linux-xfs/msg02952.html

Thanks for this info! I built your test kernel and applied the xfs_io
patch, and I got test failure on XFS, test passed on ext4 (256 inode
size) without problems, is this expected?

[root@localhost xfstests]# uname -a
Linux localhost 4.9.0-rc6-next-20161123.y2038+ #14 SMP Wed Dec 28 16:01:54 CST 2016 x86_64 x86_64 x86_64 GNU/Linux
[root@localhost xfstests]# diff -u tests/generic/402.out
/root/workspace/xfstests/results//xfs_4k/generic/402.out.bad
--- tests/generic/402.out       2016-12-28 16:16:23.773711175 +0800
+++ /root/workspace/xfstests/results//xfs_4k/generic/402.out.bad 2016-12-28 16:43:54.825058119 +0800
@@ -1,2 +1,2 @@
 QA output created by 402
 -y2038 inode timestamp tests completed successfully
 +2147483647;2147483647 != 2147483648;2147483648

seqres.full shows:

meta-data=/dev/mapper/systemvg-testlv2 isize=256    agcount=16, agsize=245696 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=0        finobt=0, sparse=0, rmapbt=0
data     =                       bsize=4096   blocks=3931136, imaxpct=25
         =                       sunit=64     swidth=192 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=64 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
min supported timestamp -2147483648 Sat Dec 14 04:45:52 CST 1901
max supported timestamp 2147483647 Tue Jan 19 11:14:07 CST 2038
min timestamp that needs to be supported by fs for rw mount is 2147483647 Tue Jan 19 11:14:07 CST 2038
sysctl filesystem timestamp check is on
In memory timestamps update test start
Updating file: /mnt/testarea/scratch/test_1 to timestamp Sat Dec 14 04:45:52 CST 1901
Checking file: /mnt/testarea/scratch/test_1 Updated timestamp is Sat Dec 14 04:45:52 CST 1901
Updating file: /mnt/testarea/scratch/test_2 to timestamp Thu Jan  1 08:00:00 CST 1970
Checking file: /mnt/testarea/scratch/test_2 Updated timestamp is Thu Jan  1 08:00:00 CST 1970
Updating file: /mnt/testarea/scratch/test_3 to timestamp Tue Jan 19 11:14:07 CST 2038
Checking file: /mnt/testarea/scratch/test_3 Updated timestamp is Tue Jan 19 11:14:07 CST 2038
Updating file: /mnt/testarea/scratch/test_4 to timestamp Tue Jan 19 11:14:08 CST 2038
Checking file: /mnt/testarea/scratch/test_4 Updated timestamp is Tue Jan 19 11:14:07 CST 2038
2147483647;2147483647 != 2147483648;2147483648

> 
> Changes since v1:
> * Use xfs_io utimes command
> * Updated error handling
> * Reorganized code according to review comments
> 
>  common/rc             |  42 +++++++++++
>  tests/generic/390     | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/390.out |   2 +
>  tests/generic/group   |   1 +
>  4 files changed, 242 insertions(+)
>  create mode 100755 tests/generic/390
>  create mode 100644 tests/generic/390.out
> 
> diff --git a/common/rc b/common/rc
> index e3b54ec..93c6e65 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1960,6 +1960,45 @@ _run_aiodio()
>      return $status
>  }
>  
> +# this test requires y2038 sysfs switch support
> +#
> +_require_y2038_sysfs()
> +{
> +	sysfsdir=/proc/sys/fs/fs-timestamp-check-on
> +
> +	if [ ! -e $sysfsdir ]; then
> +		_notrun "no kernel support for y2038 sysfs switch"
> +	fi
> +}
> +
> +_filesystem_timestamp_range()
> +{
> +	device=${1:-$TEST_DEV}
> +	case $FSTYP in
> +	ext4)
> +		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
> +			echo "-2147483648 15032385535"
> +		else
> +			echo "-2147483648 2147483647"
> +		fi
> +		;;
> +
> +	xfs)
> +		echo "-2147483648 2147483647"
> +		;;
> +	jfs)
> +		echo "0 4294967295"
> +		;;
> +	f2fs)
> +		echo "-2147483648 2147483647"
> +		;;
> +	*)
> +		echo "-1 -1"
> +		_notrun "filesystem $FSTYP timestamp bounds are unknown"

This "_notrun" doesn't belong here. I think we can introduce a
_require_y2038 rule. e.g.

_require_y2038()
{
	local device=${1:-$TEST_DEV}
	local sysfsdir=/proc/sys/fs/fs-timestamp-check-on
	if [ ! -ne $sysfsdir ]; then
		_notrun "no kernel support for y2038 sysfs switch"
	fi

	local tsmin tsmax
	read tsmin tsmax <<<$(_filesystem_timestamp_range $device)
	if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
		_notrun "filesystem $FSTYP timestamp bounds are unknown"
	fi
}

Then

_scratch_mkfs
_require_y2038 $SCRATCH_DEV

> +		;;
> +	esac
> +}
> +
>  # indicate whether YP/NIS is active or not
>  #
>  _yp_active()
> @@ -2070,6 +2109,9 @@ _require_xfs_io_command()
>  		echo $testio | egrep -q "Inappropriate ioctl" && \
>  			_notrun "xfs_io $command support is missing"
>  		;;
> +	"utimes" )
> +		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
> +		;;
>  	*)
>  		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
>  	esac
> diff --git a/tests/generic/390 b/tests/generic/390
> new file mode 100755
> index 0000000..8ccadad
> --- /dev/null
> +++ b/tests/generic/390
> @@ -0,0 +1,197 @@
> +#! /bin/bash
> +# FS QA Test 390
> +#
> +# Tests to verify policy for filesystem timestamps for
> +# supported ranges:
> +# 1. Verify filesystem rw mount according to sysctl
> +# timestamp_supported.
> +# 2. Verify timestamp clamping for timestamps beyond max
> +# timestamp supported.
> +#
> +# Exit status 1: either or both tests above fail.
> +# Exit status 0: both the above tests pass.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2016 Deepa Dinamani.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "exit \$status" 0 1 2 3 15
> +
> +# Get standard environment, filters and checks.
> +. ./common/rc
> +. ./common/filter
> +. ./common/attr
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Prerequisites for the test run.
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command utimes
> +_require_y2038_sysfs
> +
> +# Compare file timestamps obtained from stat
> +# with a given timestamp.
> +check_stat()
> +{
> +	file=$1
> +	timestamp=$2
> +
> +	stat_timestamp=`stat -c"%X;%Y" $file`
> +
> +	prev_timestamp="$timestamp;$timestamp"
> +	if [ $prev_timestamp != $stat_timestamp ]; then
> +		echo "$prev_timestamp != $stat_timestamp" | tee -a $seqres.full
> +		exit

No need to exit here. We prefer continuing the test in fstests when such
test failure happens, it enlarges the test coverage and exercises some
error paths. One exception is that when continuing the test could result
in blocking all subsequent tests, we should exit early, one example
provided later.

> +	fi
> +}
> +
> +run_test_individual()
> +{
> +	file=$1
> +	timestamp=$2
> +	update_time=$3
> +
> +	#check if the time needs update
> +	if [ $update_time -eq 1 ]; then
> +		echo "Updating file: $file to timestamp `date -d @$timestamp`"  >> $seqres.full
> +		$XFS_IO_PROG -f -c "utimes $timestamp 0 $timestamp 0" $file
> +		if [ $? -ne 0 ]; then
> +			echo "Failed to update times on $file" | tee -a $seqres.full
> +			exit

Same here.

> +		fi
> +	fi
> +
> +	tsclamp=$(($timestamp>$tsmax?$tsmax:$timestamp))
> +	echo "Checking file: $file Updated timestamp is `date -d @$tsclamp`"  >> $seqres.full
> +	check_stat $file $tsclamp
> +}
> +
> +run_test()
> +{
> +	update_time=$1
> +
> +	#initialization iterator
> +	n=1
> +
> +	for TIME in "${TIMESTAMPS[@]}"
> +	do
> +		#Run the test
> +		run_test_individual ${SCRATCH_MNT}/test_$n $TIME $update_time
> +
> +		#update iterator
> +		((n++))

Seems the comments here are not necessary, initialize the iterator, run
the test and update iterator are all obvious.

And we prefer this code style in fstests:
for TIME in "${TIMESTAMPS[@]}"; do
	...
done

> +	done
> +}
> +
> +_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"

Let test continue here on mkfs and mount failure, test harness will
capture these failures too, and running tests in these failure
conditions sometimes reveal interesting bugs :)

One example that we should exit on mkfs & mount failure is that we're
testing ENOSPC and going to fulfill the test filesystem, and we'll eat
all free space on root fs if we failed to mount the test device, and all
subsequent tests are blocked because of ENOSPC on root fs.

> +read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)
> +
> +echo min supported timestamp $tsmin $(date --date=@$tsmin) >> $seqres.full
> +echo max supported timestamp $tsmax $(date --date=@$tsmax) >> $seqres.full
> +
> +#Test timestamps array

Please add a space after "#" in comments.

> +
> +declare -a TIMESTAMPS=(
> +	$tsmin
> +	0
> +	$tsmax
> +	$((tsmax+1))
> +	4294967295
> +	8589934591
> +	34359738367
> +)
> +
> +# Max timestamp is hardcoded to Mon Jan 18 19:14:07 PST 2038
> +sys_tsmax=2147483647
> +echo "min timestamp that needs to be supported by fs for rw mount is $sys_tsmax $(date --date=@$sys_tsmax)" >> $seqres.full

Meant "max timestamp" here?

> +
> +read ts_check <<<$(cat /proc/sys/fs/fs-timestamp-check-on)
> +
> +_scratch_mount
> +result=$?
> +
> +if [ $ts_check -ne 0 ]; then
> +	echo "sysctl filesystem timestamp check is on" >> $seqres.full
> +	if [ $sys_tsmax -gt $tsmax ]; then
> +		if [ $result -eq 0 ]; then
> +			echo "mount test failed"  | tee -a $seqres.full
> +			exit
> +		fi
> +	else
> +		if [ $result -ne 0 ]; then
> +			echo "failed to mount $SCRATCH_DEV"  | tee -a $seqres.full
> +			exit
> +		fi
> +	fi
> +else
> +	echo "sysctl filesystem timestamp check is off" >> $seqres.full
> +	if [ $result -ne 0 ]; then
> +		echo "failed to mount $SCRATCH_DEV and timestamp check is off"  >> $seqres.full
> +		exit
> +	fi
> +fi

I think we need some comments on this code block to explain the logic
and expected behavior.

> +
> +# Begin test case 1
> +echo "In memory timestamps update test start" >> $seqres.full
> +
> +#update time on the file
> +update_time=1
> +
> +#Run test
> +run_test $update_time
> +
> +echo "In memory timestamps update complete" >> $seqres.full
> +
> +echo "Unmounting and mounting scratch $SCRATCH_MNT" >> $seqres.full
> +
> +#unmount and remount $SCRATCH_DEV
> +_scratch_cycle_mount
> +if [ $? -ne 0 ];then
> +	echo "Failed to remount $SCRATCH_DEV" | tee -a $seqres.full
> +	exit
> +fi

No need to exit. Further, no need to check _scratch_cycle_mount status.

Thanks,
Eryu

> +
> +# Begin test case 2
> +
> +#re-initialize iterator
> +n=1
> +
> +#Do not update time on the file, just read from disk
> +update_time=0
> +
> +echo "On disk timestamps update test start" >> $seqres.full
> +
> +#Re-run test
> +run_test $update_time
> +
> +echo "On disk timestamps update test complete" >> $seqres.full
> +
> +echo "y2038 inode timestamp tests completed successfully"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/390.out b/tests/generic/390.out
> new file mode 100644
> index 0000000..82bd4eb
> --- /dev/null
> +++ b/tests/generic/390.out
> @@ -0,0 +1,2 @@
> +QA output created by 390
> +y2038 inode timestamp tests completed successfully
> diff --git a/tests/generic/group b/tests/generic/group
> index 08007d7..d137d01 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -392,3 +392,4 @@
>  387 auto clone
>  388 auto log metadata
>  389 auto quick acl
> +390 auto quick rw
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
