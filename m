Received: from mail-pl1-f173.google.com ([209.85.214.173]:33870 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbeHZQzY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Aug 2018 12:55:24 -0400
Received: by mail-pl1-f173.google.com with SMTP id f6-v6so2962525plo.1
        for <fstests@vger.kernel.org>; Sun, 26 Aug 2018 06:12:52 -0700 (PDT)
Message-ID: <5b82a753.1c69fb81.ccc82.56ad@mx.google.com>
Date: Sun, 26 Aug 2018 21:12:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to aefa91183494
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kqKQOb4uyxT5"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--kqKQOb4uyxT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Again, this is a small update that fixes the output
mismatch caused by new getfattr and splits overlay/016 into two tests. And the
new overlay/061 is expected to fail with latest Linus tree.

Recently the review process is a bit slow on my part, hopefully I'll get to the
following patchset next week.

[PATCH 00/16] Fix tests to work on non-4k block sized fs instances

Thanks,
Eryu

The new head of the master branch is commit:

aefa91183494 overlay/016: split into two tests

New commits:

Amir Goldstein (2):
      [2028376ff928] open_by_handle: fix name of directory in error messages
      [aefa91183494] overlay/016: split into two tests

Zorro Lang (1):
      [794f4594fbf4] fstests: filter redundant output by getfattr


Code Diffstat:

 common/attr           | 12 ++++++++++
 src/open_by_handle.c  |  6 +++--
 tests/ext4/022        |  2 +-
 tests/ext4/026        |  4 ++--
 tests/generic/020     |  8 +++----
 tests/generic/037     |  2 +-
 tests/generic/062     |  4 ++--
 tests/generic/066     |  4 ++--
 tests/generic/093     |  2 +-
 tests/generic/097     |  2 +-
 tests/generic/337     |  2 +-
 tests/generic/364     |  5 ++--
 tests/generic/403     |  2 +-
 tests/generic/454     |  6 ++---
 tests/generic/489     |  2 +-
 tests/overlay/011     |  2 +-
 tests/overlay/016     | 15 ------------
 tests/overlay/016.out |  3 ---
 tests/overlay/026     |  4 ++--
 tests/overlay/038     |  4 ++--
 tests/overlay/041     |  4 ++--
 tests/overlay/046     |  6 ++---
 tests/overlay/056     |  2 +-
 tests/overlay/060     |  5 ++--
 tests/overlay/061     | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/061.out |  4 ++++
 tests/overlay/group   |  1 +
 tests/shared/002      |  2 +-
 tests/xfs/021         |  8 +++----
 tests/xfs/187         |  2 +-
 30 files changed, 129 insertions(+), 61 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--kqKQOb4uyxT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbgqbrAAoJECZSqilcj+djucQQAM2N46RBum/mjGQPM7Jp3U4V
rWXx8hRmQ0awIYoNRzmi72QIQ9ktUslst2CW/mpK+sb70LriURFrF1qzHnYE3spY
43n5JOUUIZtdyneepXhoJ1S1w3Km4zVUst1ONt57UYoG83zCgpAlyoa/e7kEqfHA
7J7zRhZ63zjGgtMeiZg2YKpgTB7KGmdpnbKq9k9+Ua7Hfhs2MmWyVqGhdnno/Xj/
ok6DFL8goeny9WWIkjQ5aFnZ5zq/rdXeRxL+BzJDObhnFBbObcZrRgBxmrVHsTIe
x3ql8DMe3p5WL375unRNvvSfdjbEYvD72z+8KYN4JIpFuNLoBOPaq/vrFf7KVCCj
L5nDubN/MGRMO7Q/MVDVqsQ65YCQV9FB5CcYELBdP2ntpd76/kUIbXv1jEJog/ge
MwQzTdgqeB2GokqqFyJ/5MM4hRiEb7VgOh6b3GRkEaA2eD9RScAUCbdqVtBq77Ci
ftq8hqvM0efzk18G4oXYVecu/0LMdx6BMROULYxpGqtrkbQDcx9S2A1Fgb6TIkoj
WbVG/SDX67uTkr1p0X9YQob5euGpiaeS195W/CYujMjxhEJ+6AMi8pt/naKa2eE+
ID2b+WpgDujBMbYwZM7NCtYUiSGUuQWzjgDpG6ZxPbgonA7I5DBIZfqdQpEWbZZT
UTqTQ5/nAEKqsABYiQdR
=vsSm
-----END PGP SIGNATURE-----

--kqKQOb4uyxT5--
