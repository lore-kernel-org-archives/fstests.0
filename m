Received: from mout.gmx.net ([212.227.17.22]:56815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbfI3LCS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 30 Sep 2019 07:02:18 -0400
Subject: Re: [PATCH] fstests: btrfs: Add regression test to check if btrfs can
 handle high devid
References: <20190930083735.21284-1-wqu@suse.com>
 <CAL3q7H5mVHUQJ31wANwM8hXbbumwcUNrxSCebv46zpgEGYA2zw@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7716f94d-214a-6756-6065-806c0707d85d@gmx.com>
Date: Mon, 30 Sep 2019 19:01:44 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5mVHUQJ31wANwM8hXbbumwcUNrxSCebv46zpgEGYA2zw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg
Content-Type: multipart/mixed; boundary="HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt"

--HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/30 =E4=B8=8B=E5=8D=886:33, Filipe Manana wrote:
> On Mon, Sep 30, 2019 at 9:39 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Add a regression test to check if btrfs can handle high devid.
>>
>> The test will add and remove devices to a btrfs fs, so that the devid
>> will increase to uncommon but still valid values.
>>
>> The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:
>> tree-checker: Verify dev item").
>> The fix is titled "btrfs: tree-checker: Fix wrong check on max devid".=

>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/194     | 73 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/194.out |  2 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 76 insertions(+)
>>  create mode 100755 tests/btrfs/194
>>  create mode 100644 tests/btrfs/194.out
>>
>> diff --git a/tests/btrfs/194 b/tests/btrfs/194
>> new file mode 100755
>> index 00000000..7a52ed86
>> --- /dev/null
>> +++ b/tests/btrfs/194
>> @@ -0,0 +1,73 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
>> +#
>> +# FS QA Test 194
>> +#
>> +# Test if btrfs can handle large device ids.
>> +#
>> +# The regression is introduced by kernel commit ab4ba2e13346 ("btrfs:=

>> +# tree-checker: Verify dev item").
>> +# The fix is titlted: "btrfs: tree-checker: Fix wrong check on max de=
vid"
>=20
> type, titlted -> titled
>=20
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1       # failure is the default!
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
>> +
>> +# Modify as appropriate.
>> +_supported_fs btrfs
>> +_supported_os Linux
>> +_require_scratch_dev_pool 2
>> +_scratch_dev_pool_get 2
>> +
>> +# The wrong check limit is based on node size, to reduce runtime, we =
only
>> +# support 4K page size system for now
>> +if [ $(get_page_size) !=3D 4096 ]; then
>> +       _notrun "This test need 4k page size"
>> +fi
>> +
>> +device_1=3D$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>> +device_2=3D$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
>> +
>> +echo device_1=3D$device_1 device_2=3D$device_2 >> $seqres.full
>> +
>> +# Use 4K nodesize to reduce runtime
>=20
> How does the node size reduces runtime?

The old wrong check is based on how large a chunk item can be.
The macro we use is BTRFS_MAX_DEVS() which takes fs_info->nodesize to
calculate.

The largest chunk item (or any item) is based on nodesize.
Thus nodesize will affect the runtime.

> It's obvious when one wants to create deeper/larger trees for some
> purpose, but this test doesn't populate the filesystem, it uses an
> empty filesystem.
> So that deserves an explanation of how the node size influences the
> test's running time.

Indeed.

>=20
>> +_scratch_mkfs -n 4k >> $seqres.full
>> +_scratch_mount
>> +
>> +# Add and remove device in a loop, one loop will increase devid by 2.=

>=20
> " ... one loop will ..." -> "... each iteration will ..."
>=20
>> +# for 4k nodesize, the wrong check will be triggered at devid 123.
>=20
> Why 123? It's not clear to me why, the test case doesn't explain and
> neither does the btrfs patch that fixes the regression.
> If it's related to the value of the constants/functions
> BTRFS_MAX_DEVS and BTRFS_MAX_DEVS_SYS_CHUNK, it should be mentioned
> here.

OK, I'll mention
>=20
>> +# here 64 is enough to trigger such regression
>> +for (( i =3D 0; i < 64; i++ )); do
>> +       $BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
>> +       $BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
>> +done
>> +_scratch_dev_pool_put
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
>> new file mode 100644
>> index 00000000..7bfd50ff
>> --- /dev/null
>> +++ b/tests/btrfs/194.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 194
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b92cb12c..ef1f0e1b 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -196,3 +196,4 @@
>>  191 auto quick send dedupe
>>  192 auto replay snapshot stress
>>  193 auto quick qgroup enospc limit
>> +194 auto
>=20
> Maybe volume group as well.

Thanks for the hint, I was looking into the groups but can't find a good
candidate.

At least volume makes more sense.

Thanks,
Qu
>=20
> Thanks Qu.
>=20
>> --
>> 2.22.0
>>
>=20
>=20


--HkkywR8IVE5heDnCYKXVj4NsogFcWlYJt--

--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2R4JgACgkQwj2R86El
/qhkGgf/VKKi6IiwZvAUtsLMvi0fD/TLfBpAYv6XFhW+u1YCj4f7JbBUMzP8pCUb
2/iN4YWaHFbVsFk1GjuCD0UOiFAlRAPNpI+HEp5fhWrA/JvroRCg/Qe88pXVXP9B
jF4R0aiYzpVWyhy2/duzXmiFk7n541bpqsW1g0GdN65TU8aKq8SzLXMueRP58dTi
LUjvQCAXJnpUI/V666cvA/f6N/TCLQmW/UNAtBleROr6VGitu2Er6VM7rklRNinC
T2nbW3L0WjrCgYuOYFLf+fb+WOA2j3uNsvOTqi5/omB2b8cN+Wqw1qP8pTfTJ9ta
P4Qxk29FQIaIpJiyLeXTH743tczvag==
=Jq20
-----END PGP SIGNATURE-----

--m2ukn0GdM0IGyte4aBKtQPwQfKm2syjNg--
