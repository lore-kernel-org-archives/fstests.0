Received: from mail-pg1-f182.google.com ([209.85.215.182]:43713 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeIIUvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Sep 2018 16:51:14 -0400
Received: by mail-pg1-f182.google.com with SMTP id v66-v6so9207312pgb.10
        for <fstests@vger.kernel.org>; Sun, 09 Sep 2018 09:01:07 -0700 (PDT)
Message-ID: <5b9543c1.1c69fb81.c248.5d0d@mx.google.com>
Date: Mon, 10 Sep 2018 00:00:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 047562e1dcfb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K9pQOHvUyWlL"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--K9pQOHvUyWlL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're only a few minor improvements in this update,
no new failures are expected.

Thanks,
Eryu

The new head of the master branch is commit:

047562e1dcfb generic/498: don't call _cleanup_flakey repeatedly

New commits:

Lu Fengqi (1):
      [047562e1dcfb] generic/498: don't call _cleanup_flakey repeatedly

Miklos Szeredi (1):
      [264e5358e2c2] tmpfs: don't require {TEST|SCRATCH}_DEV

Xiao Yang (1):
      [860405a41198] generic/504: Check inode number accurately


Code Diffstat:

 common/config     | 12 +++++++++++-
 tests/generic/498 |  1 -
 tests/generic/504 |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--K9pQOHvUyWlL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJblUNmAAoJECZSqilcj+djd1cQANAT6sBc1Q6iejKVeBUXOErX
PtH3WvKEeyR0/xbFL8sGQgO8eCoTgFRA/0NqiKeI5bTH865UakxMAvP7ABEczqSg
3B7RYaZIO86YNT1XtoZgy/42D01sOFd1OZhjXSr+rtbFMr9RLRgMMB/BaIhVNlPG
0XBjwSuhTeGsERtnLUFqy6Y+QaPjlz2YMpF4BhE9Oa/UN9z1lIss4dmJfb4sQXW/
aQ56QQGyZahNktNPUhi8WmQT+de3z9Bukf17trZjKos9gqk0AnvYHSbDF3U9j6+n
MHc6JP3+mj8tTotzAQMfZD9EaYOI0gfGN0lDdpHCS9VmDlnCzXzG5/zYPljHbiFB
+fP2JXBjxXTqnEzKNmJEHXZG81MeOjioRa4Pn4yZiEG0hMmurfjZfY/2AtaneRuS
EAX/vsdluqqR3oePTDJ+hHhA7cg4GbFtFZbanetBF72aQSahXQNB0ERJAiHbLyLU
m0yQXenOV6zdR22sfY4hfa61ea6mSy65be9OV8NgDXaOvNOtot6ka27BGbW7B3h9
LTvjhRUuZoFjVwp1zJXzu7wH4Q7BX0IwKRN3tagrNzaKQw7+oMU/Cop5jw39v+9R
GfniK7QuoHcPGFClLN/1c7f9Ri3nZ6iGAK2383Y5OYgjtdRIaiajHGM3MUgyfZZM
9tXBHgNY6ElpkkjmpXRn
=1450
-----END PGP SIGNATURE-----

--K9pQOHvUyWlL--
