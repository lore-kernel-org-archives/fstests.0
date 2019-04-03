Received: from mx2.suse.de ([195.135.220.15]:57558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDCNTO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 3 Apr 2019 09:19:14 -0400
From: Luis Henriques <lhenriques@suse.com>
Subject: Re: [RFC PATCH 2/2] ceph: test basic ceph.quota.max_bytes quota
References: <20190402103428.21435-1-lhenriques@suse.com>
        <20190402103428.21435-3-lhenriques@suse.com>
        <20190402210931.GV23020@dastard> <87d0m3e81f.fsf@suse.com>
        <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com>
Date: Wed, 03 Apr 2019 14:19:11 +0100
In-Reply-To: <d38a4d84-8df2-984e-cf1c-045d85644796@suse.com> (Nikolay
        Borisov's message of "Wed, 3 Apr 2019 15:17:23 +0300")
Message-ID: <874l7fdy5s.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Nikolay Borisov <nborisov@suse.com> writes:

> On 3.04.19 =D0=B3. 12:45 =D1=87., Luis Henriques wrote:
>> Dave Chinner <david@fromorbit.com> writes:
>>=20
>>> On Tue, Apr 02, 2019 at 11:34:28AM +0100, Luis Henriques wrote:
>>>> Simple set of checks for CephFS max_bytes directory quota implementa=
tion.
>>>>
>>>> Signed-off-by: Luis Henriques <lhenriques@suse.com>
>>>> ---
>>>>  tests/ceph/002     | 147 ++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>  tests/ceph/002.out |   1 +
>>>>  tests/ceph/group   |   1 +
>>>>  3 files changed, 149 insertions(+)
>>>>  create mode 100755 tests/ceph/002
>>>>  create mode 100644 tests/ceph/002.out
>>>>
>>>> diff --git a/tests/ceph/002 b/tests/ceph/002
>>>> new file mode 100755
>>>> index 000000000000..313865dc639e
>>>> --- /dev/null
>>>> +++ b/tests/ceph/002
>>>> @@ -0,0 +1,147 @@
>>>> +#! /bin/bash
>>>> +# SPDX-License-Identifier: GPL-2.0
>>>> +# Copyright (c) 2019 SUSE LLC. All Rights Reserved.
>>>> +#
>>>> +# FS QA Test No. 002
>>>> +#
>>>> +# This tests basic ceph.quota.max_bytes quota features.
>>>> +#
>>>> +
>>>> +seq=3D`basename $0`
>>>> +seqres=3D$RESULT_DIR/$seq
>>>> +echo "QA output created by $seq"
>>>> +
>>>> +testdir=3D$TEST_DIR/quota-test
>>>
>>> Try not to name local variables the same as when known global
>>> variables. When we talk about "test dir", we mean the mount point
>>> for the test device, not the local, tests specific work directory.
>>>  i.e. this is a "work dir", not a "test dir".
>>>
>>> And, often, we just name them after the test that is running,
>>> so we can identify what test left them behind. i.e.
>>>
>>> workdir=3D$TEST_DIR/$seq
>>>
>>>> +
>>>> +tmp=3D/tmp/$$
>>>> +status=3D1    # failure is the default!
>>>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>>>> +
>>>> +_cleanup()
>>>> +{
>>>> +	cd /
>>>> +	rm -rf $tmp.*
>>>> +	rm -rf $testdir
>>>
>>> Leave it behind for post-mortem analysis if necessary, remove it
>>> before starting this test execution....
>>>
>>>> +}
>>>> +
>>>> +# get standard environment, filters and checks
>>>> +. ./common/rc
>>>> +. ./common/filter
>>>> +. ./common/attr
>>>> +
>>>> +# real QA test starts here
>>>> +_supported_os Linux
>>>> +_supported_fs ceph
>>>> +
>>>> +_require_attrs
>>>> +
>>>> +set_quota()
>>>> +{
>>>> +	val=3D$1
>>>> +	dir=3D$2
>>>> +	$SETFATTR_PROG -n ceph.quota.max_bytes -v $val $dir >/dev/null 2>&=
1
>>>> +}
>>>> +
>>>> +get_quota()
>>>> +{
>>>> +	dir=3D$1
>>>> +	$GETFATTR_PROG --only-values -n ceph.quota.max_bytes $dir 2> /dev/=
null
>>>> +}
>>>> +
>>>> +# function to write a file.  We use a loop because quotas in CephFS=
 is a
>>>> +# "best-effort" implementation, i.e. a write may actually be allowe=
d even if the
>>>> +# quota is being exceeded.  Using a loop reduces the chances of thi=
s to happen.
>>>> +#
>>>> +# NOTE: 'size' parameter is in M
>>>
>>> xfs_io accepts "1m" as one megabyte.
>>>
>>>> +write_file()
>>>> +{
>>>> +	file=3D$1
>>>> +	size=3D$2 # size in M
>>>> +	for (( i =3D 1; i < $size; i++ )); do
>>>> +		$XFS_IO_PROG -f -c "pwrite -W $((i * 1048576)) 1048576" \
>>>> +			     $file >/dev/null 2>&1
>>>> +	done
>>>> +}
>>>
>>> Makes no sense to me. xfs_io does a write() loop internally with
>>> this pwrite command of 4kB writes - the default buffer size. If you
>>> want xfs_io to loop doing 1MB sized pwrite() calls, then all you
>>> need is this:
>>>
>>> 	$XFS_IO_PROG -f -c "pwrite -w -B 1m 0 ${size}m" $file | _filter_xfs_=
io
>>>
>>=20
>> Thank you for your review, Dave.  I'll make sure the next revision of
>> these tests will include all your comments implemented... except for
>> this one.
>>=20
>> The reason I'm using a loop for writing a file is due to the nature of
>> the (very!) loose definition of quotas in CephFS.  Basically, clients
>> will likely write some amount of data over the configured limit becaus=
e
>> the servers they are communicating with to write the data (the OSDs)
>> have no idea about the concept of quotas (or files even); the filesyst=
em
>> view in the cluster is managed at a different level, with the help of
>> the MDS and the client itself.
>>=20
>> So, the loop in this function is simply to allow the metadata associat=
ed
>> with the file to be updated while we're writing the file.  If I use a
>
> But the metadata will be modified while writing the file even with a
> single invocation of xfs_io.

No, that's not true.  It would be too expensive to keep the metadata
server updated while writing to a file.  So, making sure there's
actually an open/close to the file (plus the fsync in pwrite) helps
making sure the metadata is flushed into the MDS.

(And yes I _did_ tried to use xfs_io with the 1m loop and the test fails
because it simply writes all the data and gets no EDQUOT error.)

Cheers,
--=20
Luis

> It's just that you are moving the loop inside xfs_io rather than
> having to invoke xfs_io a lot of time. Also, just because you are
> using a single -c "pwrite" command doesn't mean this will translate to
> a single call to pwrite. As Dave mentioned, the default block size is
> 4k meaning :
>
> "pwrite -w -B 1m 0 ${size}m"
>
> will result in 'size / 1m' writes of size 1m, each being a distinct cal=
l
> to pwrite.
>
>> single pwrite, the whole file will be written before we get a -EDQUOT.
>>=20
>> If an admin wants to really enforce some hard quotas in the filesystem=
,
>> there are other means to do that, but not at the filesystem level.
>> There are some more details on the quota implementation in Ceph here:
>>=20
>>   http://docs.ceph.com/docs/master/cephfs/quota/
>>=20
>> I hope this makes sense and helps understanding why I need a loop to b=
e
>> used in this test.
>>=20
>> Cheers
>>=20
