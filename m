Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169]:47236 "EHLO
        mgwkm02.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757568AbeD0IKU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Apr 2018 04:10:20 -0400
Subject: Re: [PATCH] btrfs: Add test that checks rmdir(2) can delete a
 subvolume
References: <2f99b131-7eb5-df33-12b9-f05a1468a710@jp.fujitsu.com>
 <20180427044010.GM11384@desktop>
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Message-ID: <8fa94ded-4792-0c1a-4208-3ad47190b1d7@jp.fujitsu.com>
Date: Fri, 27 Apr 2018 16:58:28 +0900
MIME-Version: 1.0
In-Reply-To: <20180427044010.GM11384@desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On 2018/04/27 13:40, Eryu Guan wrote:
> On Thu, Apr 19, 2018 at 04:23:35PM +0900, Misono Tomohiro wrote:
>> Add btrfs test that checks "rmdir" or "rm -r" command can delete a
>> subvolume like an ordinary drectory.
>>
>> This behavior has been restricted long time but becomes allowed by
>> following patch in the kernel:
>>   btrfs: Allow rmdir(2) to delete an empty subvolume
>>
>> Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
> 
> Looks fine to me overall from fstests' perspective of view, some minor
> issues inline.
> 
> But I'd like a Reviewed-by tag from btrfs developers too.
> 
>> ---
>>  tests/btrfs/159     | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/159.out |   2 +
>>  tests/btrfs/group   |   1 +
>>  3 files changed, 143 insertions(+)
>>  create mode 100755 tests/btrfs/159
>>  create mode 100644 tests/btrfs/159.out
>>
>> diff --git a/tests/btrfs/159 b/tests/btrfs/159
>> new file mode 100755
>> index 00000000..2d830502
>> --- /dev/null
>> +++ b/tests/btrfs/159
>> @@ -0,0 +1,140 @@
>> +#! /bin/bash
>> +# FS QA Test btrfs/159
>> +#
>> +# QA test that checks rmdir(2) works for subvolumes like ordinary directories.
>> +#
>> +# This behavior has been restricted long time but becomes allowed by following
>> +# patch in the kernel:
>> +#   btrfs: Allow rmdir(2) to delete an empty subvolume
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2018 Fujitsu. All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +_create_subvol()
> 
> There's no need to name these local helper functions with the leading
> underscore.
> 
>> +{
>> +	$BTRFS_UTIL_PROG subvolume create $1 2>&1 | \
>> +		_filter_scratch >> $seqres.full
> 
> No need to do _filter_scratch if the output won't go to stdout/stderr,
> it's fine or even recommended to not filter the output when dumping them
> to $seqres.full for debug purpose.
> 
> There're a few other places that _filter_scratch can be dropped.
> 
>> +}
>> +
>> +_create_snapshot()
>> +{
>> +	$BTRFS_UTIL_PROG subvolume snapshot $@ 2>&1 | \
>> +		_filter_scratch >> $seqres.full
>> +}
>> +
>> +_rmdir_subvol()
>> +{
>> +	rmdir $1 2>&1 | _filter_scratch
> 
> I notice that we don't expect any output from the test script ("Silence
> is golden" in .out file), so I don't think it's necessary to do
> redirection and filter here, just do "rmdir $1" and any error message
> would break golden image and fail the test.
> 
>> +	return ${PIPESTATUS[0]}
> 
> If you only care about the return value, just dump the rmdir output to
> $seqres.full or /dev/null.
> 
>> +}
>> +
>> +_rm_r_subvol() {
>> +	rm -r $1 2>&1 | _filter_scratch
>> +	return ${PIPESTATUS[0]}
> 
> Same here.
> 
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/btrfs
> 
> No need to source common/btrfs, it's already sourced by common/rc based
> on current $FSTYP.
> 
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# Check that an empty subvolume can be deleted by rmdir
>> +_create_subvol $SCRATCH_MNT/sub1
>> +_rmdir_subvol $SCRATCH_MNT/sub1
>> +
>> +# Check that non-empty subvolume cannot be deleted by rmdir
>> +_create_subvol $SCRATCH_MNT/sub2
>> +touch $SCRATCH_MNT/sub2/file
>> +_rmdir_subvol $SCRATCH_MNT/sub2 >> $seqres.full && \
>> +	_fail "rmdir should fail for non-empty subvolume"
> 
> Just echo the error message, instead of exiting the test, test could
> continue. Or even simpler, don't rely on the return status of
> _rmdir_subvol, just put any expected output from _rmdir_subvol to .out
> file, e.g.
> 
> _rmdir_subvol $SCRATCH_MNT/sub2 | _filter_scratch
> 
> So that, again, any failure message could break the golden image and
> fail the test.

Thanks for the whole review.

Personally I don't want to rely on the output message since it might be
changed. So, I'm going to check the error code and then echo some messages.

Regards,
Tomohiro Misono
 
> 
>> +rm $SCRATCH_MNT/sub2/file
>> +_rmdir_subvol $SCRATCH_MNT/sub2
>> +
>> +# Check that read-only empty subvolume can be deleted by rmdir
>> +_create_subvol $SCRATCH_MNT/sub3
>> +_create_snapshot -r $SCRATCH_MNT/sub3 $SCRATCH_MNT/snap
>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/sub3 ro true 2>&1 | \
>> +	_filter_scratch >> $seqres.full
>> +_rmdir_subvol $SCRATCH_MNT/sub3
>> +_rmdir_subvol $SCRATCH_MNT/snap
>> +
>> +# Check that the default subvolume cannot be deleted by rmdir
>> +_create_subvol $SCRATCH_MNT/sub4
>> +subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT sub4)
>> +$BTRFS_UTIL_PROG subvolume set-default $subvolid $SCRATCH_MNT 2>&1 | \
>> +	_filter_scratch >> $seqres.full
>> +_rmdir_subvol $SCRATCH_MNT/sub4 >> $seqres.full && \
>> +	_fail "rmdir should fail for the default subvolume"
> 
> Same here.
> 
>> +
>> +# Check that subvolume stub (created by snapshot) can be deleted by rmdir
>> +# (Note: this has been always allowed)
>> +_create_subvol $SCRATCH_MNT/sub5
>> +_create_subvol $SCRATCH_MNT/sub5/sub6
>> +_create_snapshot $SCRATCH_MNT/sub5 $SCRATCH_MNT/snap2
>> +rmdir $SCRATCH_MNT/snap2/sub6
>> +
>> +# Check that rm -r works for both non-snapshot subvolume and snapshot
>> +_create_subvol $SCRATCH_MNT/sub7
>> +mkdir $SCRATCH_MNT/sub7/dir
>> +_create_subvol $SCRATCH_MNT/sub7/dir/sub8
>> +touch $SCRATCH_MNT/sub7/dir/sub8/file
>> +
>> +_create_snapshot $SCRATCH_MNT/sub7 $SCRATCH_MNT/snap3
>> +_create_snapshot -r $SCRATCH_MNT/sub7 $SCRATCH_MNT/snap4
>> +
>> +_rm_r_subvol $SCRATCH_MNT/sub7
>> +_rm_r_subvol $SCRATCH_MNT/snap3
>> +_rm_r_subvol $SCRATCH_MNT/snap4 >> $seqres.full && \
>> +	_fail "rm -r should fail for non-empty readonly subvolume"
> 
> Same here.
> 
> Thanks,
> Eryu
> 
>> +
>> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT/snap4 ro false 2>&1 | \
>> +	_filter_scratch >> $seqres.full
>> +_rm_r_subvol $SCRATCH_MNT/snap4
>> +
>> +# success, all done
>> +echo "Silence is golden"
>> +status=0
>> +exit
>> diff --git a/tests/btrfs/159.out b/tests/btrfs/159.out
>> new file mode 100644
>> index 00000000..e569e60c
>> --- /dev/null
>> +++ b/tests/btrfs/159.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 159
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 8007e07e..6a288285 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -161,3 +161,4 @@
>>  156 auto quick trim
>>  157 auto quick raid
>>  158 auto quick raid scrub
>> +159 auto quick subvol
>> -- 
>> 2.14.3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

