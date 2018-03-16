Received: from mail-pl0-f67.google.com ([209.85.160.67]:33080 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeCPIdl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 16 Mar 2018 04:33:41 -0400
Date: Fri, 16 Mar 2018 16:33:34 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH RFC 3/3] fstests: generic: Check the fs after each FUA
 writes
Message-ID: <20180316083334.GR30836@localhost.localdomain>
References: <20180314090230.25055-1-wqu@suse.com>
 <20180314090230.25055-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314090230.25055-3-wqu@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, amir73il@gmail.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 14, 2018 at 05:02:30PM +0800, Qu Wenruo wrote:
> Basic test case which triggers fsstress with dm-log-writes, and then
> check the fs after each FUA writes.
> With needed infrastructure and special handlers for journal based fs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> In my test, xfs and btrfs survives while ext4 would report error during fsck.
> 
> My current biggest concern is, we abuse $TEST_DEV and mkfs on it all by
> ourselves. Not sure if it's allowed.
> ---
>  common/dmlogwrites    | 119 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/481     | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/481.out |   2 +
>  tests/generic/group   |   1 +
>  4 files changed, 246 insertions(+)
>  create mode 100755 tests/generic/481
>  create mode 100644 tests/generic/481.out
> 
> diff --git a/common/dmlogwrites b/common/dmlogwrites
> index 467b872e..258f5887 100644
> --- a/common/dmlogwrites
> +++ b/common/dmlogwrites
> @@ -126,3 +126,122 @@ _log_writes_cleanup()
>  	$UDEV_SETTLE_PROG >/dev/null 2>&1
>  	_log_writes_remove
>  }
> +
> +# Convert log writes mark to entry number
> +# Result entry number is output to stdout, could be empty if not found
> +_log_writes_mark_to_entry_number()
> +{
> +	local _mark=$1
> +	local ret
> +
> +	[ -z "$_mark" ] && _fatal \
> +		"mark must be given for _log_writes_mark_to_entry_number"
> +
> +	ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
> +		--end-mark $_mark 2> /dev/null)
> +	[ -z "$ret" ] && return
> +	ret=$(echo "$ret" | cut -f1 -d\@)
> +	echo "mark $_mark has entry number $ret" >> $seqres.full
> +	echo "$ret"
> +}
> +
> +# Find next fua write entry number
> +# Result entry number is output to stdout, could be empty if not found
> +_log_writes_find_next_fua()
> +{
> +	local _start_entry=$1
> +	local ret
> +
> +	[ -z "$_start_entry" ] && _start_entry=0
> +	ret=$($here/src/log-writes/replay-log --find --log $LOGWRITES_DEV \
> +	      --next-fua --start-entry $_start_entry 2> /dev/null)
> +	[ -z "$ret" ] && return
> +
> +	ret=$(echo "$ret" | cut -f1 -d\@)
> +	echo "next fua is entry number $ret" >> $seqres.full
> +	echo "$ret"
> +}
> +
> +# Replay log range to specified entry
> +# $1:	End entry. The entry with this number *WILL* be replayed
> +# $2:	Start entry. If not specified, start from the first entry.
> +# $3:	Verbose. If set to 'y' do verbose output
> +_log_writes_replay_log_entry_range()

_log_writes_replay_log_range() would be fine.

