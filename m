Received: from mx2.suse.de ([195.135.220.15]:55070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfC0HyF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Mar 2019 03:54:05 -0400
From: Qu Wenruo <wqu@suse.de>
Subject: Is log-writes project still maintained or the one in fstests is the
 official tool?
Message-ID: <151f1161-a338-37dd-8e65-26fc5fd45f8d@suse.de>
Date: Wed, 27 Mar 2019 15:53:59 +0800
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GIPEKozuIt55LarCX9bLgCiy6xtK2FL7K"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
List-ID: <fstests@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GIPEKozuIt55LarCX9bLgCiy6xtK2FL7K
Content-Type: multipart/mixed; boundary="HkoD7XmYp07HVu0ezfsr8a4m5Xnrdf47P";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.de>
To: fstests <fstests@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Message-ID: <151f1161-a338-37dd-8e65-26fc5fd45f8d@suse.de>
Subject: Is log-writes project still maintained or the one in fstests is the
 official tool?

--HkoD7XmYp07HVu0ezfsr8a4m5Xnrdf47P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Is the log-writes tool in fstests/src the latest and maintain version?

The one in Josef's github hasn't been updated for over one year, and it
seems the output from fstests is different from Josef's.

I'm wondering for new patches where should they go?

Thanks,
Qu


--HkoD7XmYp07HVu0ezfsr8a4m5Xnrdf47P--

--GIPEKozuIt55LarCX9bLgCiy6xtK2FL7K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlybLBcACgkQwj2R86El
/qhHtAgAsmBXZM4qrZgHJchHOEjmpQ3De9xXC/GuvHLs9aHU5EAQ5ySlv8qUJ3ss
DCOy3GZqPVXN1rvUmMKj4/VhzcmbKUVa0t7H33ySU42RQvd/pLG2BkCkWhGLXi7N
mlVlucX/l4AgrI1UDrftli6m1FB6qJYnWDD9w/bwKIFnflZPivK3CdQXMi7R527M
mLJUcMfRKdygvXCPuk7Uu+Kq4Da6xx6eZFPhc8PZ3BPcMJ2LQwkCHm4XWtuIOlWu
aZ7Wys/sUtkuguOCdaC6NeKCVOREILG43IMCIwgyHUUfxpLvVNgXlJPtPc5tYtI0
o7uWpaWCADFf6kFxoiR/PTGvXkrkOw==
=wbf5
-----END PGP SIGNATURE-----

--GIPEKozuIt55LarCX9bLgCiy6xtK2FL7K--
