Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbeJGVA0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Oct 2018 17:00:26 -0400
Subject: Re: [PATCH 1/3] generic: test project id recovery after power failure
References: <20181004043502.15005-1-chao@kernel.org>
 <20181007133838.GM17817@desktop>
From: Chao Yu <chao@kernel.org>
Message-ID: <b592aa2a-82cb-ebe6-29ed-d09d007a52ad@kernel.org>
Date: Sun, 7 Oct 2018 21:53:03 +0800
MIME-Version: 1.0
In-Reply-To: <20181007133838.GM17817@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

Will update them in v2 soon as you suggested.

Thanks,

On 2018-10-7 21:38, Eryu Guan wrote:
> On Thu, Oct 04, 2018 at 12:35:00PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> After fsync, filesystem should guarantee inode metadata including
>> project id being persisted, so even after sudden power-cut, during
>> mount, we should recover project_id fields correctly, in order to
>> not loss those meta info.
>>
>> So adding this testcase to check whether generic filesystem can
>> guarantee that.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  tests/generic/506     | 97 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/506.out |  2 +
>>  tests/generic/group   |  1 +
>>  3 files changed, 100 insertions(+)
>>  create mode 100644 tests/generic/506
>>  create mode 100644 tests/generic/506.out
>>
>> diff --git a/tests/generic/506 b/tests/generic/506
>> new file mode 100644
>> index 00000000..ca035a91
>> --- /dev/null
>> +++ b/tests/generic/506
>> @@ -0,0 +1,97 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 Huawei.  All Rights Reserved.
>> +#
>> +# FS QA Test 506
>> +#
>> +# This testcase is trying to test recovery flow of generic filesystem, w/ below
>> +# steps, once project id changes, after we fsync that file, we can expect that
>> +# project id can be recovered after sudden power-cuts.
>> +# 1. touch testfile;
>> +# 1.1 sync (optional)
>> +# 2. chattr -p 100 testfile;
>> +# 3. xfs_io -f testfile -c "fsync";
>> +# 4. godown;
>> +# 5. umount;
>> +# 6. mount;
>> +# 7. check project id
>> +#
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
>> +. ./common/quota
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +
>> +_require_test_lsattr
>> +_require_command "$CHATTR_PROG" chattr
> 
> Better to add a new "LSATTR_PROG" entry as well in common/config and
> _require_command "$LSATTR_PROG" lsattr
> 
>> +
>> +_require_prjquota $SCRATCH_DEV
>> +_require_scratch
>> +_require_scratch_shutdown
>> +
>> +_scratch_mkfs >/dev/null 2>&1
>> +_require_metadata_journaling $SCRATCH_DEV
>> +
>> +testfile=$SCRATCH_MNT/testfile
>> +
>> +do_check()
>> +{
>> +	_scratch_mount
>> +
>> +	touch $testfile
>> +
>> +	if [ "$1" == "sync" ]; then
>> +		sync
>> +	fi
>> +
>> +	chattr -p 100 $testfile
> 
> And use $CHATTR_PROG
> 
>> +
>> +	before=`lsattr -p $testfile`
> 
> and $LSATTR_PROG in the test.
> 
>> +
>> +	$XFS_IO_PROG -f $testfile -c "fsync" | _filter_xfs_io
>> +
>> +	_scratch_shutdown | tee -a $seqres.full
>> +	_scratch_cycle_mount
>> +
>> +	after=`lsattr -p $testfile`
>> +
>> +	# check inode's uid/gid
> 
> Should be "project quota id"?
> 
>> +	if [ "$before" != "$after" ]; then
>> +		echo "Before: $before"
>> +		echo "After : $after"
>> +	fi
>> +	echo "Before: $before" >> $seqres.full
>> +	echo "After : $after" >> $seqres.full
>> +
>> +	rm $testfile
> 
> rm -f $testfile
> 
> Thanks,
> Eryu
> 
>> +	_scratch_unmount
>> +}
>> +
>> +echo "Silence is golden"
>> +
>> +do_check
>> +do_check sync
>> +
>> +status=0
>> +exit
>> diff --git a/tests/generic/506.out b/tests/generic/506.out
>> new file mode 100644
>> index 00000000..cb46b201
>> --- /dev/null
>> +++ b/tests/generic/506.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 506
>> +Silence is golden
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 4da0e188..c7d42ff9 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -508,3 +508,4 @@
>>  503 auto quick dax punch collapse zero
>>  504 auto quick locks
>>  505 shutdown auto quick metadata
>> +506 shutdown auto quick metadata quota
>> -- 
>> 2.18.0
>>
