Received: from mout.gmx.net ([212.227.15.19]:53668 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbdLFHqp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Dec 2017 02:46:45 -0500
Subject: Re: [PATCH] btrfs/057: Fix test case to work on 64K page size
References: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
 <20171206073516.GQ2749@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ce94337e-2c4d-6b16-1a7d-076a3dccc5b2@gmx.com>
Date: Wed, 6 Dec 2017 15:46:32 +0800
MIME-Version: 1.0
In-Reply-To: <20171206073516.GQ2749@eguan.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mq1vSUrKruifD1rwMfXSveNfrWAWVesNX"
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, Harish <harish@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mq1vSUrKruifD1rwMfXSveNfrWAWVesNX
Content-Type: multipart/mixed; boundary="n16NunifGbjdgsgBRQReTMsisd76cNJHb";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Eryu Guan <eguan@redhat.com>, Harish <harish@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Message-ID: <ce94337e-2c4d-6b16-1a7d-076a3dccc5b2@gmx.com>
Subject: Re: [PATCH] btrfs/057: Fix test case to work on 64K page size
References: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
 <20171206073516.GQ2749@eguan.usersys.redhat.com>
In-Reply-To: <20171206073516.GQ2749@eguan.usersys.redhat.com>

--n16NunifGbjdgsgBRQReTMsisd76cNJHb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2017=E5=B9=B412=E6=9C=8806=E6=97=A5 15:35, Eryu Guan wrote:
> On Wed, Dec 06, 2017 at 12:15:45PM +0530, Harish wrote:
>> On platforms with a page size greater than 4Kb, at the moment btrfs
>> doesn't support a node/leaf size smaller than the page size, but it
>> supports a larger one. So use the max supported node size (64Kb) so
>> that the test runs on any platform currently supported by Linux.
>>
>> Signed-off-by: Harish <harish@linux.vnet.ibm.com>
>=20
> Looks fine to me. Also cc btrfs list for review.
>=20
> Thanks,
> Eryu
>=20
>> ---
>>  tests/btrfs/057     | 7 +++++--
>>  tests/btrfs/057.out | 4 ++--
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/btrfs/057 b/tests/btrfs/057
>> index 8d35579..06b2be9 100755
>> --- a/tests/btrfs/057
>> +++ b/tests/btrfs/057
>> @@ -48,8 +48,11 @@ _require_scratch
>> =20
>>  rm -f $seqres.full
>> =20
>> -# use small leaf size to get higher btree height.
>> -run_check _scratch_mkfs "-b 1g --nodesize 4096"
>> +# Currently in btrfs the node/leaf size can not be smaller than the p=
age
>> +# size (but it can be greater than the page size). So use the largest=

>> +# supported node/leaf size (64Kb) so that the test can run on any pla=
tform
>> +# that Linux supports.
>> +run_check _scratch_mkfs "-b 1g --nodesize 65536"

Personally speaking, the test doesn't really need super high tree height.=

So I think it's OK to use a different node size.

But I prefer default mkfs.btrfs, which will choose valid nodesize.
So for 4K system, it will use default 16K other than always using the
64K nodesize.


And further more, the test case is quite old, from the old days when we
did even have btrfs check support for qgroup.

With new btrfs check support, we don't really need to do anything to
check qgroup numbers in test cases, just let fstests post test routines
to handle it.

If qgroup is corrupted, fstests will report something inconsistent
filesystem at post test fsck.
Just like what we do in btrfs/126. (so no need to use any magic number
in 057.out)

So would you please also update the test case to get benefit from the
newer btrfs-progs?

Thanks,
Qu

>> =20
>>  # inode cache is saved in the FS tree itself for every
>>  # individual FS tree,that affects the sizes reported by qgroup show
>> diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
>> index 60cb92d..f2d9e9c 100644
>> --- a/tests/btrfs/057.out
>> +++ b/tests/btrfs/057.out
>> @@ -1,3 +1,3 @@
>>  QA output created by 057
>> -4096 4096
>> -4096 4096
>> +65536 65536
>> +65536 65536
>> --=20
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--n16NunifGbjdgsgBRQReTMsisd76cNJHb--

--mq1vSUrKruifD1rwMfXSveNfrWAWVesNX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAlonoFkXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qhmHgf/ZO+ThpcVe0aOYmigmbIjhoFT
SD3jxOH+U8jpIZ8fkl+5ivAWWGXyqszhtgG0sP95a0RgIUSeJHpkapf+RaEgp6lb
q9RkBOpOWkc7L4pdTu8UUN7fO4EQU5limnmNGaWOO9SG0StSJzP8Ww9hutXGufLx
ylHr7nkFMj4Tcksjl03l9BUsKlDLr+wrXq/klhK6ZCe1o7EqeNkV38dzJYFcmHhj
OtjwFzTKQkokPoJFTrQJ0EkPwVqKexOscI4gI5SD+o4nnXPNJtP/aEvuqPfwozZl
ZhQP19mQ7V5bwQXpIhZgrrRHKfuYAod0MEdNByiivnmBwCH6cmNLAFXk+blKXw==
=2esn
-----END PGP SIGNATURE-----

--mq1vSUrKruifD1rwMfXSveNfrWAWVesNX--
