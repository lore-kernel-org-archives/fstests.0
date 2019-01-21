Received: from mail-pl1-f180.google.com ([209.85.214.180]:36461 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbfAUHS5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Jan 2019 02:18:57 -0500
Received: by mail-pl1-f180.google.com with SMTP id g9so9380904plo.3
        for <fstests@vger.kernel.org>; Sun, 20 Jan 2019 23:18:57 -0800 (PST)
Message-ID: <5c452847.1c69fb81.a0ae1.e808@mx.google.com>
Date: Mon, 21 Jan 2019 10:02:42 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 23703a8d22db
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="d00Yqa4GY6eh"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--d00Yqa4GY6eh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update only contains two new tests, and currently
the new overlay test fails with latest kernel, the generic one fails on XFS.

Thanks,
Eryu

The new head of the master branch is commit:

23703a8d22db overlay: File capabilities should not be lost over copy-up

New commits:

Brian Foster (1):
      [be5dedec18d2] generic: test writepage cached mapping validity

Vivek Goyal (1):
      [23703a8d22db] overlay: File capabilities should not be lost over copy-up


Code Diffstat:

 tests/generic/524     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/524.out |  2 ++
 tests/generic/group   |  1 +
 tests/overlay/064     | 60 ++++++++++++++++++++++++++++++++++++++
 tests/overlay/064.out |  2 ++
 tests/overlay/group   |  1 +
 6 files changed, 146 insertions(+)
--
Eryu Guan
guaneryu@gmail.com

--d00Yqa4GY6eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJcRH+KAAoJECZSqilcj+dj8+UQAJ33+BGEGaP8b5ETWXflHTs7
UyGWYZlU59QHYW57iD35mRVU8LoGt2f9nc4N8my+EIISlw+6vHmEg/JPc7ZjOudV
xA5e7KfuqN0HuZSM8zdDBwddjD0hO25bcsAUH0ORaEamiXp2LNm0/XPG1lmK5sIL
jwUb1IElZ/W7nANCcBLKZif/rMUJc7zwsUPY7vDAkrPTPdCWrswT49fIv1sha7jR
mQb10GQ1dmUR9MYHvNroxZpNeecXrSUSbmTrDWu74JnjheO1ar0ARWekQaxJzYDe
ir+ivVRTqEANZdgVeSX+cqsUS3/tI3JkYM8nGblN8egOD8E8T9dtIo1wr9FMu1Q5
K2VjKm0m6E8JfBQfVwaVayfiNQ0sQdY3DV/sdRn8W5Pc+LGV3tf0X9AKIRSEXmmL
yrfHfRXKwLWd2l4eSScBbJw2qdJqAKODiN6gQ5yG+m3jG5x6ciI4oqhPL9GGYuJv
6Q84cADxm9eVPlf9EsDVIn51+VJFRM6uVFtDD86ZY/wxWWn4wwAeJn9StUou59ES
HvxDkedG/4b2jqdQkg1CNJgdVVp4x9L/MIlTKXwH/kj+kNkpnVsBSWzq40SHF1Dh
gylh4EaOX7AD5nBaZyaxCeGIaJJl3+LzP8ZSgeskiDRVTZ3C/dHhdJKF/h9DDRdM
2L9+vWuz40sMvCDNFvcY
=WJSq
-----END PGP SIGNATURE-----

--d00Yqa4GY6eh--
