Received: from mail-pf0-f174.google.com ([209.85.192.174]:35485 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbdIJNXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Sep 2017 09:23:32 -0400
Received: by mail-pf0-f174.google.com with SMTP id g13so10536535pfm.2
        for <fstests@vger.kernel.org>; Sun, 10 Sep 2017 06:23:31 -0700 (PDT)
Received: from localhost ([128.199.137.77])
        by smtp.gmail.com with ESMTPSA id u74sm11238132pfa.62.2017.09.10.06.23.29
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Sep 2017 06:23:30 -0700 (PDT)
Message-ID: <59b53cd2.4d47620a.c406a.b6e8@mx.google.com>
From: Eryu Guan <guaneryu@gmail.com>
Date: Sun, 10 Sep 2017 21:23:27 +0800
Subject: [ANNOUNCE] fstests: master branch updated to b309f083516f
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0iCJLLNCJNXs"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--0iCJLLNCJNXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the dm-log-writes patches and
tests from Amir Goldstein and Josef Bacik, many thanks to Amir and Josef!!

I quoted the words from Amir's cover letters to describe this work (but with
the test numbers changed to reflect current status):

"
I've collected these patches that have been sitting in Josef Bacik's tree for a
few years and kicked them a bit into shape. The dm-log-writes target has been
merged to kernel v4.1, see:
https://github.com/torvalds/linux/blob/master/Documentation/device-mapper/log-writes.txt

I've added some debugging options for running fsx and replay-log, which I used
to analyze the crash consistency bugs uncovered by the tests.

The original fsx crash consistency test (generic/455) is failing sometimes on
kernel v4.13 for ext4, btrfs and xfs. A fix for xfs is queued for v4.14, I
think there is a fix by Josef for btrfs queued for v4.14 as well.

A 'quick' and reliable regression test (generic/456) was created for the ext4
issue.

I created another crash consistency test which runs fsx on cloned files
(generic/457). This test is failing check fs sometimes on kernel v4.13, at the
end of the test, but this is not related to crash consistency. There is a fix
is the works for v4.14.

A 'quick' and reliable regression test (generic/458) was created for this
issue.

The new 'clones crash' test (generic/457) is also failing sometimes on
xfs_repair errors like: "fatal error -- illegal state 13 in block map 147", on
crash points, but I havn't been able to narrow down the issue yet.
"

To run these new crash consistency tests, you need to enable
CONFIG_DM_LOG_WRITES kernel configuration and assign a block device to a new
LOGWRITES_DEV variable, which is used by the dm-log-writes target to record the
write log entries.

Also, there's another new overlay test added, which Amir helped on patch
review as well. Thanks again to Amir!

New failures I've noticed in this update, all tested against 4.13 kernel:
- generic/455 fails sometimes on btrfs/ext4/xfs
- generic/456 fails always on ext4
- generic/457 fails sometimes on xfs with reflink
- generic/458 fails always on xfs with reflink
- overlay/038 tests constant d_ino and fails

Thanks,
Eryu

The new head of the master branch is commit:

b309f083516f generic: renumber tests after merge

New commits:

Amir Goldstein (13):
      [3582f7b1bf00] fsx: add support for integrity check with dm-log-writes target
      [bd918dff012b] fsx: add optional logid prefix to log messages
      [3f742550dfed] fsx: add support for recording operations to a file
      [90d0b3e166d8] fsx: add support for writing constant instead of random data
      [2a15cabaf6a2] fsx: add support for keeping existing file
      [b1e2e6b0279e] log-writes: add replay-log program to replay dm-log-writes target
      [9892f3155f63] replay-log: add validations for corrupt log entries
      [b65b808ee3df] replay-log: add support for replaying ops in target device sector range
      [520cddd8d0dd] fstests: add support for working with dm-log-writes target
      [dd0b40b620e8] generic: crash consistency fsx test using dm-log-writes
      [88ef97bf667e] generic: regression test for ext4 crash consistency bug
      [cc2d3d6f5f2a] generic: crash consistency fsx test for cloned files
      [5f9296904a95] generic: regression test for xfs leftover CoW extent error

Chandan Rajendra (1):
      [72da031cc1b1] overlay: Test constant d_ino feature

Eryu Guan (1):
      [b309f083516f] generic: renumber tests after merge


Code Diffstat:

 .gitignore                   |   1 +
 README                       |   2 +
 common/dmlogwrites           |  90 +++++++++
 doc/auxiliary-programs.txt   |   8 +
 doc/requirement-checking.txt |  20 ++
 ltp/fsx.c                    | 273 ++++++++++++++++++++------
 src/Makefile                 |   2 +-
 src/log-writes/Makefile      |  23 +++
 src/log-writes/SOURCE        |   6 +
 src/log-writes/log-writes.c  | 458 +++++++++++++++++++++++++++++++++++++++++++
 src/log-writes/log-writes.h  |  86 ++++++++
 src/log-writes/replay-log.c  | 389 ++++++++++++++++++++++++++++++++++++
 tests/generic/455            | 132 +++++++++++++
 tests/generic/455.out        |   2 +
 tests/generic/456            |  80 ++++++++
 tests/generic/456.out        |   2 +
 tests/generic/457            | 135 +++++++++++++
 tests/generic/457.out        |   2 +
 tests/generic/458            |  74 +++++++
 tests/generic/458.out        |   2 +
 tests/generic/group          |   4 +
 tests/overlay/038            | 196 ++++++++++++++++++
 tests/overlay/038.out        |   2 +
 tests/overlay/group          |   1 +
 24 files changed, 1929 insertions(+), 61 deletions(-)
--
Eryu Guan
eguan@redhat.com

--0iCJLLNCJNXs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJZtR0zAAoJECZSqilcj+djkOkQAI/IqTQoTXvCc3IRAxGZn1S0
TbLgTpKM2ucZ0IwfavgZGZYcClLXXlmYx9bsPKU9jtYz/3kJAsWrUokYOLcLYj/f
pbouy2loCCl5+ND/vR/O3nljz7YGtvhnob2eGtPqJdOBofgKURTEHzDE9jssDG8l
u4F36qe2s75oPgOLAp3AdRuS5vjpoK78H6nQgzCrWixTyF9VbZdfhKxJl8P4o3Hw
K2Smkjk7m9NAjzVD6LXFSeEqOyf/If+EJCvg3YOIQASfUYBoeaWdJ8FfCePvXfCO
Qxw7KEZrHuP7H3u7iDcPDh5oljDGoLq55A98ZGYRuNZElcIKXRQ0Q2v6JKYUeV68
h1PH72iflfNZoaZsaJ4ALvMugxubrMe5KdTzv5SBfg/RhbslXoRyMArC+aKvvnmj
UjioImpqijTpUva35t4YJHO/gJ1S7heO/6ONl+GQ2EpP0JR2bxaw04d349ifiNh+
K1qLrOIObS89LJ0KXtRwus4oFREBDVMGOQHxzDj//rjo30CkaMn+1WPS++xe9CIt
yPYeFkL10xTQi7+FwC3hvCXJneLhy8zojjI9WVGJesTVojY3iz9UrNZLq6DH+jFu
+VP+4pUNT0lhAJHchxCdMDixXdEsn2jstXMl2KRIeW0cR8xy7WZVQMW4gsfDpZnL
+WlmKwoRMjSTo1ujGrqq
=xuf6
-----END PGP SIGNATURE-----

--0iCJLLNCJNXs--
