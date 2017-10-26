Received: from mout.gmx.net ([212.227.15.19]:49861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbdJZHdG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Oct 2017 03:33:06 -0400
Subject: Re: [PATCH] xfstests: Add message indicating btrfs-progs support FST
 in read-only mode
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
 <20171026065218.GK3235@eguan.usersys.redhat.com>
 <53ac8baa-1a31-a428-b02f-ecd32fb5222f@gmx.com>
Message-ID: <951b24f7-6617-0f95-c1f3-e5fb86f04b0e@gmx.com>
Date: Thu, 26 Oct 2017 15:32:48 +0800
MIME-Version: 1.0
In-Reply-To: <53ac8baa-1a31-a428-b02f-ecd32fb5222f@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7dBUdfXIJ8gxvdqAvLC7seiGnVJeeWqVT"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Gu Jinxiang <gujx@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7dBUdfXIJ8gxvdqAvLC7seiGnVJeeWqVT
Content-Type: multipart/mixed; boundary="3Rkx1SFlRb37X6twIwSNVLcPPI9mvADJQ";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <eguan@redhat.com>, Gu Jinxiang <gujx@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <951b24f7-6617-0f95-c1f3-e5fb86f04b0e@gmx.com>
Subject: Re: [PATCH] xfstests: Add message indicating btrfs-progs support FST
 in read-only mode
References: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
 <20171026065218.GK3235@eguan.usersys.redhat.com>
 <53ac8baa-1a31-a428-b02f-ecd32fb5222f@gmx.com>
In-Reply-To: <53ac8baa-1a31-a428-b02f-ecd32fb5222f@gmx.com>

--3Rkx1SFlRb37X6twIwSNVLcPPI9mvADJQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2017=E5=B9=B410=E6=9C=8826=E6=97=A5 15:13, Qu Wenruo wrote:
>=20
>=20
> On 2017=E5=B9=B410=E6=9C=8826=E6=97=A5 14:52, Eryu Guan wrote:
>> On Thu, Oct 26, 2017 at 01:57:46PM +0800, Gu Jinxiang wrote:
>>> From: Gu JinXiang <gujx@cn.fujitsu.com>
>>>
>>> btrfs-progs now support FST in read-only mode, so when space_cache=3D=
v2
>>> enabled, this test case will fail.
>>> Add message to help user to understand this status.
>>
>> Sorry, I don't quite understand the new 'FST' feature.
>=20
> FST is Free Space (cache) Tree, which is one of the internal methods to=

> manage the free space cache for btrfs.
>=20
>=20
>> But is it a bug
>> that we want to fix when mounting with space_cache=3Dv2 option, or we =
just
>> couldn't do btrfs-convert in this case? If it's a real bug, I'd say le=
t
>> the test fail as it is, and track bug in tools like bugzilla not
>> comments/messages in the test; if it's the latter case, then just
>> _notrun the test if space_cache=3Dv2 option is specified, e.g.
>=20
> The problem is not about the kernel, it's btrfs-convert to blame, which=

> can't handle free space cache tree.
>=20
> However, since btrfs-convert is just rollbacking the btrfs to ext*, it
> doesn't really need to do any write to *btrfs*, so the correct method
> here is to fix btrfs-convert rollback, to do a *readonly* open other
> than RW open, other than skipping special mount option.
>=20
> I'll fix it soon.

Here comes the fix for btrfs-progs.
https://patchwork.kernel.org/patch/10027529/

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> _exclude_scratch_mount_option "space_cache=3Dv2"
>>
>> Thanks,
>> Eryu
>>
>>>
>>> Signed-off-by: Gu JinXiang <gujx@cn.fujitsu.com>
>>> ---
>>>  tests/btrfs/012 | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>>> index 85c82f07..529e6eca 100755
>>> --- a/tests/btrfs/012
>>> +++ b/tests/btrfs/012
>>> @@ -96,6 +96,12 @@ cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
>>> =20
>>>  _scratch_unmount
>>> =20
>>> +space_cache_version=3D$(echo "$MOUNT_OPTIONS" | grep "space_cache=3D=
v2")
>>> +if [ -n "$space_cache_version" ]; then
>>> +	_fail "since used space_cache=3Dv2 when mount," \
>>> +	       "and for FST btrfs-progs support is read-only."\
>>> +	      "so btrfs-convert rollback will fail"
>>> +fi
>>>  # Now restore the ext4 device
>>>  $BTRFS_CONVERT_PROG -r $SCRATCH_DEV >> $seqres.full 2>&1 || \
>>>  	_fail "btrfs-convert rollback failed"
>>> --=20
>>> 2.13.5
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in=

>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-btrfs"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20


--3Rkx1SFlRb37X6twIwSNVLcPPI9mvADJQ--

--7dBUdfXIJ8gxvdqAvLC7seiGnVJeeWqVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnxj6AXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qjOeAf+NYxjpMkL0o9VqZONwdqlzKQg
f04RHpHLXVEBOAVtysfBBptYdnKXjPIVE2iKZ7m9rHGczGsx3xMKWunGI+J/KrTa
0ZHCdJlCza1lRXyxPxw4NkDsPAQOUHtFMpHoEa0psCnk1W7mH3zq1Be7DDwKGCuo
zUp5j4vuh/gRljmSAmESKksL9+sPH7btktBPbr5m2UdE4Q4uNX5vW/reRmPr4uBq
9K5B5L59fNXwpVcWfnvI42losg4FnNoTeZCsUpd2f5Yfdt8oTw+Ghxc4t0LQ1tEm
ICbgQ3eax49es+j/pSDpF99UQMTApcsJHJgwC29aJxGw0w0uiohlg7ZGrXG5CA==
=nHS2
-----END PGP SIGNATURE-----

--7dBUdfXIJ8gxvdqAvLC7seiGnVJeeWqVT--
