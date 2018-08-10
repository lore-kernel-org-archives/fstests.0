Received: from mout.gmx.net ([212.227.17.21]:54695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeHJLPG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Aug 2018 07:15:06 -0400
Subject: Re: [PATCH] fstests: btrfs: Add test for corrupted orphan qgroup
 numbers
References: <20180809074540.2588-1-wqu@suse.com>
 <CAL3q7H5vTyZ8BMBEi-S=1kP+88hXt-YeiK5cF=9bFKJ+89aHKw@mail.gmail.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b93343a4-fc4d-72fe-3c99-09bc2f8a1327@gmx.com>
Date: Fri, 10 Aug 2018 16:46:00 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H5vTyZ8BMBEi-S=1kP+88hXt-YeiK5cF=9bFKJ+89aHKw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FChPismf5aiNRmOqt0P5IGcFPF312Iyf8"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FChPismf5aiNRmOqt0P5IGcFPF312Iyf8
Content-Type: multipart/mixed; boundary="xzndZ1PsvEubEIFbUemfE7q0xc9S0MX3g";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fdmanana@gmail.com, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>,
 fstests <fstests@vger.kernel.org>
Message-ID: <b93343a4-fc4d-72fe-3c99-09bc2f8a1327@gmx.com>
Subject: Re: [PATCH] fstests: btrfs: Add test for corrupted orphan qgroup
 numbers
References: <20180809074540.2588-1-wqu@suse.com>
 <CAL3q7H5vTyZ8BMBEi-S=1kP+88hXt-YeiK5cF=9bFKJ+89aHKw@mail.gmail.com>
In-Reply-To: <CAL3q7H5vTyZ8BMBEi-S=1kP+88hXt-YeiK5cF=9bFKJ+89aHKw@mail.gmail.com>

--xzndZ1PsvEubEIFbUemfE7q0xc9S0MX3g
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 8/9/18 5:26 PM, Filipe Manana wrote:
> On Thu, Aug 9, 2018 at 8:45 AM, Qu Wenruo <wqu@suse.com> wrote:
>> This bug is exposed by populating a high level qgroup, and then make i=
t
>> orphan (high level qgroup without child)
>=20
> Same comment as in the kernel patch:
>=20
> "That sentence is confusing. An orphan, by definition [1], is someone
> (or something in this case) without parents.
> But you mention a group without children, so that should be named
> "childless" or simply say "without children".
> So one part of the sentence is wrong, either what is in parenthesis or
> what comes before them.
>=20
> [1] https://www.thefreedictionary.com/orphan
> "
>=20
>> with old qgroup numbers, and
>> finally do rescan.
>>
>> Normally rescan should zero out all qgroups' accounting number, but du=
e
>> to a kernel bug which won't mark orphan qgroups dirty, their on-disk
>> data is not updated, thus old numbers remain and cause qgroup
>> corruption.
>>
>> Fixed by the following kernel patch:
>> "btrfs: qgroup: Dirty all qgroups before rescan"
>>
>> Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/170     | 82 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/170.out |  3 ++
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 86 insertions(+)
>>  create mode 100755 tests/btrfs/170
>>  create mode 100644 tests/btrfs/170.out
>>
>> diff --git a/tests/btrfs/170 b/tests/btrfs/170
>> new file mode 100755
>> index 000000000000..bcf8b5c0e4f3
>> --- /dev/null
>> +++ b/tests/btrfs/170
>> @@ -0,0 +1,82 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 170
>> +#
>> +# Test if btrfs can clear orphan (high level qgroup without child) qg=
roup's
>> +# accounting numbers during rescan.
>> +# Fixed by the following kernel patch:
>> +# "btrfs: qgroup: Dirty all qgroups before rescan"
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
>> +_require_scratch
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +
>> +# Populate the fs
>> +_run_btrfs_util_prog subvolume create "$SCRATCH_MNT/subvol"
>> +_pwrite_byte 0xcdcd 0 1M "$SCRATCH_MNT/subvol/file1" | _filter_xfs_io=
 > /dev/null
>> +
>> +# Ensure that file reach disk, so it will also appear in snapshot
>=20
> # Ensure that buffered file data is persisted, so we won't have an
> empty file in the snapshot.
>> +sync
>> +_run_btrfs_util_prog subvolume snapshot "$SCRATCH_MNT/subvol" "$SCRAT=
CH_MNT/snapshot"
>> +
>> +
>> +_run_btrfs_util_prog quota enable "$SCRATCH_MNT"
>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
>> +
>> +# Create high level qgroup
>> +_run_btrfs_util_prog qgroup create 1/0 "$SCRATCH_MNT"
>> +
>> +# Don't use _run_btrfs_util_prog here, as it can return 1 to info use=
r
>> +# that qgroup is marked inconsistent, this is a bug in btrfs-progs, b=
ut
>> +# to ensure it will work, we just ignore the return value.
>=20
> Comment should go away IMHO. The preferred way is to call
> $BTRFS_UTIL_PROG and have failures noticed
> through differences in the golden output. There's no point in
> mentioning something that currently doesn't work
> if it's not used here.

In this case, I think we still need to mention why we don't use
_run_btrfs_util_progs, in fact if we use _run_btrfs_util_progs, the test
will just fail due to the return value.

In fact, it's a workaround and worthy noting IIRC.

>=20
>> +$BTRFS_UTIL_PROG qgroup assign "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_=
MNT"
>> +
>> +# Above assign will mark qgroup inconsistent due to the shared extent=
s
>=20
> assign -> assignment
>=20
>> +# between subvol/snapshot/high level qgroup, do rescan here
>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
>=20
> Use $BTRFS_UTIL_PROG directly instead, and adjust the golden output if =
needed.

There is nothing special needed in "quota rescan".

Only qgroup assign/remove could return 1 instead of 0.

>=20
>> +
>> +# Now remove the qgroup relationship and make 1/0 orphan
>> +# Due to the shared extent outside of 1/0, we will mark qgroup incons=
istent
>> +# and keep the number of qgroup 1/0
>=20
> Missing "." at the end of the sentences.
>=20
>> +$BTRFS_UTIL_PROG qgroup remove "$SCRATCH_MNT/snapshot" 1/0 "$SCRATCH_=
MNT"
>> +
>> +# Above removal also marks qgroup inconsistent, rescan again
>> +_run_btrfs_util_prog quota rescan -w "$SCRATCH_MNT"
>=20
> Use $BTRFS_UTIL_PROG directly instead, and adjust the golden output if =
needed.

The extra warning is not outputted by rescan, it's caused by qgroup
assign/remove as mentioned above.

Thanks,
Qu

>=20
> Thanks.
>=20
>> +
>> +# After the test, btrfs check will verify qgroup numbers to catch any=

>> +# corruption.
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/170.out b/tests/btrfs/170.out
>> new file mode 100644
>> index 000000000000..9002199e48ed
>> --- /dev/null
>> +++ b/tests/btrfs/170.out
>> @@ -0,0 +1,3 @@
>> +QA output created by 170
>> +WARNING: quotas may be inconsistent, rescan needed
>> +WARNING: quotas may be inconsistent, rescan needed
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index b616c73d09bf..339c977135c0 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -172,3 +172,4 @@
>>  167 auto quick replace volume
>>  168 auto quick send
>>  169 auto quick send
>> +170 auto quick qgroup
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20


--xzndZ1PsvEubEIFbUemfE7q0xc9S0MX3g--

--FChPismf5aiNRmOqt0P5IGcFPF312Iyf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlttUMgACgkQwj2R86El
/qi+wgf/ZFP4QrxjrSBBi5oae2CSmhdrqmwnW0LDWuuXad5ospw50S/2tztEuNRK
lsFMX+fv1XdYDePkgduvyvdGNZSpYwZodkoKe1ahKU/XvwUQfb91KTJV7KRGHpKd
ejKR4XKtxPRBMEz790fh2YrCIdfCjb1C2Q9O3CbRCHFHJI8iuAkllcGYUqcDCPtH
biD/EVz2mzYmHiyLwotSJ8xuJSrXmCgqYNQw2X5zCUZHEXCb2oGw9yogiWxctoSu
lpEoj5+DYUK2/n+Gl1X4em8GlR3jT8Swt6QkWq20O+jQClZXOIs4A0RZWLHCGnYo
XIzJqkyjDW7aZwTCg9PyF1EzsYUh/Q==
=YObY
-----END PGP SIGNATURE-----

--FChPismf5aiNRmOqt0P5IGcFPF312Iyf8--
