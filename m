Received: from szxga06-in.huawei.com ([45.249.212.32]:33056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbfB0MqC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Feb 2019 07:46:02 -0500
Subject: Re: [PATCH] generic: test i_mode recovery after power failure
References: <20190226070302.17756-1-yuchao0@huawei.com>
 <CAL3q7H4Xn=ncGQcKKwNBpHBWAUPLt8T8T=RVpmvqA6h83r5tug@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <aa506a05-35ad-c43f-50a0-461f7bc6d7d1@huawei.com>
Date: Wed, 27 Feb 2019 20:45:56 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4Xn=ncGQcKKwNBpHBWAUPLt8T8T=RVpmvqA6h83r5tug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On 2019/2/26 19:02, Filipe Manana wrote:
> On Tue, Feb 26, 2019 at 7:03 AM Chao Yu <yuchao0@huawei.com> wrote:
>>
>> After fsync, filesystem should guarantee inode metadata including
>> permission info being persisted, so even after sudden power-cut,
>> during mount, we should recover i_mode fields correctly, in order
>> to not loss those meta info.
>>
>> So adding this testcase to check whether generic filesystem can
>> guarantee that.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  tests/generic/532     | 106 ++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/532.out |   2 +
>>  tests/generic/group   |   1 +
>>  3 files changed, 109 insertions(+)
>>  create mode 100755 tests/generic/532
>>  create mode 100644 tests/generic/532.out
>>
>> diff --git a/tests/generic/532 b/tests/generic/532
>> new file mode 100755
>> index 000000000000..d89f7ab09fcf
>> --- /dev/null
>> +++ b/tests/generic/532
>> @@ -0,0 +1,106 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 532
>> +#
>> +# This testcase is trying to test recovery flow of generic filesystem,
>> +# w/ below steps, once i_mode changes, after we fsync that file, we can
>> +# expect that i_mode can be recovered after sudden power-cuts.
>> +# 1. touch testfile or mkdir testdir
>> +# 2. chmod 777 testfile/testdir
>> +# 3. sync
>> +# 4. chmod 755 testfile/testdir
>> +# 5. fsync testfile/testdir
>> +# 6. record last i_mode
>> +# 7. godown
>> +# 8. umount
>> +# 9. mount
>> +# 10. check i_mode
>> +#
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1       # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +       cd /
>> +       rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_scratch
>> +_require_scratch_shutdown
> 
> Is the use of the shutdown functionality necessary to trigger the bug on f2fs?

No.

> If not, I'd rather have it use dmflakey so that the test is able to
> run as well on filesystems that don't support shutdown (btrfs for
> example).
> It also feels more natural then relying on a specific feature such as shutdown.

Agreed, let me try to use dmflakey to instead.

> 
>> +
>> +_scratch_mkfs >/dev/null 2>&1
>> +_require_metadata_journaling $SCRATCH_DEV
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +testdir=$SCRATCH_MNT/testdir
>> +
>> +do_check()
>> +{
>> +       target=$1
>> +       is_dir=$2
> 
> Both should be declared as local.
> 
>> +
>> +       _scratch_mount
>> +
>> +       if [ $is_dir = 1 ]; then
>> +               mkdir $target
>> +       else
>> +               touch $target
>> +       fi
>> +
>> +       echo "Test chmod $target" >> $seqres.full
>> +
>> +       chmod 777 $target
>> +       sync
>> +
>> +       chmod 755 $target
>> +       $XFS_IO_PROG $target -c "fsync" | _filter_xfs_io
> 
> No need to use the filter here.
> 
>> +
>> +       before=`stat -c %a $target`
> 
> Should be local as well.
> 
>> +
>> +       _scratch_shutdown | tee -a $seqres.full
>> +       _scratch_cycle_mount
>> +
>> +       after=`stat -c %a $target`
> 
> Local as well.
> 
>> +
>> +       # check inode's i_mode
>> +       if [ "$before" != "$after" ]; then
>> +               echo "Before: $before"
>> +               echo "After : $after"
>> +       fi
>> +       echo "Before: $before" >> $seqres.full
>> +       echo "After : $after" >> $seqres.full
> 
> Seems pointless to dump the values to $seqres.full in case of success.

Will fix them all.

Thanks,

> 
> Thanks.
> 
>> +
>> +       if [ $is_dir = 1 ]; then
>> +               rmdir $target
>> +       else
>> +               rm -f $target
>> +       fi
>> +       _scratch_unmount
>> +}
>> +
>> +echo "Silence is golden"
>> +
>> +do_check $testfile 0
>> +do_check $testdir 1
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/532.out b/tests/generic/532.out
>> new file mode 100644
>> index 000000000000..1f7d4677c3be
>> --- /dev/null
>> +++ b/tests/generic/532.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 532
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 31011ac872c2..2fc50fbbfb5c 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -534,3 +534,4 @@
>>  529 auto quick attr
>>  530 auto quick unlink
>>  531 auto quick unlink
>> +532 shutdown auto quick metadata
>> --
>> 2.18.0.rc1
>>
> 
> 
