Received: from mail-pf0-f194.google.com ([209.85.192.194]:46467 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936343AbeE0NP0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 May 2018 09:15:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id p19-v6so382862pff.13
        for <fstests@vger.kernel.org>; Sun, 27 May 2018 06:15:25 -0700 (PDT)
Message-ID: <5b0aaf6c.1c69fb81.9e918.ee6b@mx.google.com>
Date: Sun, 27 May 2018 21:15:19 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 625515d61cb7
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhg4aGCjhfWS"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--zhg4aGCjhfWS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively large update. Notably, swapfile
tests are re-enabled on btrfs once btrfs gains swapfile support, and some new
swapfile tests are added as well. Most other commits are bug fixes.

There should be no new failures introduced by this update. Many thanks to those
who contributed new tests, fixes and/or helped review patches!

Thanks,
Eryu

The new head of the master branch is commit:

625515d61cb7 xfs/206: filter/fix for minor geometry reporting changes

New commits:

Darrick J. Wong (2):
      [954f28239b4c] generic/475: fix confusing comment
      [8ee4d87d3419] xfs/447: fix typo

Eric Sandeen (2):
      [c3c9630968a6] generic: test online label ioctl
      [625515d61cb7] xfs/206: filter/fix for minor geometry reporting changes

Jan Kara (1):
      [968ccf32e411] generic: Handle missing [gs]etcap tools

Omar Sandoval (5):
      [39aca573e4b9] fstests: create swap group
      [bd6d67ee598e] generic: enable swapfile tests on Btrfs
      [1150c26f8209] generic: add test for dedupe on an active swapfile
      [37e5788a55a6] generic: add test for truncate/fpunch of an active swapfile
      [d84c10517019] generic: test invalid swap file activation

Theodore Ts'o (4):
      [b13f51d57153] report: make sure control charcters are encoded in xUnit report
      [1410a2054f07] generic: add tests 405 and 459 to the group 'thin'
      [8a8be5f0aba9] generic: drop test 472
      [78f713a198ed] generic/490: fix cleanup function

Xiao Yang (2):
      [0ea7132607bb] check: Make the test harness unmount fs when finishing a test
      [69b7f3c4f720] generic/484: Need another process to check record locks

Zorro Lang (1):
      [4b246619a492] common/quota: sort lines of repquota output


Code Diffstat:

 .gitignore            |  2 ++
 check                 |  4 +++
 common/config         |  2 ++
 common/quota          |  4 +--
 common/rc             | 45 +++++++++++++++++++++---
 common/report         | 11 +++---
 src/Makefile          |  2 +-
 src/mkswap.c          | 83 ++++++++++++++++++++++++++++++++++++++++++++
 src/swapon.c          | 24 +++++++++++++
 src/t_locks_execve.c  | 24 +++++++++----
 tests/generic/093     | 10 +++---
 tests/generic/270     |  6 ++--
 tests/generic/356     |  7 ++--
 tests/generic/357     |  6 ++--
 tests/generic/472     | 96 ---------------------------------------------------
 tests/generic/472.out |  9 -----
 tests/generic/475     |  8 +++--
 tests/generic/490     |  2 ++
 tests/generic/492     | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/492.out | 13 +++++++
 tests/generic/493     | 76 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/493.out |  7 ++++
 tests/generic/494     | 73 +++++++++++++++++++++++++++++++++++++++
 tests/generic/494.out |  8 +++++
 tests/generic/495     | 77 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/495.out |  5 +++
 tests/generic/group   | 13 ++++---
 tests/xfs/206         |  5 ++-
 tests/xfs/206.out     |  2 +-
 tests/xfs/296         |  8 +++--
 tests/xfs/330         |  2 +-
 tests/xfs/447         |  2 +-
 tests/xfs/group       |  2 +-
 33 files changed, 580 insertions(+), 153 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--zhg4aGCjhfWS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJbCq7QAAoJECZSqilcj+djzYoP/0GmVB8sPNSuvQFWjew5oGMG
dyDKg4J6bnTNkeIkjaplxRcY0AQ3J9BPENm4KLugCQ4mbBkV2B1i0FnGqFEUq1hl
OhM2tI4LsKm+bKsMRKlVz3VlbV2VySbVbrJvNI+vwGfocV66S8eYUgzvvvu/keww
cO38mJrZhdge8m6sBvvx8lNJBg4HyGUzsAZ0iBjoR3RzQc5JvOZIYfZNw8HBXSJu
6y0uS+eiVvY7fx2+YnB5KtJ/i3eeOXfYRACMJ4vMJ9q/oXGCaIHb9e6BtVRBxSZv
mI0ebdsn4Z5mmyviU2787WKWuHe1v/pW7oCYzptMqefrwjBCLd5mqcK5Ze7gO3lb
zN/WR9GIyIki1dhrbY8zrRfVCnpfC5oTeDgxJLYK4Nhujm2PLnCxnU09SamGSlDf
poWYKyBCBGspT/RriW5B+H2XJws6UZSpBZZoDWCdsIXFTt8AvgL3pMTDQeV+qK0F
H9hHiBGXaUP1SnCDrtiI+XNZBItL6egIyDzIL6HeLSQx3f10NqTiCycdPw3mxLqh
ZE8kdFzDJfe9L1vES/zBR79FulfiwdgbBPUPbFdgnild1PPeIVF6UAMmR/z7RMCR
Ult72YLpOFNOQ4ELEDhgasaojg8BL7RkISipUkLbpJnTYNOyTi8DykbctOXxGQoi
JnZgwBlFACCpYY61V73H
=sDgI
-----END PGP SIGNATURE-----

--zhg4aGCjhfWS--
