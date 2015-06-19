Received: from cn.fujitsu.com ([59.151.112.132]:15391 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753866AbbFSIhg convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 19 Jun 2015 04:37:36 -0400
Message-ID: <5583D4BC.6040509@cn.fujitsu.com>
Date: Fri, 19 Jun 2015 16:37:16 +0800
From: wangyf <wangyf-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic: busy loop of dd and rm test
References: <1433983955-2591-1-git-send-email-wangyf-fnst@cn.fujitsu.com> <20150617214413.GH10224@dastard>
In-Reply-To: <20150617214413.GH10224@dastard>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



=E5=9C=A8 2015=E5=B9=B406=E6=9C=8818=E6=97=A5 05:44, Dave Chinner =E5=86=99=
=E9=81=93:
> On Thu, Jun 11, 2015 at 08:52:35AM +0800, Wang Yanfeng wrote:
>> generic/326 is a case about testing whether writing failed on
>> NO_SPACE in a busy loop of write and delete when disk almost full.
>> It is a long-term problem since very beginning in btrfs, and has been
>> fixed by patchset titled "btrfs: Fix no_space on dd and rm loop" from
>> zhaolei@cn.fujitsu.com.
>>
>> Signed-off-by: Wang Yanfeng <wangyf-fnst@cn.fujitsu.com>
> ....
>> @@ -0,0 +1,73 @@
>> +#! /bin/bash
>> +# FS QA Test No. 326
>> +#
>> +# TEST busy loop of write and delete in a filesystem.
>> +# Sometimes writes will failed on NO_SPACE when disk almost full
>> +# in btrfs. It is long-term problem since very beginning for btrfs
>> +#
>> +# This issue was fixed by the following linux kernel patch
>> +#
>> +# btrfs: Fix no_space on dd and rm loop < from zhaolei@cn.fujitsu.com=
 >
>> +#	btrfs: Fix NO_SPACE bug caused by delayed-iput
>> +#	btrfs: Support busy loop of write and delete
>> +#	btrfs: add WARN_ON() to check is space_info op current
>> +#	btrfs: Set relative data on clear btrfs_block_group_cache->pinned
>> +#	btrfs: Adjust commit-transaction condition to avoid NO_SPACE more
>> +#	btrfs: Fix tail space processing in find_free_dev_extent()
>> +#	btrfs: fix condition of commit transaction
>> +#	btrfs: wait for delayed iputs on no space
> This list of kernel commits does not belong in the test. If you
> really need to put this anywhere, it belongs in the commit
> message.
Maybe we can use the sentence " The issue was fixed by the patchset named
'btrfs: Fix no_space on dd and rm loop'< from zhaolei@cn.fujitsu.com> " =20
to replace it
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +status=3D1
>> +trap "exit \$status" 0 1 2 3 15
> Why did you remove the "tmp=3D/tmp/$$" line from the new test
> template?
o,,,, at first I think I didn't use the tmp dir. I didn't notice it in=20
the new template
I will add it.
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_need_to_be_root
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +rm -f $seqres.full
>> +
>> +dev_size=3D$((512 * 1024 * 1024))
> So a 512MB filesystem...
If we choose a small device, the Bug will be easy to trigger.
In btrfs (other fs I don't know), the required smallest disk space is 256=
MB.
But in this situation,  we can only use about 100MB~ space, and it=20
appears too small,
so double it, I choose 512M as the size of the file system.
>> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
>> +_scratch_mount
>> +file_size_m=3D$(($dev_size * 75 / 100 / 1024 / 1024))
> and a ~400MB file, right? So you don't actually need this
> magic calculation, because:
>
>> +for ((i =3D 0; i < 10; i++)); do
>> +	echo "loop $i" >>$seqres.full
>> +
>> +	dd if=3D/dev/zero of=3D"$SCRATCH_MNT"/file0 bs=3D1M count=3D"$file_s=
ize_m" \
>> +	>>$seqres.full 2>&1 || _fail "dd failed"
> You shouldn't be using dd for this, nor should you be using _fail:
>
> 	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" $SCRATCH_MNT"/file0 | \
> 		_filter_xfs_io | _filter_scratch
>
> If the write fails, then xfs_io will dump an unexpected error
> message to the output, and the golden output mismatch will fail the
> test.
>
>
>> +	rm -f "$SCRATCH_MNT"/file0 || _fail "rm failed"
> Same here - rm will output an error that will be caughti if it
> fails...
Agree, I will make a new patch under your advice.
>
> Cheers,
>
> Dave.

