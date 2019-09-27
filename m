Received: from mx1.redhat.com ([209.132.183.28]:44532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfI0JQb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 05:16:31 -0400
Subject: Re: [PATCH v2] generic: fallocate two bytes at block boundary
References: <20190926165145.9161-1-mreitz@redhat.com>
 <20190927013744.GY2622@desktop>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <56045f7d-8f28-9af0-3508-bdb7630288ba@redhat.com>
Date: Fri, 27 Sep 2019 11:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <20190927013744.GY2622@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="an3LoQyepypX6ZYGRfcNokLbT4cmV3xgW"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--an3LoQyepypX6ZYGRfcNokLbT4cmV3xgW
Content-Type: multipart/mixed; boundary="Cu7jaTGUu4sOgWwLeVFbxsRGQtFXCN89Z"

--Cu7jaTGUu4sOgWwLeVFbxsRGQtFXCN89Z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.09.19 03:37, Eryu Guan wrote:
> On Thu, Sep 26, 2019 at 06:51:45PM +0200, Max Reitz wrote:
>> Allocating two bytes at a block boundary with fallocate should allocat=
e
>> both blocks involved.  Test this by writing data to both bytes
>> afterwards and see whether the on-disk size increases (it should not).=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> I notice that XFS fails this test with v5.3 kernel, so I guess this is =
a
> targeted regression test? Do you have a (pending) patch/commit that
> could be referenced in the commit log and/or test description? So we
> could know which patch/commit fixed this particular failure.

Yes, exactly.  It=E2=80=99s "xfs: Fix tail rounding in xfs_alloc_file_spa=
ce()=E2=80=8B=E2=80=9D
(https://www.spinics.net/lists/linux-xfs/msg32174.html).  I=E2=80=99ll ad=
d it to
the commit message in v3.

>> ---
>> v2:
>> - Use _get_file_block_size instead of manual stat -fc '%S'
>> - Use xfs_io instead of fallocate/dd
>>   (and require falloc support)
>> - Add the ' B' that was missing as allocated_size_after's unit in the
>>   error message
>> ---
>>  tests/generic/568     | 63 ++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/generic/568.out |  4 +++
>>  tests/generic/group   |  1 +
>>  3 files changed, 68 insertions(+)
>>  create mode 100755 tests/generic/568
>>  create mode 100644 tests/generic/568.out
>>
>> diff --git a/tests/generic/568 b/tests/generic/568
>> new file mode 100755
>> index 00000000..df67daf4
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
>> +_require_xfs_io_command "falloc"
>> +
>> +testfile=3D"$SCRATCH_MNT/testfile"
>> +
>> +_scratch_mkfs > /dev/null 2>&1
>> +_scratch_mount
>=20
> Seems you don't need $SCRATCH_DEV at all. Just create the test file on
> $TEST_DEV in $TEST_DIR, e.g.
>=20
> testfile=3D"$TEST_DIR"/falloctest-$seq
> rm -f $testfile

OK, sure.

>> +
>> +# Fallocate 2 bytes across a block boundary
>> +block_size=3D$(_get_file_block_size "$SCRATCH_MNT")
>> +$XFS_IO_PROG -f -c "falloc $((block_size - 1)) 2" "$testfile"
>> +
>> +# Both the first blocks should be allocated now.  Check that by
>> +# inquiring whether the file grows when we write to the two bytes we
>> +# have just fallocated.
>> +
>> +allocated_size_before=3D$(($(stat -c '%b * %B' "$testfile")))
>> +
>> +$XFS_IO_PROG -c "pwrite $((block_size - 1)) 2" "$testfile" \
>> +	| _filter_xfs_io | sed -e "s/$((block_size - 1))/block_size - 1/"
>> +
>> +allocated_size_after=3D$(($(stat -c '%b * %B' "$testfile")))
>> +
>> +if [ $allocated_size_after -gt $allocated_size_before ]; then
>> +	echo "ERROR: File grew from ${allocated_size_before} B to" \
>> +	     "${allocated_size_after} B when writing to the fallocated range=
=2E"
>> +else
>> +	echo "OK: File did not grow."
>> +fi
>> +
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/568.out b/tests/generic/568.out
>> new file mode 100644
>> index 00000000..435a9630
>> --- /dev/null
>> +++ b/tests/generic/568.out
>> @@ -0,0 +1,4 @@
>> +QA output created by 568
>> +wrote 2/2 bytes at offset block_size - 1
>> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> +OK: File did not grow.
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 7cf4f6c4..24ab29bc 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -570,3 +570,4 @@
>>  565 auto quick copy_range
>>  566 auto quick quota metadata
>>  567 auto quick rw punch
>> +568 auto quick rw
>=20
> Add 'prealloc' group as well.

Will do.

> Thanks for the test!

Thanks for reviewing,

Max


--Cu7jaTGUu4sOgWwLeVFbxsRGQtFXCN89Z--

--an3LoQyepypX6ZYGRfcNokLbT4cmV3xgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2N02wACgkQ9AfbAGHV
z0Cfcwf+OM5lJ28DbVjwjhU0Eo8BReQ3nnvDAFm3L7TG5xXPO8vHvA8MaWpYQh4K
bGKoQt3m50nVmrJ9f3yNznAhkA4ZeuzjPOxq77v8z/kE2qHCwXoBww8CpCjdq5Ka
vFA5/9NZ6oH9dzGVJ2v8ETmnCav+F2bZAK3hvbZgKlL+ZEPLSPlP11/udtOQogr+
d3vRVeTVWv4Cl7/nrNGtdm06JXlYBC+fQS7EPS4SodVp3PwiSBn7mefAmn6faNfb
jsN7Ukj8SlpCM6LZEKpAU5f1I7AwGVNJ/AW/qRG3ArHmgC09Of8DaOKm1H7bXrWZ
MtXJAyD8x+ff5DASXc/0PEUR8xn2Uw==
=8/by
-----END PGP SIGNATURE-----

--an3LoQyepypX6ZYGRfcNokLbT4cmV3xgW--
