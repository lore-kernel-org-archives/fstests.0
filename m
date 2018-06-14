Received: from mout.gmx.net ([212.227.15.18]:48933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbeFNFo2 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 14 Jun 2018 01:44:28 -0400
Subject: Re: [PATCH v2] fstests: btrfs: Test if btrfs will corrupt nodatasum
 compressed extent when replacing device
References: <20180608061723.5276-1-wqu@suse.com>
 <20180614053034.GD2780@desktop>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <03984ef6-6bdf-93cf-0b40-e60e16103abe@gmx.com>
Date: Thu, 14 Jun 2018 13:44:15 +0800
MIME-Version: 1.0
In-Reply-To: <20180614053034.GD2780@desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QGLdMdpDqFN8VZTlAwdPlMGC7DD6qFGsd"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QGLdMdpDqFN8VZTlAwdPlMGC7DD6qFGsd
Content-Type: multipart/mixed; boundary="LY7pJ08EhRaDCH87766BpE4qmcBJTl6CV";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <guaneryu@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <03984ef6-6bdf-93cf-0b40-e60e16103abe@gmx.com>
Subject: Re: [PATCH v2] fstests: btrfs: Test if btrfs will corrupt nodatasum
 compressed extent when replacing device
References: <20180608061723.5276-1-wqu@suse.com>
 <20180614053034.GD2780@desktop>
In-Reply-To: <20180614053034.GD2780@desktop>

--LY7pJ08EhRaDCH87766BpE4qmcBJTl6CV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2018=E5=B9=B406=E6=9C=8814=E6=97=A5 13:30, Eryu Guan wrote:
> On Fri, Jun 08, 2018 at 02:17:23PM +0800, Qu Wenruo wrote:
>> This is a long existing bug (from 2012) but exposed by a reporter
>> recently, that when compressed extent without data csum get written to=

>> device-replace target device, the written data is in fact uncompressed=
 data
>> other than the original compressed data.
>>
>> And since btrfs still consider the data is compressed and will try to =
read it
>> as compressed, it can cause read error.
>>
>> The root cause is located, and one RFC patch already sent to fix it,
>> titled "[PATCH] btrfs: scrub: Don't use inode pages for device replace=
".
>> (The RFC is only for the extra possible way to fix the bug, the fix
>> itself should work without problem)
>>
>> Reported-by: James Harvey <jamespharvey20@gmail.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> changelog:
>> v2:
>>   Now the fix patch is no longer RFC.
>>   Remove _require_test as we don't really touch it.
>>   Add comment on the mount cycle.
>>   Add the test to group 'volume'.
>=20
> Thanks for the revision! But again, I'd like to get some explicit
> reviews from btrfs folks.

Something I cannot help here :(

>=20
>> ---
>>  tests/btrfs/161     | 91 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  tests/btrfs/161.out |  2 +
>>  tests/btrfs/group   |  1 +
>>  3 files changed, 94 insertions(+)
>>  create mode 100755 tests/btrfs/161
>>  create mode 100644 tests/btrfs/161.out
>>
>> diff --git a/tests/btrfs/161 b/tests/btrfs/161
>> new file mode 100755
>> index 00000000..ce1b0e04
>> --- /dev/null
>> +++ b/tests/btrfs/161
>> @@ -0,0 +1,91 @@
>> +#! /bin/bash
>> +# FS QA Test 161
>> +#
>> +# Test if btrfs will corrupt compressed data extent without data csum=

>> +# by replacing it with uncompressed data, when doing replacing device=
=2E
>> +#
>> +# This could be fixed by the following RFC patch:
>                                           ^^^^ can be dropped?

Yep, that should be dropped.
As the fix is already in the latest pull request sent to Linus.

>=20
> Thanks,
> Eryu
>=20
> P.S.
> *IF* you're going to send v3, could you please follow the new test
> template (create new test with './new btrfs' would do the work) and
> rebase against latest master? That'd be easier for me to apply the
> patch, but I'm also fine with taking it as-is (after we get Reviewed-by=

> tag), I can convert the test and re-number it on commit as always.

Of course, I'll use the new template in next version, and update the base=
=2E

Thanks,
Qu

>=20
>> +# "[PATCH] btrfs: scrub: Don't use inode pages for device replace"
>> +#
>> +#--------------------------------------------------------------------=
---
>> +# Copyright (C) 2018 SUSE Linux Products GmbH. All Rights Reserved.
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
>> +# along with this program; if not, write the Free Software Foundation=
,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#--------------------------------------------------------------------=
---
>> +#
>> +
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
>> +_require_scratch_dev_pool_equal_size
>> +
>> +
>> +_scratch_dev_pool_get 1
>> +_spare_dev_get
>> +_scratch_pool_mkfs >> $seqres.full 2>&1
>> +
>> +# Create nodatasum inode
>> +_scratch_mount "-o nodatasum"
>> +touch $SCRATCH_MNT/nodatasum_file
>> +_scratch_remount "datasum,compress"
>> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/nodatasum_file > /dev/null
>> +
>> +# Write the compressed data back to disk
>> +sync
>> +
>> +# Replace the device
>> +_run_btrfs_util_prog replace start -Bf 1 $SPARE_DEV $SCRATCH_MNT
>> +
>> +# Unmount to drop all cache so next read will read from disk
>> +_scratch_unmount
>> +_mount $SPARE_DEV $SCRATCH_MNT
>> +
>> +# Now the EXTENT_DATA item still marks the extent as compressed,
>> +# but the on-disk data is uncompressed, thus reading it as compressed=

>> +# will definitely cause EIO.
>> +cat $SCRATCH_MNT/nodatasum_file > /dev/null
>> +
>> +_scratch_unmount
>> +_spare_dev_put
>> +_scratch_dev_pool_put
>> +
>> +echo "Silence is golden"
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/btrfs/161.out b/tests/btrfs/161.out
>> new file mode 100644
>> index 00000000..1752a243
>> --- /dev/null
>> +++ b/tests/btrfs/161.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 161
>> +Silence is golden
>> diff --git a/tests/btrfs/group b/tests/btrfs/group
>> index f04ee8d5..9195b368 100644
>> --- a/tests/btrfs/group
>> +++ b/tests/btrfs/group
>> @@ -163,3 +163,4 @@
>>  158 auto quick raid scrub
>>  159 auto quick
>>  160 auto quick
>> +161 auto quick replace volume
>> --=20
>> 2.17.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--LY7pJ08EhRaDCH87766BpE4qmcBJTl6CV--

--QGLdMdpDqFN8VZTlAwdPlMGC7DD6qFGsd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlsiAK8ACgkQwj2R86El
/qiiyggAgDiOM1ZwczJJKF2hqw7NpZe31E5PZ9vZhF/lwsXynQQzhUYDX2NuUaLD
EIUuWv3WcrGtYkd5XELsp5hdf665tjnF9HY24mO24rJMyQVQPKol0wt/nFFqnk89
kOZFZK7xJXSAoPH+EnwPNgIsqL6FNlvqj3dCCvGoY3qKrocc0xevef4az34l4veP
XR8q1mDsrBPsGyKXuWfVa5YODv79PDsoBtjOqzvAEyPLcB1t1NRrWXIWP9FF3CZ1
A1LZUX5Kcawt2DLkyRC3RzY3yhYPwnrQV4yQ93MHgDPyx8+0+6RZj5OSv+BIbfTO
jDfaAHZAZm5tlF7YKtwlyjVKWD72/w==
=MZY3
-----END PGP SIGNATURE-----

--QGLdMdpDqFN8VZTlAwdPlMGC7DD6qFGsd--
