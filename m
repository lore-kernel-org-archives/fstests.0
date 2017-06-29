Received: from cn.fujitsu.com ([59.151.112.132]:26206 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdF2EBe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Jun 2017 00:01:34 -0400
Message-ID: <59547B95.9000905@cn.fujitsu.com>
Date: Thu, 29 Jun 2017 12:01:25 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs: test a race between dio reads and mapped writes
References: <1498554232-20777-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170628101329.GH23360@eguan.usersys.redhat.com>
In-Reply-To: <20170628101329.GH23360@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/06/28 18:13, Eryu Guan wrote:
> On Tue, Jun 27, 2017 at 05:03:52PM +0800, Xiao Yang wrote:
>> This regression test reproduces a race between a direct
>> I/O read and a mapped write to a hole in a file.  If the
>> race occurs, it will trigger a BUG_ON().  This XFS bug
>> has been fixed by:
>>
>> 04197b3 (xfs: don't BUG() on mixed direct and mapped I/O)
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/422     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/xfs/422.out |  2 ++
>>   tests/xfs/group   |  1 +
>>   3 files changed, 89 insertions(+)
>>   create mode 100755 tests/xfs/422
>>   create mode 100644 tests/xfs/422.out
>>
>> diff --git a/tests/xfs/422 b/tests/xfs/422
>> new file mode 100755
>> index 0000000..a57ffab
>> --- /dev/null
>> +++ b/tests/xfs/422
>> @@ -0,0 +1,86 @@
>> +#! /bin/bash
>> +# FS QA Test No. 422
>> +#
>> +# Regression test for commit:
>> +# 04197b3 ("xfs: don't BUG() on mixed direct and mapped I/O)
>               ^^ missing ending " :)
>> +#
>> +# This case tests a race between a direct I/O read and a
>> +# mapped write to a hole in a file.  If the race occurs,
>> +# it will trigger a BUG_ON().
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2017 Fujitsu.  All Rights Reserved.
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
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
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
>> +# get standard environment and checks
>> +. ./common/rc
>> +
>> +# real QA test starts here
>> +_supported_os Linux
>> +_supported_fs xfs
> I see nothing xfs specific in this test, I think it can be made generic
> easily.
Hi Eryu,

Agreed.  It could be moved into generic.
>> +_require_scratch
>> +_disable_dmesg_check
> Better to add comments on ignoring dmesg check result.
For xfs filesystem, this race triggers various warnings on some 
distributions(RHEL7) and upstream kernel.
e.g,
1) This race triggers the following warnings on RHEL7.3GA
-----------------------------------------------------------------------------------------------------------------------------
[    0.297084] WARNING: at arch/x86/mm/ioremap.c:101 
__ioremap_caller+0x238/0x320()
[  648.745481] WARNING: at fs/xfs/xfs_aops.c:1244 
xfs_vm_releasepage+0xcb/0x100 [xfs]()
[  648.745694] WARNING: at fs/xfs/xfs_file.c:377 
xfs_file_aio_read+0x2dd/0x340 [xfs]()
-----------------------------------------------------------------------------------------------------------------------------
2) It triggers the following warnings on RHEL7.4Beta
----------------------------------------------------------------------------------------------------------------------------
[  497.575319] WARNING: CPU: 0 PID: 26865 at fs/xfs/xfs_file.c:361 
xfs_file_dio_aio_read+0x1ba/0x2a0 [xfs]
[  497.577651] WARNING: CPU: 0 PID: 26865 at fs/xfs/xfs_aops.c:1285 
__xfs_get_blocks+0x8ca/0x8e0 [xfs]
----------------------------------------------------------------------------------------------------------------------------
3) It triggers the following warnings on upstream kernel
----------------------------------------------------------------------------------------------------------------------------
[   57.946882] WARNING: CPU: 1 PID: 4053 at fs/iomap.c:890 
iomap_dio_rw+0x37a/0x390
[   57.947066] WARNING: CPU: 1 PID: 4053 at fs/iomap.c:766 
iomap_dio_actor+0xca/0x370
----------------------------------------------------------------------------------------------------------------------------

It focus on the oops due to this race, and the warnings are different 
based on different kernel.
So we may ignore dmesg check.

I will add comments on ignoring dmesg check result as you said.

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>> +_require_xfs_io_command "truncate"
>> +_require_xfs_io_command "fpunch"
>> +
>> +rm -f $seqres.full
>> +
>> +# format and mount
>> +_scratch_mkfs>  $seqres.full 2>&1
>> +_scratch_mount>>  $seqres.full 2>&1
>> +
>> +filesz=$((65536 * 2))
>> +
>> +# create a test file with a hole
>> +$XFS_IO_PROG -f -c "truncate $((filesz * 2))" $SCRATCH_MNT/file>>  $seqres.full
>> +
>> +# run a background dio read to a hole in a loop
>> +while true; do
>> +	$XFS_IO_PROG -d -c "pread 0 $filesz" $SCRATCH_MNT/file>  /dev/null 2>&1
>> +done&
>> +
>> +dread_pid=$!
>> +
>> +# run mapped write to the same hole as dio read
>> +for i in `seq 0 999`; do
>> +	$XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file \
>> +		>  /dev/null
>> +	$XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file>  /dev/null
>> +done
>> +
>> +kill -9 $dread_pid>  /dev/null 2>&1
>> +wait $dread_pid>  /dev/null 2>&1
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/xfs/422.out b/tests/xfs/422.out
>> new file mode 100644
>> index 0000000..f70693f
>> --- /dev/null
>> +++ b/tests/xfs/422.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 422
>> +Silence is golden
>> diff --git a/tests/xfs/group b/tests/xfs/group
>> index 2a3b950..f43ffcf 100644
>> --- a/tests/xfs/group
>> +++ b/tests/xfs/group
>> @@ -419,3 +419,4 @@
>>   419 auto quick
>>   420 auto quick clone dedupe
>>   421 auto quick clone dedupe
>> +422 auto quick dangerous
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>



