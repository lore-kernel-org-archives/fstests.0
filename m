Received: from mail.cn.fujitsu.com ([183.91.158.132]:8256 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935694AbeEYGdm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 May 2018 02:33:42 -0400
Message-ID: <5B07AE42.2010808@cn.fujitsu.com>
Date: Fri, 25 May 2018 14:33:38 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs: Regression test for vulnerable directory integrity
 check
References: <1527154332-13234-1-git-send-email-yangx.jy@cn.fujitsu.com> <20180525043732.GL12940@magnolia>
In-Reply-To: <20180525043732.GL12940@magnolia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

On 2018/05/25 12:37, Darrick J. Wong wrote:
> On Thu, May 24, 2018 at 05:32:12PM +0800, Xiao Yang wrote:
>> If a malicious XFS contains a block+ format directory wherein the
>> directory inode's core.mode is corrupted, and there are subdirectories
>> of the corrupted directory, an attempt to traverse up the directory
>> tree by running xfs_scrub will crash the kernel in __xfs_dir3_data_check.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/448     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/xfs/448.out |  2 ++
>>   tests/xfs/group   |  1 +
>>   3 files changed, 93 insertions(+)
>>   create mode 100755 tests/xfs/448
>>   create mode 100644 tests/xfs/448.out
>>
>> diff --git a/tests/xfs/448 b/tests/xfs/448
>> new file mode 100755
>> index 0000000..bc151a4
>> --- /dev/null
>> +++ b/tests/xfs/448
>> @@ -0,0 +1,90 @@
>> +#! /bin/bash
>> +# FS QA Test No. 448
>> +#
>> +# Regression test for commit:
>> +# 46c5973 ("xfs: harden directory integrity checks some more")
>> +#
>> +# If a malicious XFS contains a block+ format directory wherein
>> +# the directory inode's core.mode is corrupted, and there are
>> +# subdirectories of the corrupted directory, an attempt to traverse
>> +# up the directory tree by running xfs_scrub will crash the
>> +# kernel in __xfs_dir3_data_check.
>> +#
>> +# Notice:
>> +# we should have non fatal asserts configured, because assert
>> +# failures triggered by the intentional corrupt would crash system.
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2018 FUJITSU.  All Rights Reserved.
>> +# Author: Xiao Yang<yangx.jy@cn.fujitsu.com>
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
>> +
>> +seq=`basename "$0"`
>> +seqres="$RESULT_DIR/$seq"
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1    # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	rm -rf $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/populate
>> +. ./common/fuzzy
>> +
>> +# real QA test starts here
>> +_supported_os Linux
>> +_supported_fs xfs
>> +_require_scratch
>> +_require_scrub
>> +_require_scratch_nocheck
>> +# Corrupt XFS on purpose, and skip if assert failures would crash system.
>> +_require_no_xfs_bug_on_assert
>> +
>> +rm -f "$seqres.full"
>> +
>> +# Format and mount
>> +_scratch_mkfs>  $seqres.full 2>&1 || _fail "mkfs failed"
>> +_scratch_mount
>> +
>> +# Create a block+(e.g. leaf) format directory
>> +dblksz="$(xfs_info "${SCRATCH_MNT}" | grep naming.*bsize | sed -e 's/^.*bsize=//g' -e 's/\([0-9]*\).*$/\1/g')"
>> +__populate_create_dir "${SCRATCH_MNT}/dir_leaf" "$((dblksz / 12))"
>> +dino=$(stat -c "%i" "${SCRATCH_MNT}/dir_leaf")
>> +
>> +# Corrupt the directory inode's core.mode
>> +_scratch_unmount
>> +setmode="0100755"
>> +_scratch_xfs_set_metadata_field "core.mode" "$setmode" "inode $dino">>  $seqres.full
>> +getmode=$(_scratch_xfs_get_metadata_field "core.mode" "inode $dino")
>> +[ "$getmode" != "$setmode" ]&&  _notrun "failed to set core.mode"
> When does the set fail?  And isn't that a _fail()ure?
Hi Darrick,

The set never failed on my enviroment, and i just ensure set succeeded.
Do you want to remove the check?
>> +
>> +# Check a mounted XFS (online)
>> +_scratch_mount
>> +$XFS_SCRUB_PROG -d -T -v -n $SCRATCH_MNT>>  $seqres.full 2>&1
> I don't think you want to rely on xfs_scrub at this point if you can
> avoid it--scrub is totally experimental and can be deconfigured from the
> kernel.  Can you poke the directory using regular commands (like ls) to
> trigger the assert?
I tried and failed to trigger the assert by some regular commands(ls, 
stat, etc.).
If you have some ideas, could you tell me how to trigger the assert by 
using regular commands?

Thanks,
Xiao Yang
> --D
>
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/xfs/448.out b/tests/xfs/448.out
>> new file mode 100644
>> index 0000000..b6f0a53
>> --- /dev/null
>> +++ b/tests/xfs/448.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 448
>> +Silence is golden
>> diff --git a/tests/xfs/group b/tests/xfs/group
>> index 51326d9..dd39d08 100644
>> --- a/tests/xfs/group
>> +++ b/tests/xfs/group
>> @@ -445,3 +445,4 @@
>>   445 auto quick filestreams
>>   446 auto quick
>>   447 auto mount
>> +448 auto quick fuzzers
>> -- 
>> 1.8.3.1
>>
>>
>>
>
> .
>



