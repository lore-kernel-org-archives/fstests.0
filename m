Received: from synology.com ([59.124.61.242]:50489 "EHLO synology.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbcKBDlJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Nov 2016 23:41:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 02 Nov 2016 11:40:55 +0800
From: robbieko <robbieko@synology.com>
Subject: Re: [PATCH v2 1/4] xfstests: btrfs/131: add test for an incremental
 send with name collision
In-Reply-To: <20161101071758.GP27776@eguan.usersys.redhat.com>
References: <1477619046-16375-1-git-send-email-robbieko@synology.com>
 <1477619046-16375-2-git-send-email-robbieko@synology.com>
 <20161101071758.GP27776@eguan.usersys.redhat.com>
Message-ID: <41b2f096d9ef1424263b0a2a063baf4f@synology.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu Guan,

OK, I will modify it.

Thanks.
Robbie Ko

Eryu Guan =E6=96=BC 2016-11-01 15:17 =E5=AF=AB=E5=88=B0:
> On Fri, Oct 28, 2016 at 09:44:03AM +0800, robbieko wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>=20
>> Test that an incremental send operation doesn't work because
>> there's a name collision in the destination and it's not checked
>> corretly before the rename operation applies.
>>=20
>> This test exercises scenarios used to fail in btrfs and are fixed by
>> the following patch for the linux kernel:
>>=20
>> "Btrfs: incremental send, do not skip generation inconsistency check=20
>> for inode 256."
>>=20
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>=20
> Sorry for the late review!
>=20
>> ---
>>  tests/btrfs/131     | 111=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/btrfs/131.out |   2 +
>>  tests/btrfs/group   |   1 +
>>  3 files changed, 114 insertions(+)
>>  create mode 100755 tests/btrfs/131
>>  create mode 100644 tests/btrfs/131.out
>>=20
>> diff --git a/tests/btrfs/131 b/tests/btrfs/131
>> new file mode 100755
>> index 0000000..2e2e0bc
>> --- /dev/null
>> +++ b/tests/btrfs/131
>> @@ -0,0 +1,111 @@
>> +#! /bin/bash
>> +# FS QA Test No. btrfs/131
>> +#
>> +# Test that an incremental send operation doesn't work because
>> +# there's a name collision in the destination and it's not checked
>> +# corretly before the rename operation applies.
>> +#
>> +#--------------------------------------------------------------------=
---
>> +# Copyright (C) 2016 Synology Inc. All Rights Reserved.
>> +# Author: Robbie Ko <robbieko@synology.com>
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
>> +# along with this program; if not, write the Free Software=20
>> Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#--------------------------------------------------------------------=
---
>> +#
>> +
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -fr $send_files_dir
>> +	rm -f $tmp.*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_test
>> +_require_scratch
>> +_require_fssum
>> +
>> +send_files_dir=3D$TEST_DIR/btrfs-test-$seq
>> +
>> +rm -f $seqres.full
>> +rm -fr $send_files_dir
>> +mkdir $send_files_dir
>> +
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_scratch_mount
>> +
>> +mkdir $SCRATCH_MNT/a1
>> +mkdir $SCRATCH_MNT/a2
>> +
>> +# Filesystem looks like:
>> +#
>> +# .                                                             (ino=20
>> 256)
>> +# |--- a1/                                                      (ino=20
>> 257)
>> +# |
>> +# |--- a2/                                                      (ino=20
>> 258)
>> +#
>> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT=20
>> $SCRATCH_MNT/mysnap1
>> +
>> +_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f=20
>> $send_files_dir/1.snap
>=20
> I found these "run_check" based helpers make the result harder to read
> when test failed, I can't see immediate error messages from the diff
> output but have to open $seqres.full file to see the details.
>=20
> Can you please use $BTRFS_UTIL_PROG directly, in all these four tests?
> One concern about using bare $BTRFS_UTIL_PROG is that output messages=20
> of
> btrfs command are always changed. But I think, at least, we can ignore
> the stdout and capture the stderr only. e.g.
>=20
> $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> 	$SCRATCH_MNT/mysnap1 >/dev/null
>=20
> So if everything works fine no output can be seen, but if snapshot
> creation is failed, we can see error messages from stderr, which could
> fail the test.
>=20
>> +
>> +_scratch_unmount
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_scratch_mount
>> +touch $SCRATCH_MNT/a2
>> +
>> +# Filesystem now looks like:
>> +#
>> +# .                                                             (ino=20
>> 256)
>> +# |--- a2                                                       (ino=20
>> 257)
>> +#
>> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT=20
>> $SCRATCH_MNT/mysnap2
>> +
>> +_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
>> +rm $send_files_dir/1.snap
>> +
>> +run_check $FSSUM_PROG -A -f -w $send_files_dir/1.fssum=20
>> $SCRATCH_MNT/mysnap1
>> +run_check $FSSUM_PROG -A -f -w $send_files_dir/2.fssum=20
>> $SCRATCH_MNT/mysnap2
>=20
> And this "run_check" is not necessary either. Just run $FSSUM_PROG
> directly and let it print "OK", and match it in .out file.
>=20
> Thanks,
> Eryu
>=20
>> +
>> +_run_btrfs_util_prog send $SCRATCH_MNT/mysnap1 -f=20
>> $send_files_dir/1.snap
>> +_run_btrfs_util_prog send -p $SCRATCH_MNT/mysnap1=20
>> $SCRATCH_MNT/mysnap2 \
>> +	-f $send_files_dir/2.snap
>> +
>> +# Now recreate the filesystem by receiving both send streams and=20
>> verify we get
>> +# the same content that the original filesystem had.
>> +_scratch_unmount
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_scratch_mount
>> +
>> +_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/1.snap
>> +run_check $FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
>> +_run_btrfs_util_prog receive $SCRATCH_MNT -f $send_files_dir/2.snap
>> +run_check $FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
>> +
>> +echo "Silence is golden"
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
>> new file mode 100644
>> index 0000000..d118ca9
>> --- /dev/null
>> +++ b/tests/btrfs/131.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 131
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index f3a7a4f..a7a070a 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -133,3 +133,4 @@
>>  128 auto quick send
>>  129 auto quick send
>>  130 auto clone send
>> +131 auto quick send
>> --
>> 1.9.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



