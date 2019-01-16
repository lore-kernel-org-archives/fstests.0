Received: from mout.gmx.net ([212.227.15.18]:55411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727550AbfAPB7p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 15 Jan 2019 20:59:45 -0500
Received: from [0.0.0.0] ([210.140.77.29]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MQ2zr-1getnY0GJv-005Gra for
 <fstests@vger.kernel.org>; Wed, 16 Jan 2019 02:59:43 +0100
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Any way to detect performance in a test case?
Message-ID: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
Date: Wed, 16 Jan 2019 09:59:40 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZTGF5Q0swZUcI5zG1p3zF9bNHgQeoHxPV"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZTGF5Q0swZUcI5zG1p3zF9bNHgQeoHxPV
Content-Type: multipart/mixed; boundary="6SztOTJxlOYTu9K4FNrXdWBtMViTN39Ml";
 protected-headers="v1"
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: fstests <fstests@vger.kernel.org>
Message-ID: <f5404232-3b9a-6bb6-9841-a2a56f314e51@gmx.com>
Subject: Any way to detect performance in a test case?

--6SztOTJxlOYTu9K4FNrXdWBtMViTN39Ml
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any way to detect (huge) performance regression in a test case?

By huge performance regression, I mean some operation takes from less
than 10s to around 400s.

There is existing runtime accounting, but we can't do it inside a test
case (or can we?)

So is there any way to detect huge performance regression in a test case?=


Thanks,
Qu


--6SztOTJxlOYTu9K4FNrXdWBtMViTN39Ml--

--ZTGF5Q0swZUcI5zG1p3zF9bNHgQeoHxPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlw+kAwACgkQwj2R86El
/qjUAQf/XhUNUj6hTXyLcVqB1NBkLH7eT220HVSoz5ibOlB7kp73S3Tfm6lMn5OD
JCFcMlH5gopQh75X09W9s+xSfd1n/HEk4hfqz0d9IDWoRdzy0j9D6h8Ly6UqbRyz
QTSsmfKwWijlUdts0N+sFGrksKo6djDiMcRUlmircDq452hvPjGSN4QqoKYJaz+m
v/Jplh9Zn4AT8pkGbpXng8dwSR+Egz4Bh4L9MNRPFXeTwH99EvBqVA5MiR0aOxp+
xErTi2JcCxiLZ/wS6zdxMWmJisWVcTSbx9AdtXkohuCrtHnKcLIXADVge4F8QSW2
bDTn79EANOKrcBCpDqd0kou4X7vASg==
=hoUA
-----END PGP SIGNATURE-----

--ZTGF5Q0swZUcI5zG1p3zF9bNHgQeoHxPV--
