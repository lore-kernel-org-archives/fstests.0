Received: from mail-pf1-f176.google.com ([209.85.210.176]:33568 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCQPpq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Mar 2019 11:45:46 -0400
Received: by mail-pf1-f176.google.com with SMTP id i19so9573256pfd.0
        for <fstests@vger.kernel.org>; Sun, 17 Mar 2019 08:45:45 -0700 (PDT)
Message-ID: <5c8e6ba7.1c69fb81.afe3b.7663@mx.google.com>
Date: Sun, 17 Mar 2019 23:45:39 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 86ce63ac21e4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mEkPYGqPWTrC"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--mEkPYGqPWTrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a small update that only contains one commit to
fix fscrypt rename/link behavior.

Thanks,
Eryu

The new head of the master branch is commit:

86ce63ac21e4 generic/398: accept EXDEV for rename or link into encrypted dir

New commits:

Eric Biggers (1):
      [86ce63ac21e4] generic/398: accept EXDEV for rename or link into encrypted dir


Code Diffstat:

 tests/generic/398     | 69 +++++++++++++++++++++++++++++----------------------
 tests/generic/398.out | 22 +++++++---------
 2 files changed, 49 insertions(+), 42 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--mEkPYGqPWTrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcjmthAAoJECZSqilcj+dj6/sQAJktNfp2bTqKhOYTQcU0RAx3
KM4VMHUX/9E14UDohRY2bsmZDxmv/sQonp04X1vEIlZ5v+u5EGwlTk5Qeiliiwap
SggEcHp9TSTpy0zPBZjuTOc3hj6Nwyipc4W2g24C8VC8eeiCtXNIVZFn7K8kmOrv
5HtUn8SSNbCOv9nmmubZSf+uhkDdUQF2SJAFaSXGwsb0/gZmx6kgFwMtN5WRbvl3
MuqlqeLRGHymGsmj3Vc4MLslYGcg2VS5/UL5973Vf97uVFflo5a+uPtFdLZJu/2M
3N8lmR6s8HtW9sGDzeV36+Akxcozl4WY3ERBPAsjW9s2woBWm0AjzhzvIjW3/Mu5
cWq9bYEOv+fLziqWHL65cKu/pThIisVeC4BAzZA72kwd2iEK6pjLqyqV9Jbuo+gH
5YytkVjpi3UAcatB/NE+hI/m8CZFDCQhLuBcxGk9q0z9jP//NgprElFeu/xuHPIR
NM3lFcF1vGae1FMRAIsihFh5paOTNr6dzitbqr2YDLU2arLAUCysDvc6CrRrdr5R
vXtijAHzRnmH4u+v1yi84AKFdoB8QEbiywTewIq0QxH87vJJg4tak7tB6hU8w8gJ
IYo5JoNB/bRf6R18/l6mCEzB89ipFV4Y9IsC560rUdGdMMJItR0k7Jf8GWJXoKfo
7Au+Zt0DWhFzSIv72M5Y
=39Jl
-----END PGP SIGNATURE-----

--mEkPYGqPWTrC--
