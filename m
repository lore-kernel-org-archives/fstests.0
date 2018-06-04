Received: from mail.cn.fujitsu.com ([183.91.158.132]:31092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751273AbeFDFBI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jun 2018 01:01:08 -0400
Message-ID: <5B14C78B.4020303@cn.fujitsu.com>
Date: Mon, 4 Jun 2018 13:00:59 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] xfs: Regression test for vulnerable directory integrity
 check
References: <20180530065843.GG6581@desktop> <1527670423-2795-1-git-send-email-yangx.jy@cn.fujitsu.com> <20180603133718.GJ6581@desktop> <20180603225655.GY12940@magnolia> <20180604045436.GN6581@desktop>
In-Reply-To: <20180604045436.GN6581@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2018/06/04 12:54, Eryu Guan wrote:
> On Sun, Jun 03, 2018 at 03:56:55PM -0700, Darrick J. Wong wrote:
>> On Sun, Jun 03, 2018 at 09:37:18PM +0800, Eryu Guan wrote:
>>> On Wed, May 30, 2018 at 04:53:43PM +0800, Xiao Yang wrote:
>>>> If a malicious XFS contains a block+ format directory wherein the
>>>> directory inode's core.mode is corrupted, and there are subdirectories
>>>> of the corrupted directory, an attempt to traverse up the directory
>>>> tree by running xfs_scrub will crash the kernel in __xfs_dir3_data_check.
>>>>
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> Thanks for the update!
>>>
>>>> ---
>>>>   tests/xfs/448     | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   tests/xfs/448.out |  2 ++
>>>>   tests/xfs/group   |  1 +
>>>>   3 files changed, 99 insertions(+)
>>>>   create mode 100755 tests/xfs/448
>>>>   create mode 100644 tests/xfs/448.out
>>>>
>>>> diff --git a/tests/xfs/448 b/tests/xfs/448
>>>> new file mode 100755
>>>> index 0000000..9ea9295
>>>> --- /dev/null
>>>> +++ b/tests/xfs/448
>>>> @@ -0,0 +1,96 @@
>>>> +#! /bin/bash
>>>> +# FS QA Test No. 448
>>>> +#
>>>> +# Regression test for commit:
>>>> +# 46c59736d809 ("xfs: harden directory integrity checks some more")
>>> But I couldn't triger the test failre (kernel crash?) with this commit
>>> reverted, with either v1 nor v2 patch. I was testing with 4.17-rc5 based
>>> kernel, could you please take a look?
>>>
>>>> +#
>>>> +# If a malicious XFS contains a block+ format directory wherein
>>>> +# the directory inode's core.mode is corrupted, and there are
>>>> +# subdirectories of the corrupted directory, an attempt to traverse
>>>> +# up the directory tree by running xfs_scrub will crash the
>>>> +# kernel in __xfs_dir3_data_check.
>>>> +#
>>>> +# Notice:
>>>> +# we should have non fatal asserts configured, because assert
>>>> +# failures triggered by the intentional corrupt would crash system.
>>>> +#
>>>> +#-----------------------------------------------------------------------
>>>> +# Copyright (c) 2018 FUJITSU LIMITED. All Rights Reserved.
>>>> +#
>>>> +# This program is free software; you can redistribute it and/or
>>>> +# modify it under the terms of the GNU General Public License as
>>>> +# published by the Free Software Foundation.
>>>> +#
>>>> +# This program is distributed in the hope that it would be useful,
>>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> +# GNU General Public License for more details.
>>>> +#
>>>> +# You should have received a copy of the GNU General Public License
>>>> +# along with this program; if not, write the Free Software Foundation,
>>>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>>> +#-----------------------------------------------------------------------
>>>> +
>>>> +seq=`basename "$0"`
>>>> +seqres="$RESULT_DIR/$seq"
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +here=`pwd`
>>>> +tmp=/tmp/$$
>>>> +status=1    # failure is the default!
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +	cd /
>>>> +	rm -rf $tmp.*
>>>> +}
>>>> +
>>>> +# get standard environment, filters and checks
>>>> +. ./common/rc
>>>> +. ./common/filter
>>>> +. ./common/populate
>>>> +
>>>> +# real QA test starts here
>>>> +_supported_os Linux
>>>> +_supported_fs xfs
>>>> +_require_scratch_nocheck
>>>> +_require_xfs_io_command "scrub"
>>>> +# Corrupt XFS on purpose, and skip if assert failures would crash system.
>>>> +_require_no_xfs_bug_on_assert
>>>> +
>>>> +rm -f "$seqres.full"
>>>> +
>>>> +# Format and mount
>>>> +_scratch_mkfs | _filter_mkfs>  $seqres.full 2>  $tmp.mkfs || _fail "mkfs failed"
>>>> +_scratch_mount
>>>> +
>>>> +# Get directory block size
>>>> +. $tmp.mkfs
>>>> +
>>>> +# Create a block+(e.g. leaf) format directory
>>>> +__populate_create_dir "${SCRATCH_MNT}/dir_leaf" "$((dirbsize / 12))"
>>>> +
>>>> +# Get the block+ directory inode and a subdirectory inode of it
>>>> +subdino=$(stat -c "%i" "$(find ${SCRATCH_MNT}/dir_leaf/* -type d | head -1)")
>>>> +dino=$(stat -c "%i" "${SCRATCH_MNT}/dir_leaf")
>>>> +
>>>> +# Get the subdirectory's generation number
>>>> +_scratch_unmount
>>>> +subdgen=$(_scratch_xfs_get_metadata_field "core.gen" "inode $subdino")
>>>> +
>>>> +# Corrupt the directory inode's core.mode
>>>> +setmode="0100755"
>>>> +_scratch_xfs_set_metadata_field "core.mode" "$setmode" "inode $dino">>  $seqres.full
>>>> +getmode=$(_scratch_xfs_get_metadata_field "core.mode" "inode $dino")
>>>> +[ "$getmode" != "$setmode" ]&&  _fail "failed to set core.mode"
>>>> +
>>>> +# Scrub parent directory in subdirectory (online)
>>>> +_scratch_mount
>>>> +$XFS_IO_PROG -x -c "scrub parent $subdino $subdgen" ${SCRATCH_MNT}>>  $seqres.full
>>> And I always see "+scrub: Inappropriate ioctl for device" here with this
>>> v2 patch.
>> Your kernel probably needs CONFIG_XFS_ONLINE_SCRUB=y
> Yeah, I didn't have XFS_ONLINE_SCRUB enabled..
>
>> This test probably needs:
>>
>> . ./config/fuzzy
>> _supports_xfs_scrub || _fail "scrub not supported"
>>
>> (or make a _requires_xfs_scrub_enabled helper to encapsulate that?)
> I thought it was already handled by "_require_xfs_io_command 'scrub'",
> (And I think it should be).
>
> I noticed that in _require_xfs_io_command we do
>
> $XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR
>
> which results in:
> [root@fedoravm xfstests]# xfs_io -c "scrub probe 0 " /mnt/scratch/
> No parameters allowed.
>
> but in _supports_xfs_scrub we do
>
> $XFS_IO_PROG -c "scrub probe" "$mountpoint"
>
> which results in:
> [root@fedoravm xfstests]# xfs_io -c "scrub probe " /mnt/scratch/
> scrub: Inappropriate ioctl for device
>
> _require_xfs_io_command should be updated?
Hi Eryu,

Yes, I think we should update _require_xfs_io_command as commit 9d5ea22 
in xfstests.

Thanks,
Xiao Yang
> Thanks,
> Eryu
>> --D
>>
>>> Thanks,
>>> Eryu
>>>
>>>> +
>>>> +echo "Silence is golden"
>>>> +
>>>> +# success, all done
>>>> +status=0
>>>> +exit
>>>> diff --git a/tests/xfs/448.out b/tests/xfs/448.out
>>>> new file mode 100644
>>>> index 0000000..b6f0a53
>>>> --- /dev/null
>>>> +++ b/tests/xfs/448.out
>>>> @@ -0,0 +1,2 @@
>>>> +QA output created by 448
>>>> +Silence is golden
>>>> diff --git a/tests/xfs/group b/tests/xfs/group
>>>> index 51326d9..dd39d08 100644
>>>> --- a/tests/xfs/group
>>>> +++ b/tests/xfs/group
>>>> @@ -445,3 +445,4 @@
>>>>   445 auto quick filestreams
>>>>   446 auto quick
>>>>   447 auto mount
>>>> +448 auto quick fuzzers
>>>> -- 
>>>> 1.8.3.1
>>>>
>>>>
>>>>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> .
>