> +{
> +	local _end=$1
> +	local _start=$2

This arguments order ($end comes first) makes me confused when I first
read the test code. Reverse the order?

> +	local _verbose=$3
> +
> +	[ -z "$_end" ] && _fatal \
> +	"end entry must be specified for _log_writes_replay_log_entry_range"
> +
> +	[ "x$verbose" == "xy" ] && _verbose="-v"
> +	[ -z "$_start" ] && _start=0
> +	[ "$_start" -gt "$_end" ] && _fatal \
> +		"wrong parameter order for _log_writes_replay_log_entry_range:start=$_start end=$_end"
> +
> +	# To ensure we replay the last entry, for _start == 0 case,
> +	# we need to manually increase the end entry number to ensure
> +	# it's played
> +	echo "=== replay from $_start to $_end ===" >> $seqres.full
> +	$here/src/log-writes/replay-log --log $LOGWRITES_DEV \
> +		--replay $SCRATCH_DEV --start-entry $_start \
> +		--limit $(($_end - $_start + 1)) $_verbose \
> +		>> $seqres.full 2>&1
> +	[ $? -ne 0 ] && _fatal "replay failed"
> +}
> +
> +_log_writes_cleanup_snapshot()
> +{
> +	$UDEV_SETTLE_PROG > /dev/null 2>&1
> +	$DMSETUP_PROG remove "$DMLOGWRITES_SNAPSHOT_NAME" > /dev/null 2>&1
> +	$DMSETUP_PROG remove "$DMLOGWRITES_ORIGIN_NAME" > /dev/null 2>&1
> +}
> +
> +# Helper to create snapshot of a the replayed device
> +# Useful for journal based filesystem such as XFS and Ext4 to replay
> +# their journal without touching the replay device, so that we can
> +# continue replaying other than replay from the beginning.
> +# $1:	Snapshot device
> +_log_writes_create_snapshot()
> +{
> +	_require_dm_target snapshot

This doesn't belong here, call it in the test.

> +
> +	local snapshot_dev=$1
> +	local cow_base=""

Unused variable.

> +
> +	[ -z "$snapshot_dev" ] && _fatal \
> +		"@device must be specified for _log_writes_create_snapshot"
> +	local size=$(blockdev --getsz $SCRATCH_DEV)
> +	[ -z "$size" ] && _fatal \
> +		"failed to get device size for _log_writes_create_snapshot"
> +
> +	_log_writes_cleanup_snapshot
> +
> +	DMLOGWRITES_ORIGIN_NAME="log-writes-origin"
> +	DMLOGWRITES_SNAPSHOT_NAME="log-writes-snapshot"
> +	DMLOGWRITES_ORIGIN_TABLE="0 $size snapshot-origin $SCRATCH_DEV"
> +	DMLOGWRITES_SNAPSHOT_TABLE="0 $size snapshot /dev/mapper/$DMLOGWRITES_ORIGIN_NAME $snapshot_dev N 512"
> +
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> +	$DMSETUP_PROG create $DMLOGWRITES_ORIGIN_NAME --table "$DMLOGWRITES_ORIGIN_TABLE" ||\
> +		_fatal "failed to create snapshot-origin of log writes target"
> +	$DMSETUP_PROG mknodes > /dev/null 2>&1
> +	$UDEV_SETTLE_PROG >/dev/null 2>&1
> +	$DMSETUP_PROG create $DMLOGWRITES_SNAPSHOT_NAME --table "$DMLOGWRITES_SNAPSHOT_TABLE" ||\
> +		_fatal "failed to create snapshot of log writes target"
> +	$DMSETUP_PROG mknodes > /dev/null 2>&1
> +}
> +
> +_log_writes_mount_snapshot()
> +{
> +	_scratch_options mount
> +	$MOUNT_PROG -t $FSTYP `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> +		"/dev/mapper/$DMLOGWRITES_SNAPSHOT_NAME" $SCRATCH_MNT
> +}
> +
> +_log_writes_unmount_snapshot()
> +{
> +	$UMOUNT_PROG $SCRATCH_MNT
> +}
> +
> diff --git a/tests/generic/481 b/tests/generic/481
> new file mode 100755
> index 00000000..3985493d
> --- /dev/null
> +++ b/tests/generic/481
> @@ -0,0 +1,124 @@
> +#! /bin/bash
> +# FS QA Test 481
> +#
> +# Test filesystem consistency after each FUA operation
> +#
> +# Will do log replay and check the filesystem.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2018 SuSE.  All Rights Reserved.
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
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> +	_log_writes_cleanup_snapshot &> /dev/null
> +	_log_writes_cleanup &> /dev/null
> +
> +	# We use $TEST_DEV as snapshot COW device, which can't be
> +	# mounted/recognized as normal fs, need to recreate it
> +	# or fstest will complain about it
> +	_mkfs_dev $TEST_DEV > /dev/null 2>&1
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmlogwrites
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +
> +_require_command "$KILLALL_PROG" killall
> +# Use $TEST_DEV as snapshot CoW device
> +_require_test
> +# Use $SCRATCH_DEV as replay device
> +_require_scratch
> +# and we need extra device as log device
> +_require_log_writes
> +
> +
> +workload=$(( 512 * $LOAD_FACTOR ))
> +nr_threads=$(($($here/src/feature -o) * $LOAD_FACTOR))
> +
> +_test_unmount
> +_log_writes_init
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +run_check $FSSTRESS_PROG -w -n $workload -p $nr_threads -d $SCRATCH_MNT \
> +	$FSSTRESS_AVOID > /dev/null 2>&1

Use _scale_fsstress_args to scale the load.

And I don't think checking the result of fsstress is necessary, it's
used as a load generator and we check fs consistency anyway.

> +_log_writes_unmount
> +
> +_log_writes_remove
> +prev=$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +_log_writes_replay_log_entry_range $prev
> +while [ ! -z "$cur" ]; do
> +	_log_writes_replay_log_entry_range $cur $prev >> $seqres.full
> +
> +	echo "=== Replay to entry number $cur ===" >> $seqres.full
> +	# Here we need extra mount to replay the log, mainly for journal based
> +	# fs, as their fsck will report dirty log as error. So do snapshot
> +	# to replay, so we can still continue replaying
> +	_log_writes_create_snapshot $TEST_DEV
> +	_log_writes_mount_snapshot
> +	_log_writes_unmount_snapshot
> +	_check_generic_filesystem "/dev/mapper/$DMLOGWRITES_SNAPSHOT_NAME"

Use _check_scratch_fs $some_dev, _check_generic_filesystem doesn't work
for xfs/btrfs/udf/overlay.

> +	if [ $? -ne 0 ]; then
> +		_log_writes_replay_log_entry_range $cur $prev y >> $seqres.full
> +		_fail "error found in fsck after log replay"
> +	fi

And _check_scratch_fs/_check_generic_filesystem exits directly on fsck
failure, you can't do the return status check.

> +	_log_writes_cleanup_snapshot
> +
> +	prev=$cur
> +	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> +	[ -z "$cur" ] && break
> +done
> +_log_writes_cleanup_snapshot
> +_log_writes_cleanup
> +
> +# mkfs before ending the test case, or $TEST_DEV doesn't contain any
> +# valid fs
> +_mkfs_dev $TEST_DEV
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/481.out b/tests/generic/481.out
> new file mode 100644
> index 00000000..206e1163
> --- /dev/null
> +++ b/tests/generic/481.out
> @@ -0,0 +1,2 @@
> +QA output created by 481
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index ea2056b1..1de053a6 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -483,3 +483,4 @@
>  478 auto quick
>  479 auto quick metadata
>  480 auto quick metadata
> +481 auto

Add 'replay' group, as all other tests using dm-log-writes.

Thanks,
Eryu
