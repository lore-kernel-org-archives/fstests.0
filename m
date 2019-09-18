Received: from mout.gmx.net ([212.227.15.18]:45799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbfIRKMR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 06:12:17 -0400
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
 <20190918084734.GA52397@e18g06458.et15sqa>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a4330728-fb49-b051-517e-9a36971394a1@gmx.com>
Date: Wed, 18 Sep 2019 18:12:02 +0800
MIME-Version: 1.0
In-Reply-To: <20190918084734.GA52397@e18g06458.et15sqa>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@linux.alibaba.com>, Qu Wenruo <wqu@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr
Content-Type: multipart/mixed; boundary="zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq"

--zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=884:47, Eryu Guan wrote:
> On Wed, Sep 18, 2019 at 02:56:26PM +0800, Qu Wenruo wrote:
>> [BUG]
>> When btrfs/011 is executed on a fast enough system (fully memory backe=
d
>> VM, with test device has unsafe cache mode), the test can fail like
>> this:
>>
>>   btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /hom=
e/adam/xfstests-dev/results//btrfs/011.out.bad)
>>     --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>>     +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-0=
9-18 14:49:28.308798022 +0800
>>     @@ -1,3 +1,4 @@
>>      QA output created by 011
>>      *** test btrfs replace
>>     -*** done
>>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>     +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)=

>>     ...
>>
>> [CAUSE]
>> Looking into the full output, it shows:
>>   ...
>>   Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
>>
>>   # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/map=
per/test-scratch2 /mnt/scratch
>>   # /usr/bin/btrfs replace cancel /mnt/scratch
>>   INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>>   failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>
>> So this means the replace is already finished before we cancel it.
>> For fast system, it's very common.
>=20
> Does generate heavier load & more data make replace operation last
> longer? e.g. make more 'noise' by running fsstress instead of dumping
> /dev/urandom before starting replace.

That's a great idea.

In fact we can try to write as much data as possible for 3s (using
Direct IO), so that we know we have some data which will take at least
3s to read/write.

I'd take a try on this method.

Thanks,
Qu
>=20
> And does sleep shorter time (0.5s?) before cancel work?
>=20
> Thanks,
> Eryu
>=20
>>
>> [FIX]
>> Instead of using _run_btrfs_util_prog which requires 0 as return value=
,
>> we just call "$BTRFS_UTIL_PROG replace cancel" and ignore all its
>> stderr/stdout, and completely rely on "$BTRFS_UTIL_PROG replace status=
"
>> output to verify the work.
>>
>> Furthermore if we finished replac before cancelling it, we should
>> replace again to switch the device back, or after the test case, btrfs=

>> check will fail as there is no valid btrfs on that replaced device.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/btrfs/011 | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index 89bb4d11..858b00e8 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -148,13 +148,25 @@ btrfs_replace_test()
>>  		# background the replace operation (no '-B' option given)
>>  		_run_btrfs_util_prog replace start -f $replace_options $source_dev =
$target_dev $SCRATCH_MNT
>>  		sleep 1
>> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
>> +		# 1s is enough for fast system to finish replace, so here we
>> +		# ignore all the output, completely rely on later status
>> +		# output to determine
>> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT &> /dev/null
>> =20
>>  		# 'replace status' waits for the replace operation to finish
>>  		# before the status is printed
>>  		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>>  		cat $tmp.tmp >> $seqres.full
>> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled)=
 failed"
>> +		grep -q -e canceled -e finished $tmp.tmp ||\
>> +			_fail "btrfs replace status (canceled) failed"
>> +
>> +		# If replace finished before cancel, replace them back or
>> +		# the final fsck after test case will fail as there is no btrfs
>> +		# on the $source_dev anymore
>> +		if grep -q -e finished $tmp.tmp ; then
>> +			$BTRFS_UTIL_PROG replace start -Bf $replace_options \
>> +				$target_dev $source_dev $SCRATCH_MNT
>> +		fi
>>  	else
>>  		if [ "${quick}Q" =3D "thoroughQ" ]; then
>>  			# On current hardware, the thorough test runs
>> --=20
>> 2.22.0


--zNFmtSXEhqJUPgtM9TiyofspimBaEJSLq--

--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2CAvIACgkQwj2R86El
/qgjqgf/f8Y4KNRBN6eKxH9hs40YvAS5xEYbijP7GzwR4irKcSmZxcdRVORnUEvG
31vTi1hx3njSOHJf/RXJr5juxvXxLapcApTGyEKcKmj+TjEBujAW1jbbTCu3KdTj
kNrIBmQtku/O2EgHuO0q6gd1XG4SkPZrbsY9m/HJHEELN3aTVeJLxzYhjE/Sy1lb
2i0FKGQO/EHRjqufcadAi14zUsm+tgKG1EANZWJSjcrEx3vkJcpxx8P0UFcQr6J3
deID+vdJCCslcjkX0q2eNFpYjWjE128Yrz7aPkYnK8f11oET+xAgeen2cJUCQ1CF
d0TAOHyuGCOZQp8IOa7gNWawWtKEjA==
=QqfT
-----END PGP SIGNATURE-----

--oaFs74FNEHU3lwNOplW4ruKi0m9i5IUcr--
