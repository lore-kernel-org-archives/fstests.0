Received: from cn.fujitsu.com ([59.151.112.132]:56365 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753137AbcKBK3i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Nov 2016 06:29:38 -0400
Subject: Re: [PATCH] generic: create and delete files repeatedly to exercise
 ENOSPC behaviour
References: <1477999170-20026-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20161101122613.GR27776@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <5819BE82.10205@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 18:22:58 +0800
MIME-Version: 1.0
In-Reply-To: <20161101122613.GR27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hi Eryu,

There has already be a generic/102 doing this test...
Thanks for you kindly review and sorry for wasting your time.

Regards,
Xiaoguang Wang

On 11/01/2016 08:26 PM, Eryu Guan wrote:
> On Tue, Nov 01, 2016 at 07:19:30PM +0800, Wang Xiaoguang wrote:
>> In btrfs, sometimes though the number of created files' consumed disk space
>> are not larger than fs's free space, we can still get some ENOSPC error, it
>> may be that btrfs does not try hard to reclaim disk space(I have sent kernel
>> patch to resolve this kind of enospc error. Note, this false enospc error
>> will not always happen even in kernel without my fixing patch).
>>
>> Currently only in btrfs, I get this ENOSPC error, xfs and ext4 work well.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/389     | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/generic/389.out |  2 ++
>>   tests/generic/group   |  1 +
>>   3 files changed, 81 insertions(+)
>>   create mode 100755 tests/generic/389
>>   create mode 100644 tests/generic/389.out
>>
>> diff --git a/tests/generic/389 b/tests/generic/389
>> new file mode 100755
>> index 0000000..96bc12e
>> --- /dev/null
>> +++ b/tests/generic/389
>> @@ -0,0 +1,78 @@
>> +#! /bin/bash
>> +# FS QA Test 389
>> +#
>> +# Create and delete files repeatedly to exercise ENOSPC behaviour.
> Trailing whitespace in this line.
>
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
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
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +RUN_TIME=$((600 * $TIME_FACTOR))
> Hmm, does it really need 600s to run? I think it's better to limit the
> runtime within 300s and make it an 'auto' test. I, personally, prefer a
> "loop count" based test, I'd find out a minimum loop count that could
> reproduce the ENOSPC problem more reliably on btrfs (for example, say
> 75%) and make the count scale with LOAD_FACTOR.
>
>> +fs_size=$((15 * 1024 * 1024 * 1024))
> And does it really need 15G on SCRATCH_DEV? A smaller fs size makes test
> run faster, and gives the test more chance to be run, because not
> everyone has a 15G SCRATCH_DEV.
>
>> +_scratch_mkfs_sized $fs_size > $seqres.full 2>&1
>> +_scratch_mount > $seqres.full 2>&1
> Append to $seqres.full not overwrite.
>
>> +
>> +testfile1=$SCRATCH_MNT/testfile1
>> +testfile2=$SCRATCH_MNT/testfile2
>> +filesize1=$(((fs_size * 80) / 100))
>> +filesize2=$(((fs_size * 5) / 100))
> Better to have some comments on the filesizes chosen here. e.g. someone
> may wonder that why it's testing ENOSPC condition with 85% full, not 99%
> or 100%.
>
>> +
>> +do_test()
>> +{
>> +	while [ -f $SCRATCH_MNT/run ]; do
>> +		$XFS_IO_PROG -fc "pwrite 0 $filesize1" $testfile1 > /dev/null
>> +		$XFS_IO_PROG -fc "pwrite 0 $filesize2" $testfile2 > /dev/null
>> +		rm -f $testfile1 $testfile2
> Trailing whitespace here.
>
>> +	done
>> +}
>> +
>> +echo "Silence is golden"
>> +touch $SCRATCH_MNT/run
>> +do_test &
>> +sleep $RUN_TIME
>> +rm -f $SCRATCH_MNT/run
>> +wait
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/389.out b/tests/generic/389.out
>> new file mode 100644
>> index 0000000..e8c24bb
>> --- /dev/null
>> +++ b/tests/generic/389.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 389
>> +Silence is golden
> Can you please rebase on top of current master? generic/389 is already
> taken, and it makes applying & testing the patch a litter harder :)
>
>> diff --git a/tests/generic/group b/tests/generic/group
>> index fc32cfd..b6d4013 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -391,3 +391,4 @@
>>   386 auto quick quota
>>   387 auto clone
>>   388 auto log metadata
>> +389 enospc
> Perhaps we can add it to 'rw' group too.
>
> Thanks,
> Eryu
>
>



