Received: from mout.gmx.net ([212.227.17.22]:36285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeKNKbz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 14 Nov 2018 05:31:55 -0500
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LrrRi-1fLVFy0XtO-013bRk for
 <fstests@vger.kernel.org>; Wed, 14 Nov 2018 01:31:09 +0100
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Any method to limit page cache usage in test cases?
Message-ID: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
Date: Wed, 14 Nov 2018 08:31:05 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XEmx42r8NJJuICiu6g2VfD2Uu7pjtzi6g"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XEmx42r8NJJuICiu6g2VfD2Uu7pjtzi6g
Content-Type: multipart/mixed; boundary="RFL5isE5aArM7P7gN2P8vU2clmto8plQg";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fstests <fstests@vger.kernel.org>
Message-ID: <55b117b2-f683-7754-dbf6-232efbd617de@gmx.com>
Subject: Any method to limit page cache usage in test cases?

--RFL5isE5aArM7P7gN2P8vU2clmto8plQg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any (easy) method for a fstests test case to limit the page
cache usage?

I triggered btrfs/139 failure with 2G vRAM VM, and located the root
cause of the problem.

However it's only really reproducible for small ram VM, since it could
trigger dirty page writeback due to memory pressure.

So I'm wondering if we could do such thing even for large RAM test machin=
e.

Thanks,
Qu


--RFL5isE5aArM7P7gN2P8vU2clmto8plQg--

--XEmx42r8NJJuICiu6g2VfD2Uu7pjtzi6g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlvrbMkACgkQwj2R86El
/qh/6wf/bBXwYyO3X8Aun1yGToApOpNKB+JH/u/bKmau6SK0OkcZnoar3WeOg/Zv
PRW7Kk/l+Tt0po+qPbAzU1JhN6Is29k63lgfdG4TdUdLzCTFuqq2Ve7uXa8AIVjG
CTz9P/Xxee6tFTfhxVa4CFoZraxKq90+fPK7skg5IOOxqocQZL5QLz4SYZllc2I0
pEaEu25l5x6YVAdDp9yjL/azpHzv9sl4mZm/3hVXpXq8/hAzHiAXEI51/CubdJ4m
dYIDxl95EmKO8X0FnQBe5Vmd7U31CuLNWZ1aK8eYpg2dBhJSNPqae8lA7YmjngAr
Wnmz7y8yye2aY3FKoT1xKaFtqL94Xg==
=wMvp
-----END PGP SIGNATURE-----

--XEmx42r8NJJuICiu6g2VfD2Uu7pjtzi6g--
