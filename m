Received: from mail-pl0-f54.google.com ([209.85.160.54]:38817 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752239AbdKZQ4s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Nov 2017 11:56:48 -0500
Received: by mail-pl0-f54.google.com with SMTP id s10so7056166plj.5
        for <fstests@vger.kernel.org>; Sun, 26 Nov 2017 08:56:47 -0800 (PST)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id w3sm39562961pge.59.2017.11.26.08.56.45
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 08:56:46 -0800 (PST)
Message-ID: <5a1af24e.03af630a.b5461.9973@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Mon, 27 Nov 2017 00:56:39 +0800
Subject: [ANNOUNCE] fstests: master branch updated to 69854f8dc5ce
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dlNIu3p4AIe3"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--dlNIu3p4AIe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the fs perf test infrastructure
and a sample test perf/001 from Josef, which are used to catch performance
regression. The perf tests are not enabled in a normal test run by groups, you
need to specify perf tests explicitly. e.g.

	./check perf/001

or specify group in perf subdir

	./check -g perf/auto

Other updates include two new tests for overlay and several overlay
improvements and some other random bug fixes. Many thanks to those who helped
review patches, especially Amir!

New failures I've noticed in this update:
- overlay/04[34] fail with v4.14 kernel

Thanks,
Eryu

The new head of the master branch is commit:

69854f8dc5ce fstests: filter readonly mount error messages

New commits:

Amir Goldstein (5):
      [7983867eadc8] overlay/041: code cleanup
      [c0b87a4ad851] overlay/041: test consistent values of st_ino/d_ino for subdirs
      [30daf6bd5fa6] overlay/041: use user defined overlay mount option
      [283a05c97cf1] generic/458: document the fix commit
      [26b2fe2880f7] generic/456: document the fix commit

Chandan Rajendra (6):
      [0d846837435a] overlay/017: Remove constant st_ino/d_ino test for hardlinks
      [fac0e790c810] overlay/018: Add constant d_ino test
      [e66fe3c8fc5a] overlay: Test consistent st_ino numbers for non-samefs scenario
      [fa50d81aa727] overlay: Test hardlink breakage on non-samefs setup
      [b689d3c8b049] overlay/038: code cleanup
      [1f872c0ff215] overlay/038: test consistent values of st_ino/d_ino for subdirs

Eryu Guan (3):
      [94d3a4f00cbd] fstests: filter mount error message for EUCLEAN and ESTALE
      [40737eac013e] overlay/036: filter busy mount message
      [69854f8dc5ce] fstests: filter readonly mount error messages

Josef Bacik (2):
      [c134a345f79e] fstests: add fio perf results support
      [e0d95552fdb2] perf: a random write buffered fio perf test

Xiao Yang (1):
      [1162f45f6628] generic/459: add check for dm-snapshot target


Code Diffstat:

 .gitignore                         |   1 +
 README                             |  10 ++-
 common/config                      |   2 +
 common/filter                      |  97 +++++++++++++++++++++-
 common/perf                        |  40 ++++++++++
 doc/requirement-checking.txt       |   9 +++
 src/Makefile                       |   2 +-
 src/perf/FioCompare.py             | 113 ++++++++++++++++++++++++++
 src/perf/FioResultDecoder.py       |  62 ++++++++++++++
 src/perf/Makefile                  |  14 ++++
 src/perf/ResultData.py             |  43 ++++++++++
 src/perf/fio-insert-and-compare.py |  35 ++++++++
 src/perf/fio-results.sql           |  94 ++++++++++++++++++++++
 src/perf/generate-schema.py        |  55 +++++++++++++
 tests/generic/050                  |   8 +-
 tests/generic/050.out              |   8 +-
 tests/generic/456                  |   5 ++
 tests/generic/458                  |   3 +
 tests/generic/459                  |   1 +
 tests/overlay/017                  |   4 +-
 tests/overlay/018                  |  21 +++--
 tests/overlay/035                  |   4 +-
 tests/overlay/035.out              |   4 +-
 tests/overlay/036                  |   4 +-
 tests/overlay/036.out              |   4 +-
 tests/overlay/037                  |   4 +-
 tests/overlay/037.out              |   4 +-
 tests/overlay/038                  | 101 +++++++++++++----------
 tests/overlay/041                  | 106 ++++++++++++++----------
 tests/overlay/043                  | 160 +++++++++++++++++++++++++++++++++++++
 tests/overlay/043.out              |   2 +
 tests/overlay/044                  | 145 +++++++++++++++++++++++++++++++++
 tests/overlay/044.out              |  21 +++++
 tests/overlay/group                |   2 +
 tests/perf/001                     |  80 +++++++++++++++++++
 tests/perf/001.out                 |   2 +
 tests/perf/Makefile                |  20 +++++
 tests/perf/group                   |   1 +
 tests/xfs/005                      |   7 +-
 tests/xfs/333                      |   2 +-
 tests/xfs/333.out                  |   2 +-
 41 files changed, 1173 insertions(+), 129 deletions(-)
--
Eryu Guan
eguan@redhat.com

--dlNIu3p4AIe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIbBAABAgAGBQJaGu81AAoJECZSqilcj+djj9YP+K1SjYYGwLM8JlDNPSE0lLbK
yCusf8YIr86pm3DzIWcMd0uU16TUwfeFRi41E93iIOZgP94LGvg05Alg2SH3CTAL
ekCvvsxOtQKkl0pN++aqpAN/zMVk1lC1tSSM28vdpUgiptL6J4T/vo/7/EzG9q7U
YRxF1WTZfhRE24AL8Oqds7QIfZZd9TVoNTLv1JDU+Epntp9qpBUdLq7/n26LD70Q
qkf1AfuCGnqkm9taANbgHXq/RiNCcjWwSJw4VawMXwy8gp2Xxy3aNOp4DtWmVdEP
Mmd1hHuZT8z75enJ53qJjcuhd6SDHMHT5k5beKXvhMYA7Zsd//ZiYKFZ5Nkp1Mnd
SzkF6whcazVPh/6JRc71IgH9MvYyk6LPIcX5YqxdApRl09QwOkOFyOnvQdetdjiV
FF13zCyxwMF1Vy6yfXFfgOp8yn4sakvrhzZ8KrHMFpKEbvA5r7ppxcZyPoJi6pPZ
S8QxLHwwiUUOLiNYWPjXpleHt6O3wKZs/y4ifGYkHkrqGW3WGrDMb5K1QH/7CyzU
UIaCJjmdpK0gtmPKfvsPSJpXcZUUMeEmXmcuJSl0vgl31jX5mEmVoVuZFhKbfRJD
a8dZoEb9NXfZESSYRugA+WFUylbWuLv+Sx5qnVfHnqaSG2vhCUtaP7g2hYlzCpvP
AYsb18QUaa3Yojvqctk=
=oP2Y
-----END PGP SIGNATURE-----

--dlNIu3p4AIe3--
