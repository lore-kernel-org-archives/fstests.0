Received: from mout.gmx.net ([212.227.15.15]:41039 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIRH5s (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 18 Sep 2019 03:57:48 -0400
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
 <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <272e4631-f38f-496b-40f5-b39561314872@gmx.com>
Date: Wed, 18 Sep 2019 15:57:28 +0800
MIME-Version: 1.0
In-Reply-To: <2b6c6153-d4e0-f776-2c7c-4aa4c6331b39@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN"
Sender: fstests-owner@vger.kernel.org
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN
Content-Type: multipart/mixed; boundary="QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT"

--QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/9/18 =E4=B8=8B=E5=8D=883:54, Anand Jain wrote:
> On 18/9/19 2:56 PM, Qu Wenruo wrote:
>> [BUG]
>> When btrfs/011 is executed on a fast enough system (fully memory backe=
d
>> VM, with test device has unsafe cache mode), the test can fail like
>> this:
>>
>> =C2=A0=C2=A0 btrfs/011 43s ... [failed, exit status 1]- output mismatc=
h (see
>> /home/adam/xfstests-dev/results//btrfs/011.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/011.out=C2=A0=C2=A0=C2=A0=C2=A0=
 2019-07-22 14:13:44.643333326 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/adam/xfstests-dev/results//btrfs/01=
1.out.bad=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> 2019-09-18 14:49:28.308798022 +0800
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,3 +1,4 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 011
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *** test btrfs replace
>> =C2=A0=C2=A0=C2=A0=C2=A0 -*** done
>> =C2=A0=C2=A0=C2=A0=C2=A0 +failed: '/usr/bin/btrfs replace cancel /mnt/=
scratch'
>> =C2=A0=C2=A0=C2=A0=C2=A0 +(see /home/adam/xfstests-dev/results//btrfs/=
011.full for details)
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>
>> [CAUSE]
>> Looking into the full output, it shows:
>> =C2=A0=C2=A0 ...
>> =C2=A0=C2=A0 Replace from /dev/mapper/test-scratch1 to /dev/mapper/tes=
t-scratch2
>>
>> =C2=A0=C2=A0 # /usr/bin/btrfs replace start -f /dev/mapper/test-scratc=
h1
>> /dev/mapper/test-scratch2 /mnt/scratch
>> =C2=A0=C2=A0 # /usr/bin/btrfs replace cancel /mnt/scratch
>> =C2=A0=C2=A0 INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not starte=
d
>> =C2=A0=C2=A0 failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>>
>> So this means the replace is already finished before we cancel it.
>> For fast system, it's very common.
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
>> =C2=A0 tests/btrfs/011 | 16 ++++++++++++++--
>> =C2=A0 1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/btrfs/011 b/tests/btrfs/011
>> index 89bb4d11..858b00e8 100755
>> --- a/tests/btrfs/011
>> +++ b/tests/btrfs/011
>> @@ -148,13 +148,25 @@ btrfs_replace_test()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # background th=
e replace operation (no '-B' option given)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _run_btrfs_util=
_prog replace start -f $replace_options
>> $source_dev $target_dev $SCRATCH_MNT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _run_btrfs_util_prog repla=
ce cancel $SCRATCH_MNT
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 1s is enough for fast sy=
stem to finish replace, so here we
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ignore all the output, c=
ompletely rely on later status
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # output to determine
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PROG replace c=
ancel $SCRATCH_MNT &> /dev/null
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 'repla=
ce status' waits for the replace operation to finish
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # before the st=
atus is printed
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $BTRFS_UTIL_PRO=
G replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat $tmp.tmp >>=
 $seqres.full
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -q canceled $tmp.tmp =
|| _fail "btrfs replace status
>> (canceled) failed"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 grep -q -e canceled -e fin=
ished $tmp.tmp ||\
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _f=
ail "btrfs replace status (canceled) failed"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If replace finished befo=
re cancel, replace them back or
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # the final fsck after tes=
t case will fail as there is no btrfs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # on the $source_dev anymo=
re
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if grep -q -e finished $tm=
p.tmp ; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $B=
TRFS_UTIL_PROG replace start -Bf $replace_options \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 $target_dev $source_dev $SCRATCH_MNT
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "${quick}Q=
" =3D "thoroughQ" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 # On current hardware, the thorough test runs
>>
>=20
> Faced the same problem before. But I don't have a good solution
> to fix. Because the idea of the test case appears to test the replace
> cancel. This change makes it not to error if replace is not running
> in the first place.

Then what about _notrun if we find that replace/scrub finished too early?=


BTW, if we really want to test all regular scrub/replace with
cancel/finish combination, we should split this test into 4 test cases,
then we can completely afford to skip 2 while still allow the finish
cases to run...

Thanks,
Qu

>=20
> Thanks, Anand
>=20


--QYV3bekAidIfkebyOY3MASZvVMu0ZSTdT--

--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2B42gACgkQwj2R86El
/qjPkwgAitN5mXmIkv7wBsfbQTp1N1icZjWKRxR9H5Fn8lDnCg5EnMpQ6JfaNunw
DEQPIL2W2GX4rUQ78oZP8gFqz/Upi+G75Y022Myjo0KzzyS+rgLlo8OOnpSYVG80
9tv9v8Xbflu4MNI5XO+Je05Jd/ZunSW4Ru8kCf0BotflVCDqY3I4nRTQXMZhaeU3
WTgkOmvMXEGTryQTO+Z9zhLJoLMhU1x/CF6Ark/QPZIptwmAhx3NWSL7fITcK4O6
VJvtsy0oOkTJ6lixf9+y7GV1UFe6IaRRt4ROQxGyvADOo2+4o56cZgLo1dQzB2qF
V47wy5+KjaYdRKlXVew8RlRoJMr5HQ==
=Zig4
-----END PGP SIGNATURE-----

--IZnAvDqPhWzEHlqLiAxr8Y82yNduXA6kN--
