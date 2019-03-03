Received: from mail-pg1-f173.google.com ([209.85.215.173]:38889 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCCQMq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Mar 2019 11:12:46 -0500
Received: by mail-pg1-f173.google.com with SMTP id m2so1313709pgl.5
        for <fstests@vger.kernel.org>; Sun, 03 Mar 2019 08:12:45 -0800 (PST)
Message-ID: <5c7bfcfb.1c69fb81.93452.f989@mx.google.com>
Date: Mon, 04 Mar 2019 00:12:37 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 87a53d2e7c82
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kybsfciJ2ATW"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--kybsfciJ2ATW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. And again, we don't have new tests added, but there're
quite a few bug fixes and improvements. Notably, the dmlogwrites infrastructure
is able to accept replay target device as argument and generic/482 is switched
to use dm-thinp device as log replay target device, which should fix the long
standing false failure of generic/482 against v5 XFS.

Thanks,
Eryu

The new head of the master branch is commit:

87a53d2e7c82 generic/{436,445}: check falloc support

New commits:

Amir Goldstein (1):
      [87a53d2e7c82] generic/{436,445}: check falloc support

Brian Foster (2):
      [de928c8e880e] common/dmlogwrites: genericize log writes target device
      [65cc9a235919] generic/482: use thin volume as data device

Darrick J. Wong (2):
      [dd2c726684ed] fstests: don't oom the box opening tmpfiles
      [19e8b1f1a9d8] t_attr_corruption: fix this yet again

Rostislav Skudnov (1):
      [77df6c6ccfc8] fsstress: show correct offsets and length for copy_file_range

Yufen Yu (2):
      [d34e87ea0f94] generic/299: limit max file size
      [2e6fb94f9967] common/rc: add _get_max_lfs_filesize to return MAX_LFS_FILESIZE


Code Diffstat:

 common/dmlogwrites      | 24 ++++++++++++++++++------
 common/rc               | 39 +++++++++++++++++++++++++++++++++++++++
 ltp/fsstress.c          | 21 +++++++++++++++++----
 src/t_attr_corruption.c | 28 ++++++++++++++--------------
 tests/generic/299       |  6 ++++++
 tests/generic/349       | 12 +-----------
 tests/generic/350       | 12 +-----------
 tests/generic/351       | 12 +-----------
 tests/generic/436       |  2 ++
 tests/generic/445       |  2 ++
 tests/generic/455       |  8 ++++----
 tests/generic/457       |  8 ++++----
 tests/generic/470       |  4 ++--
 tests/generic/482       | 24 ++++++++++++++++--------
 tests/generic/485       | 25 +------------------------
 tests/generic/530       |  4 ++--
 tests/generic/531       |  4 ++--
 tests/generic/group     |  4 ++--
 tests/xfs/501           |  4 ++--
 tests/xfs/502           |  4 ++--
 20 files changed, 138 insertions(+), 109 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kybsfciJ2ATW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJce/uKAAoJECZSqilcj+dj8RsQAOcw0xzzZkbspgQ4VBulvIFA
iaE0fM86ZwTbiGOR4wGA1VhtNQP6cqCEY2zd6ymA4XCJUP2+IbqXRJZrZ6SA6SSU
a/oDcHJtbcb978kNGLD4YkqOJ53nqSxd7T4pqG/BjK58KkYyEsJ1Uwkmyna9wOuW
3FPNE4GPcqhm2IZACE92ez0FovSoLlMfo/u5BLhh7yoFoDPG0VziYi53zrA6dyUf
oQX2M4HluwlzUCEl/8w1HYKoNMcIS7bExrsmXNNWvDrds4+mQdSWSpAwcrOiQtrV
BZc+B9s3B/34Glcd0mNnITl7dClaQxwxZGH45kAS2mPjqOAL+7veIY8caag++lGK
DXFhnjNIErfVKm5UE668+EAJgUQTYK+7SAge8kfIPVm/MlayC39x+ad55UMX+o3N
Txjsqae5Alv/+dAImDKiju3lr4pfAEFb3QDcxINhTwDRu9hXFs2U6OEI9ga3uDUv
emzimXa8jBgiLsxD3s0o6AIVEzB1Qul0QvygoCK43orlXvYmXEKxzSUKZ3O3+UvZ
USTST6K5eA3Y7ZF5eCcq+Y6htJcjXHkRRspyPihzFP+JNgpdrjHqA6ejdxRr3210
YiwJ0xYKGvvfdGsb4IlK4AV9q4kD7fiqtt0uutGqlFmcTKBb88NAx4YiAfxC3zgG
3GLuMOOgcsWoM5qTPSFH
=cM7J
-----END PGP SIGNATURE-----

--kybsfciJ2ATW--
