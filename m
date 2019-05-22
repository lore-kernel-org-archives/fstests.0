Received: from mx2.suse.de ([195.135.220.15]:52398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbfEVJhD (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 22 May 2019 05:37:03 -0400
Subject: Re: [PATCH] fstests: btrfs: Test if btrfs will panic when mounting a
 partially balanced fs
References: <20190522083944.32365-1-wqu@suse.com>
 <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>
From: Qu Wenruo <wqu@suse.de>
Message-ID: <36d703c3-3264-c12c-2721-c85b48a1faa8@suse.de>
Date: Wed, 22 May 2019 17:36:57 +0800
MIME-Version: 1.0
In-Reply-To: <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mzfZ5hDARGcxJNQJjQERbR0H6J5cpTkXI"
Sender: fstests-owner@vger.kernel.org
To: fdmanana@gmail.com
Cc: fstests <fstests@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mzfZ5hDARGcxJNQJjQERbR0H6J5cpTkXI
Content-Type: multipart/mixed; boundary="LZ46pYaOk4x1eb3fOY8l1jXoITp82uaoh";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: fdmanana@gmail.com
Cc: fstests <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <36d703c3-3264-c12c-2721-c85b48a1faa8@suse.de>
Subject: Re: [PATCH] fstests: btrfs: Test if btrfs will panic when mounting a
 partially balanced fs
References: <20190522083944.32365-1-wqu@suse.com>
 <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>
In-Reply-To: <CAL3q7H48_ouBvEsuximFOjAxOSdu5FFfP0Dn8QAsM73xRG8PMg@mail.gmail.com>

--LZ46pYaOk4x1eb3fOY8l1jXoITp82uaoh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/5/22 =E4=B8=8B=E5=8D=885:32, Filipe Manana wrote:
> On Wed, May 22, 2019 at 9:40 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There are two regressions that when mounting a partially balance btrfs=

>> after v5.1 kernel:
>> - Kernel NULL pointer dereference at mount time
>> - Kernel BUG_ON() just after mount
>>
>> The kernel fixes are:
>> "btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
>>  dereference"
>> "btrfs: reloc: Also queue orphan reloc tree for cleanup to
>>  avoid BUG_ON()"
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/188     | 94 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/188.out |  2 +
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 97 insertions(+)
>>  create mode 100755 tests/btrfs/188
>>  create mode 100644 tests/btrfs/188.out
>>
>> diff --git a/tests/btrfs/188 b/tests/btrfs/188
>> new file mode 100755
>> index 00000000..f43be007
>> --- /dev/null
>> +++ b/tests/btrfs/188
>> @@ -0,0 +1,94 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
>> +#
>> +# FS QA Test 188
>> +#
>> +# Test if btrfs mount will hit the following bugs when mounting
>> +# a fs going through partial balance:
>> +# - NULL pointer dereference
>> +# - Kernel BUG_ON()
>=20
> I would make the description be closer to what the test is - a general
> test to validate that balance and qgroups work correctly when balance
> needs to be resumed on mount.
> You can leave those specific problems in the change log.
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
>> +. ./common/dmlogwrites
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
>> +# and we need extra device as log device
>> +_require_log_writes
>> +
>> +nr_files=3D512                           # enough metadata to bump tr=
ee height
>> +file_size=3D2048                         # small enough to be inlined=

>> +
>> +_log_writes_init $SCRATCH_DEV
>> +_log_writes_mkfs >> $seqres.full 2>&1
>> +
>> +_log_writes_mount
>> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
>> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
>> +
>> +# Create enough metadata for later balance
>> +for ((i =3D 0; i < $nr_files; i++)); do
>> +       _pwrite_byte 0xcd 0 $file_size $SCRATCH_MNT/file_$i > /dev/nul=
l
>> +done
>> +
>> +# Ensure we write all data/metadata back to disk so that later
>> +# balance will do real I/O
>=20
> I don't understand this. Real I/O? Do we have any fake I/O? What is it?=


I mean to avoid things like delayed inode where we only have dirty pages
but haven't written them onto disk.

In this case we want some metadata space to be really used. Dirty page
caches can't do that.

What's the proper expression for this?

>=20
>> +sync
>> +
>> +# Balance metadata so we will have at least one transaction committed=
 with
>> +# valid reloc tree, and hopefully an orphan reloc tree.
>> +$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
>> +_log_writes_unmount
>> +_log_writes_remove
>> +
>> +cur=3D$(_log_writes_find_next_fua 0)
>> +echo "cur=3D$cur" >> $seqres.full
>> +while [ ! -z "$cur" ]; do
>> +       _log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full=

>> +
>> +       # If the fs contains valid reloc tree and kernel is not patche=
d,
>> +       # we'll hit a NULL pointer dereference
>> +       # Or if it contains orphan reloc tree and kernel is unpatched,=

>> +       # we'll hit a BUG_ON()
>=20
> # Test that no crashes happen or any other kind of failure.
>=20
>> +       _scratch_mount
>> +       _scratch_unmount
>> +
>> +       # Don't trigger fsck here, as relocation get paused,
>> +       # at that transistent state, qgroup number may differ
>> +       # and cause false alert.
>> +
>> +       prev=3D$cur
>> +       cur=3D$(_log_writes_find_next_fua $(($cur + 1)))
>> +       [ -z "$cur" ] && break
>> +done
>=20
> After the balance finishes, can we verify that qgroup values are correc=
t?

Isn't  that done automatically when the test is finished?
As i'm using _require_scratch, not _require_scratch_no_check.

>=20
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
>> new file mode 100644
>> index 00000000..6f23fda0
>> --- /dev/null
>> +++ b/tests/btrfs/188.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 188
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index 44ee0dd9..16a7c31e 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -190,3 +190,4 @@
>>  185 volume
>>  186 auto quick send volume
>>  187 auto send dedupe clone balance
>> +188 auto quick replay
>=20
> "balance" and "qgroup" groups as well

Forgot that.

Thanks for comment,
Qu

>=20
> Thanks.
>> --
>> 2.21.0
>>
>=20
>=20


--LZ46pYaOk4x1eb3fOY8l1jXoITp82uaoh--

--mzfZ5hDARGcxJNQJjQERbR0H6J5cpTkXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlzlGDkACgkQwj2R86El
/qhpAAf9HDFjGRPrQ+GDk3Rvde+YMDd9dvSwf4E17tFTzMxhyYpnLFJAesaVBVCi
53AX29P7GER6eJG8OZy/dLrik6n/nW3NQsXHLTtLKnjEoeyNwftpAA/Mh+NU4kJu
EN/d49/bHneX3hyrAdxFgrt9aS+bT575ut35s508KkS+V7JJ7RLLqDo83QWsjTO3
ZQZlssHjCt02tsAJTU78y9KYOdlElrkLK4jGf8Io4/HCS8vrA2uUKucQo/MZf+J2
dypx1DsqEjXlwKRCMh3E7vekyR5aBbYQfdaRHg/ejhEiPF2WAym+DRXD1H/+VG/s
MeCeRGnw3ghFQrM+5/gKhOycRBxO+g==
=MPIB
-----END PGP SIGNATURE-----

--mzfZ5hDARGcxJNQJjQERbR0H6J5cpTkXI--
