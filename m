Received: from mx2.suse.de ([195.135.220.15]:51154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbfIZIYn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Sep 2019 04:24:43 -0400
Subject: Re: [PATCH] btrfs: Add regression test for SINGLE profile conversion
References: <20190926072635.9310-1-nborisov@suse.com>
 <20190926081230.GX2622@desktop>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <f1bb82c4-f1e3-d0f0-35f6-89f2d7d0d221@suse.com>
Date: Thu, 26 Sep 2019 11:24:38 +0300
MIME-Version: 1.0
In-Reply-To: <20190926081230.GX2622@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: WenRuo Qu <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 26.09.19 =D0=B3. 11:12 =D1=87., Eryu Guan wrote:
> On Thu, Sep 26, 2019 at 10:26:35AM +0300, Nikolay Borisov wrote:
>> This is a regression test for the bug fixed by
>> 'btrfs: Fix a regression which we can't convert to SINGLE profile'
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>  tests/btrfs/194.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 55 insertions(+)
>>  create mode 100755 tests/btrfs/194
>>  create mode 100644 tests/btrfs/194.out
>>
>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>> new file mode 100755
>> index 000000000000..8935defd3f5e
>> --- /dev/null
>> +++ b/tests/btrfs/194
>> @@ -0,0 +1,52 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 194
>> +#
>> +# Test that block groups profile can be converted to SINGLE. This is =
a regression
>> +# test for 'btrfs: Fix a regression which we can't convert to SINGLE =
profile'
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
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
>> +# real QA test starts here
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 2
>> +
>> +_scratch_dev_pool_get 2
>> +_scratch_pool_mkfs -draid1
>> +
>> +_scratch_mount=20
>> +
>> +$BTRFS_UTIL_PROG balance start -dconvert=3Dsingle $SCRATCH_MNT > $seq=
res.full 2>&1
>> +[ $? -eq 0 ] || _fail "Convert failed"
>=20
> This indicates we're missing profile conversion tests in fstests. I
> think it's better to add a test framework/helpers and a full set of
> profile conversion tests instead of this raid1->single special case.

It's not important to be raid1, the important bit here is any profile to
single. As this is a specific, targeted test. But I do agree that having
a conversion test will be a more robust, long-term solution. Will work
on that.

>=20
> e.g.
>=20
> Define a test case array, which describes what's the src/dst of this
> conversion and how many devices this case requires, e.g.
>=20
> test_cases=3D(
>         # $nr_dev_min:$metadata:$data:$metadata_convert:$data_convert
>         "2:single:single:raid0:raid0"
>         "2:single:single:raid1:raid1"
>         "2:single:single:raid1:raid0"
>         "3:single:single:raid5:raid5"
>         "4:single:single:raid6:raid6"
>         "4:single:single:raid10:raid10"
>         "2:raid0:raid0:raid1:raid0"
>         "2:raid0:raid0:raid1:raid1"
>         "3:raid0:raid0:raid5:raid5"
>         "4:raid0:raid0:raid6:raid6"
>         "4:raid0:raid0:raid10:raid10"
>         "2:raid1:raid0:raid1:raid1"
>         "3:raid1:raid0:raid5:raid5"
>         "4:raid1:raid0:raid6:raid6"
>         "4:raid1:raid1:raid10:raid10"
>         "4:raid5:raid5:raid1:raid1"
>         "4:raid5:raid5:raid6:raid6"
>         "4:raid5:raid5:raid10:raid10"
>         "4:raid6:raid6:raid1:raid1"
>         "4:raid6:raid6:raid5:raid5"
>         "4:raid6:raid6:raid10:raid10"
>         "4:raid10:raid10:raid5:raid5"
>         "4:raid10:raid10:raid6:raid6"
> 	<adding more cases>
> )
>=20
> Then, create btrfs in source profile and populate fs with different
> kinds of files, compute sha1 digests of these files(fssum?), start
> conversion, after conversion compare sha1 digests.
>=20
> And perhaps we could split the test cases into group and add them to
> different tests, in case putting all cases in a single test makes the
> test time too long.
>=20
> Thanks,
> Eryu
>=20
>> +
>> +_scratch_umount
>> +_scratch_dev_pool_put
>> +
>> +echo "Silence is golden"
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>> new file mode 100644
>> index 000000000000..7bfd50ffb5a4
>> --- /dev/null
>> +++ b/tests/btrfs/194.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 194
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b92cb12ca66f..6a11eb1b8230 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -196,3 +196,4 @@
>>  191 auto quick send dedupe
>>  192 auto replay snapshot stress
>>  193 auto quick qgroup enospc limit
>> +194 auto quick volume balance
>> --=20
>> 2.7.4
>>
>=20
