Received: from mail-pl0-f53.google.com ([209.85.160.53]:40778 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeCYMcV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Mar 2018 08:32:21 -0400
Received: by mail-pl0-f53.google.com with SMTP id x4-v6so10224255pln.7
        for <fstests@vger.kernel.org>; Sun, 25 Mar 2018 05:32:21 -0700 (PDT)
Message-ID: <5ab796d3.0e44620a.96f0b.e812@mx.google.com>
Date: Sun, 25 Mar 2018 20:32:12 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: [ANNOUNCE] fstests: master branch updated to 545e7ca67bea
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Mu6m1QMmubNX"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--Mu6m1QMmubNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a bugfix-only update. Jeff Mahoney fixed &
cleaned up libgdbm detection, Darrick J. Wong fixed various problems in
xfs_scrub test infrastructure, and Xiong Zhou fixed a potential infinite loop
in OFD lock test. There should be no new failures introduced.

Thanks,
Eryu

The new head of the master branch is commit:

545e7ca67bea generic/478: fix potential test blocking

New commits:

Darrick J. Wong (2):
      [064c61898963] common/xfs: don't call xfs_scrub on a block device
      [8aa212310d62] common/xfs: fix various problems with _supports_xfs_scrub

Jeff Mahoney (4):
      [81d27bdc0a10] build: remove dead AC_PACKAGE_WANT_NDBM macro
      [156dafb888a6] build: AC_PACKAGE_WANT_GDBM, fall back to compat if libgdbm detection fails
      [3a670ba14256] build: clean up AC_PACKAGE_WANT_GDBM
      [581862bdc023] build: fix <ndbm.h> detection in AC_PACKAGE_WANT_GDBM

Xiong Zhou (1):
      [545e7ca67bea] generic/478: fix potential test blocking


Code Diffstat:

 common/xfs            |  10 +++--
 m4/package_gdbmdev.m4 | 104 ++++++++++++++++++++++----------------------------
 src/dbtest.c          |   3 --
 src/t_ofd_locks.c     |  16 +++++---
 4 files changed, 63 insertions(+), 70 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--Mu6m1QMmubNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJat5OmAAoJECZSqilcj+djtT4QAOS7yWpyG1XkDcIbc1V+zCkD
lTF5kmyncPjA56ob120w/akn4whbmvYUZJw5hVPja9Z0ZIaXNPEtwk7JeWC1Gpll
tbDI0X6vHfc39IZTPBAhOnMStdIUs/GjGWmmy0nT8IkJvWmGBExdA9QVIzSRImAz
636NzhEGHP3VNkbz+OoLJ06mV32PR3h5eJVxrHBnxv68gzkcgZhhBoIyF9eBEpOR
GqLSJ26Z6NhfuF6BL3GCqFbachDnXuX5BXsOl7Mx+SkdUZDccLvTwVwFzEyZ8V4u
ytRxYlVx9r8j/NgsEVeW2j208xvHIyeXncQmV8XKB/Ud6eQx4/0SGXKlTI3mL9r6
zPlMgK+cZH97axTfY8SF00KbNdYCqfYC7oWnZ/awFmb8H0r3y3jRt4myfgTtiT15
EyBKHyMcHaP1GTgxKmtiUWct5wDaNk2wLL7+FdfknaeUERnLiza+C2qED3Z8YDtA
GbcUXhGsKtn5i0WP+Dpn9LPpC4APcnJSkFr2MIofPc2oN/nmgf3uBM3Zbc0AGsyh
NJpcwwKefuCU+iQfoWUcesyJAVlZ3eBMsfgY1S1Yh7agIumRVrSn7P7qcfBlezVW
6SHL1mmlM6lVFgQER26GmMY01L3DYndlXSjJoMgO6WuByuocZaJqzJgArGj2qM/1
CRrkK9mrw6+vkznnjhqT
=zbqX
-----END PGP SIGNATURE-----

--Mu6m1QMmubNX--
