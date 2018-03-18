Received: from mail-pl0-f46.google.com ([209.85.160.46]:36858 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeCRLqn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 18 Mar 2018 07:46:43 -0400
Received: by mail-pl0-f46.google.com with SMTP id 61-v6so8578930plf.3
        for <fstests@vger.kernel.org>; Sun, 18 Mar 2018 04:46:43 -0700 (PDT)
Message-ID: <5aae51a1.08be620a.1122f.9c6f@mx.google.com>
Date: Sun, 18 Mar 2018 19:46:35 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 6898b0f507ac
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RfXg0k9RQrjx"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--RfXg0k9RQrjx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly contains two new tests for generic
and overlay. Many thanks to all the patch authors and reviewers!

New failures I've noticed in this update:
- overlay/057 currently fails on latest Linus tree

Thanks,
Eryu

The new head of the master branch is commit:

6898b0f507ac generic/015: Issue sync after deleting the fillup file

New commits:

Liu Bo (1):
      [2fcd134d3939] generic: test on creating new file after log replay

Nikolay Borisov (1):
      [6898b0f507ac] generic/015: Issue sync after deleting the fillup file

Vivek Goyal (1):
      [1afc31f99dd6] overlay: Absolute redirect should be followed even if ancestor is opaque


Code Diffstat:

 tests/generic/015     |   2 +
 tests/generic/481     |  76 +++++++++++++++++++++++++++++++++++++
 tests/generic/481.out |   2 +
 tests/generic/group   |   1 +
 tests/overlay/057     | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/057.out |   3 ++
 tests/overlay/group   |   1 +
 7 files changed, 188 insertions(+)
--
Eryu Guan
guaneryu@gmail.com

--RfXg0k9RQrjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJarlD+AAoJECZSqilcj+dj1kAQAKg1XzUqHaV/07ai3a5KleSf
mNlemOlB9QXWllPf8Mekvb/TDsk+4DjgNINhj5BoH+4m7Ci99MEelbDKhtI9UycT
5vCxnUmjtmKZztm6+xi7p9GCTpq9CnNyPE4c41/b8Jd9Bba5oOdIk1NQB8oJVEZb
ITh7JHuKXz3+SPpK0xTiqPkyCURF5qEEW4wfbOOaIvofLJlKrv0fL9YqqkRd8/x/
6t4GRjNPM/xRxxtCRVaz0pcM9mF/kkFWI/7NHbHcfZY4Hbaf31D4zZLhajRrkoPw
qKmidOoh/CztOBb3vvt++lPhStZuYaEIiF1lR5+aAyrIoqbI86ywYqidyZMMuBuW
DylU7JEFsxoeJpAPkdXozMSdKheMRwt3Y8qK2FeGQDgsuQcn/3AUxa/0yuNR4H/B
EIua18q3L9IBGzGVZ5Zd1r4LmOKK52/t7Sse+PW4z7wQEfp/fskgPZvUPasLZRs4
NLxJaTuVdt8SwP/vSGZILe568A+oy1HkcggmNjkfEvaQUIeJ40RLVq3x5t7I4if0
9rwxQDYkhH+ErAj/03imqT4WgxtO/lUzlqM8Evq6gAAXPKX1ix7nBGfcWhmHQtAs
tOwaEQRT9U+8XePLgmbH1fl+ObMd8VjmlepqmlO0w5BlSOx5ceLHAtu2D4C5g6Nm
PSptKqGCMDG3s8dHdg2z
=yswy
-----END PGP SIGNATURE-----

--RfXg0k9RQrjx--
