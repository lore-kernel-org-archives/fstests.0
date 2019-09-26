Received: from mx1.redhat.com ([209.132.183.28]:50666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfIZQCU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Sep 2019 12:02:20 -0400
Subject: Re: [PATCH] generic: fallocate two bytes at block boundary
References: <20190926152927.2331-1-mreitz@redhat.com>
 <20190926155513.GE9913@magnolia>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c8cf492f-e3e0-e96f-f8f9-49b42b546cf0@redhat.com>
Date: Thu, 26 Sep 2019 18:02:17 +0200
MIME-Version: 1.0
In-Reply-To: <20190926155513.GE9913@magnolia>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7qoaNLiIavxSCL4YQZ5ZiOyeDXs0dLIZy"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7qoaNLiIavxSCL4YQZ5ZiOyeDXs0dLIZy
Content-Type: multipart/mixed; boundary="JIg5kFAWfXUy3oCTqSnKXiKqD40LzN8Tl"

--JIg5kFAWfXUy3oCTqSnKXiKqD40LzN8Tl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.09.19 17:55, Darrick J. Wong wrote:
> On Thu, Sep 26, 2019 at 05:29:27PM +0200, Max Reitz wrote:
>> Allocating two bytes at a block boundary with fallocate should allocat=
e
>> both blocks involved.  Test this by writing both bytes with dd
>> afterwards and see whether the on-disk size increases (it should not).=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/generic/568     | 63 ++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/generic/568.out |  2 ++
>>  tests/generic/group   |  1 +
>>  3 files changed, 66 insertions(+)
>>  create mode 100755 tests/generic/568
>>  create mode 100644 tests/generic/568.out
>>
>> diff --git a/tests/generic/568 b/tests/generic/568
>> new file mode 100755
>> index 00000000..8fbdcda0
>> --- /dev/null
>> +++ b/tests/generic/568
>> @@ -0,0 +1,63 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test No. generic/568
>> +#
>> +# Test that fallocating an unaligned range allocates all blocks
>> +# touched by that range
>> +#
>> +seq=3D$(basename $0)
>> +seqres=3D"$RESULT_DIR/$seq"
>> +echo "QA output created by $seq"
>> +
>> +here=3D$PWD
>> +tmp=3D/tmp/$$
>> +status=3D1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f "$tmp".*
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>> +
>> +testfile=3D"$SCRATCH_MNT/testfile"
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>> +
>> +# Fallocate 2 bytes across a block boundary
>> +block_size=3D$(stat -fc '%S' "$SCRATCH_MNT")
>=20
> block_size=3D$(_get_file_block_size $SCRATCH_MNT)

Ah, nice.

>> +fallocate -o $((block_size - 1)) -l 2 "$testfile"
>=20
> If you're going to use an external program, you need to gate the test o=
n
> whether or not the program's installed, by calling _require_command.

OK.

> Though probably the easier way would be to use xfs_io since fstests
> requires that xfsprogs be installed:
>=20
> 	$XFS_IO_PROG -f -c "falloc $((block_size - 1)) 2" $testfile
>=20
> Though you do still have to put at the top of the test:
>=20
> 	_require_xfs_io_command "falloc"
>=20
> Because not all filesystems support fallocate.

So I suppose as long as one doesn=E2=80=99t use special XFS commands, xfs=
_io is
filesystem-agnostic?

>> +
>> +# Both the first blocks should be allocated now.  Check that by
>> +# inquiring whether the file grows when we write to the two bytes we
>> +# have just fallocated.
>> +
>> +allocated_size_before=3D$(($(stat -c '%b * %B' "$testfile")))
>> +
>> +dd if=3D/dev/zero of=3D"$testfile" bs=3D1 conv=3Dnotrunc \
>> +    seek=3D$((block_size - 1)) count=3D2 \
>> +    2>&1 | _filter_dd
>=20
> $XFS_IO_PROG -c "pwrite $((block_size - 1)) 2" $testfile
>=20
>> +
>> +allocated_size_after=3D$(($(stat -c '%b * %B' "$testfile")))
>> +
>> +if [ $allocated_size_after -gt $allocated_size_before ]; then
>> +	echo "ERROR: File grew from ${allocated_size_before} B to" \
>> +	     "${allocated_size_after} when writing to the fallocated range."=

>> +else
>> +	echo "OK: File did not grow."
>=20
> Other than that, the logic makes sense to me.  Thanks for writing this
> up!

OK, thanks, I=E2=80=99ll prepare a v2.

Max


--JIg5kFAWfXUy3oCTqSnKXiKqD40LzN8Tl--

--7qoaNLiIavxSCL4YQZ5ZiOyeDXs0dLIZy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2M4QkACgkQ9AfbAGHV
z0AZRwf+NJ60PCgwev1dYbe1FgDrwiYnCP4TIJfiKGPess/osYv5gxEqzXDUYLDC
ajSP1ueDe1MRtc+RntgMDuxaaaOyPAaUPQ4wk9FKzqqPdBOADYDFGZmhdObWAGDv
P75ci5MMp8PDsdxtN7S6pxNWRZQPwOvgiogAr4fok61ckwRxOdcguEbLc/C2NKG+
/1TjXZrQWSpKVQ6RVTgJVVHirbsgAOb3hKbclpuIk5CEwdnH6xLNJdOlrl1nsg2/
aa4vkMn7QTaSXx1ev59s0XA/4XTEbcYoqJSPCXlRtOGvp+/u32f2nin+H1/nJYOk
AozadeDfzI8qX+cJo9qiIw/h1Raqug==
=+ZHw
-----END PGP SIGNATURE-----

--7qoaNLiIavxSCL4YQZ5ZiOyeDXs0dLIZy--
