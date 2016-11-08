Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:22573 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751696AbcKHW66 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Nov 2016 17:58:58 -0500
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1c4FLz-00022h-7m
        for fstests@vger.kernel.org; Wed, 09 Nov 2016 09:58:55 +1100
Date: Wed, 9 Nov 2016 09:58:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] fstests: master branch updated to e604301e2605
Message-ID: <20161108225855.GP28177@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update from Eryu fixes the "pwrite64"
errors with a current TOT xfs_io and adds Ceph support.

-Dave.

The new head of the master branch is commit:

e604301e2605 common: add CephFS support

New Commits:

Dave Chinner (1):
      [c52086226bc6] filter: xfs_io output has dropped "64" from error mess=
ages

Joao Eduardo Luis (1):
      [e604301e2605] common: add CephFS support


Code Diffstat:

 README.config-sections |  6 ++++++
 common/config          |  9 +++++++++
 common/filter          |  7 +++++++
 common/rc              | 21 ++++++++++++++++++---
 tests/btrfs/126        |  4 ++--
 tests/btrfs/126.out    |  2 +-
 tests/ext4/306         |  3 ++-
 tests/ext4/306.out     |  2 +-
 tests/f2fs/001         |  6 ++----
 tests/f2fs/001.out     |  2 +-
 tests/generic/171      |  6 ++++--
 tests/generic/171.out  |  4 ++--
 tests/generic/172      |  6 ++++--
 tests/generic/172.out  |  4 ++--
 tests/generic/174      |  6 ++++--
 tests/generic/174.out  |  4 ++--
 tests/generic/230      | 12 ++++++++----
 tests/generic/230.out  |  8 ++++----
 tests/generic/271      |  3 ++-
 tests/generic/271.out  |  2 +-
 tests/generic/272      |  3 ++-
 tests/generic/272.out  |  2 +-
 tests/generic/276      |  3 ++-
 tests/generic/276.out  |  2 +-
 tests/generic/278      |  3 ++-
 tests/generic/278.out  |  2 +-
 tests/generic/328      |  6 ++++--
 tests/generic/328.out  |  4 ++--
 tests/xfs/071          |  4 ++--
 tests/xfs/071.out.64   | 20 ++++++++++----------
 tests/xfs/182          |  6 ++++--
 tests/xfs/182.out      |  2 +-
 32 files changed, 114 insertions(+), 60 deletions(-)
--=20
Dave Chinner
david@fromorbit.com

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYIliuAAoJEK3oKUf0dfodhq4P/0NwILlDNRq8+pJ6kGhyockK
/RDxbEKheMhE3K7smTOYpWAre/zSNcM34htGRXNeu5brnXxaDELXUMYbLk7BzRrM
RBZP1B2x1VOO7TQqEQ/kXBwGwyyvzqfxX5x9WCZ6oM3gNkAHltFTn6JlT/ZVgJfu
q2H1VyWTTutZ6ZLoC4bp/lLRrph+9sOE+BIE6cEYRbouhw9U9/1P3zS/Ki5dxx87
qh2V3tbLBvUAtvrkmhAR2MW5AFX0XUD845WBMCE8QtBZSOKX6m6hVTEFxrjj31AE
RPGt16Ia/Qkk54ZG66JYAOjNK3J7BXAOkTZnKs5bsnSyqI7WD15+Y8IAWUbnP0dF
dn2FNOYP7Oe7yM3fUIb6mqktlo2Tq6yiVuPmqjjHLA2KiIG0v6LZNim5tBhGw/1p
qb5neFYAWvGR4z07dqWKc+LgKrEtSQrgMsufo5YLL7W6uLXAr1j8RDC+EYox7L7v
VWeYRMhb1OZL2vuoqwmXpLy8pX+L0BnwJbWIJlOn0b37+R2d3TwBQ3Dtc01odNv8
NoqBDiqavYR9YeqpDSv+dU+8VztIYiueRBvhnINoxvsI043x35WHBGsSRgsCRfXo
iJRozP3w8GxA5O5SSfyDZLGGj4wrQUMJu/RSsnnsOHr8LZmaFv7SiKYbyCBCaujA
SS1T3qTYr6fGsTKM8mQH
=7lHw
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
