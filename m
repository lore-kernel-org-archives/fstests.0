Received: from mx2.suse.de ([195.135.220.15]:33558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfBZBjm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 25 Feb 2019 20:39:42 -0500
Subject: Re: [PATCH] src/t_attr_corruption: use security.capability instead of
 security.evm
References: <20190225191052.15342-1-jeffm@suse.com>
 <20190225224744.GY6503@magnolia>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <e802b52f-8878-6c0e-b2e3-8ed2d200b520@suse.com>
Date: Mon, 25 Feb 2019 20:39:38 -0500
MIME-Version: 1.0
In-Reply-To: <20190225224744.GY6503@magnolia>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yNnEPdI9B5WP4gtX8QASPR8nf2EI4zSVq"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNnEPdI9B5WP4gtX8QASPR8nf2EI4zSVq
Content-Type: multipart/mixed; boundary="hKzv0vuT4WsBIP1C7FwWBuBbYSoOdT2zl";
 protected-headers="v1"
From: Jeff Mahoney <jeffm@suse.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
Message-ID: <e802b52f-8878-6c0e-b2e3-8ed2d200b520@suse.com>
Subject: Re: [PATCH] src/t_attr_corruption: use security.capability instead of
 security.evm
References: <20190225191052.15342-1-jeffm@suse.com>
 <20190225224744.GY6503@magnolia>
In-Reply-To: <20190225224744.GY6503@magnolia>

--hKzv0vuT4WsBIP1C7FwWBuBbYSoOdT2zl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/25/19 5:47 PM, Darrick J. Wong wrote:
> On Mon, Feb 25, 2019 at 02:10:52PM -0500, jeffm@suse.com wrote:
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> src/t_attr_corruption uses the security.evm extended attribute because=

>> it sorts before security.posix_acl_access.  The security.evm attribute=

>> is a formatted structure and when passed an uninitialized buffer, it
>> will fail with EPERM.
>>
>> We see test failures like:
>>     --- tests/generic/529.out2019-02-21 13:22:47.583406922 -0500
>>     +++ /opt/xfstests/results//generic/529.out.bad 2019-02-21 13:57:31=
=2E967406922 -0500
>>     @@ -1,2 +1,2 @@
>>      QA output created by 529
>>     -list attr: Numerical result out of range
>>     +set evm: Operation not permitted
>>
>> This patch uses security.capability which also sorts where it needs to=

>> do for the test and also accepts an unformatted buffer.
>>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>>  src/t_attr_corruption.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/t_attr_corruption.c b/src/t_attr_corruption.c
>> index f26611f9..0c229dbc 100644
>> --- a/src/t_attr_corruption.c
>> +++ b/src/t_attr_corruption.c
>> @@ -76,7 +76,7 @@ int main(int argc, char *argv[])
>>  	if (ret)
>>  		die("set posix acl");
>> =20
>> -	ret =3D fsetxattr(fd, "security.evm", buf, 1, 1);
>> +	ret =3D fsetxattr(fd, "security.capability", buf, 1, 1);
>=20
> This fails for me both with and without EVM configured into my kernel:
>=20
> fsetxattr(3, "security.capability", "\3", 1, XATTR_CREATE) =3D -1 EINVA=
L (Invalid argument)
>=20
> Judging from fs/xattr.c it looks as though security.capability also has=

> a defined format that's parsed by security/commoncap.c...

Huh.  Ok.  That worked on my SLE12 SP3 host (4.4.x) but now that I test
it on a 5.0-rc, I get EINVAL too.  It looks like prior to v3 caps
(v4.14), validation only happened when they were loaded as part of
prepare_binprm.

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--hKzv0vuT4WsBIP1C7FwWBuBbYSoOdT2zl--

--yNnEPdI9B5WP4gtX8QASPR8nf2EI4zSVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE8wzgbmZ74SnKPwtDHntLYyF55bIFAlx0mNoACgkQHntLYyF5
5bJSyBAAkBkBue5GqL+8xSDAbGQJoiGPzbnOsigJdYmZgwhHU43Cr4/OHWz4ViGW
igx+iqPMGiKZnY6u9VA58AwTNhsyD5AbgNqfJXRlblhaq2BdSCqSAnykZhD0fkUa
1FMSYRhWXbE77HF4Px7ZfWG8H73S9CUQsL1mFe7r7DTQ+zIH5UUWhXeg+JL5Ug38
t3LxC4+a2qftYnoGjn1GunVKLWsXi4gT0OTl6YAKwdL6KqCeiOuyAsqQpRQs0iO3
l8df4dczDn/GpKgYauV0ZYt/KqX33tBgCS6YwjFIX4T6iDpDxE8pgo2Jkx1k/A5e
a4syMTT0pFeRvk8R5BY8D8mRH6TLdQtcMjcWDe194zJ+9YsC1tHo6x0p3OE/GwMG
+wMmQIwdRri76aXNMRRURH6wFJ0VdR2BxiDMUJNntgkUy4MaiqvUCaoeTxVJUFLI
a+xynRnknl0VVttRL3N5bp8FAokJ/zeoJiGKQNn5r6Ib7xz3Jl+EL5SOkj7czayp
IN+pbFj4YsAX5RQpTcWBacZO19fD5psGXta6MN1/X6PL07qv3Y3GDmAk8shUZKwt
3xG15lmUL5V35rBSkrvy2HBy8di+rYBAtXDoUtcLLrG9LRL3PzNMRm7pCg2N08gO
54A6S/GooFwSvO4rnEpvtYF1eS4lFw+ymgnpCJ+r4GUeF27G9xo=
=5r/v
-----END PGP SIGNATURE-----

--yNnEPdI9B5WP4gtX8QASPR8nf2EI4zSVq--
