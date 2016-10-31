Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:7367 "EHLO
        ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758669AbcJaFTZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2016 01:19:25 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1c150B-0006rn-QQ
        for fstests@vger.kernel.org; Mon, 31 Oct 2016 16:19:19 +1100
Date: Mon, 31 Oct 2016 16:19:19 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to efef020df5b2
Message-ID: <20161031051919.GR14023@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Thatnks to everyone who added tests, fixed
problems and reviewed changed. And Thanks to Eryu for getting it all
together in a nice neat pile.

Note that there are a couple of outstanding fixes that are needed to
xfs_io to make use of a couple of changes made (generic/389 and use
of the "-i" option). That should happpen soon...

-Dave.

The new head of the master branch is commit:

efef020df5b2 src/seek_sanity_test: discover allocation size

New Commits:

Amir Goldstein (6):
      [3fcfdba403c1] fstests: fix call sites that used xfs_io directly
      [f182653c6bff] fstests: strip quotes from "$XFS_IO_PROG" call sites
      [54659ecdb575] fstests: run xfs_io with -i option if supported
      [93d72ed7f662] t_truncate_self: describe self better in error message
      [044af9dd6632] overlay/013: fix bug in test_upper creation
      [aa96e42b8dd7] overlay/013: adjust test expectation to kernel v4.8

Andreas Gruenbacher (1):
      [f1edd77ebc28] generic: Check linking O_TMPFILE into namespace with P=
OSIX ACLs

Benjamin Coddington (1):
      [efef020df5b2] src/seek_sanity_test: discover allocation size

Darrick J. Wong (3):
      [bf5a5da57247] xfs: set the refcount btree cowflag when setting up cow
      [ed6e4664eeca] fstests: fix fallocate commands that need the unshare =
switch
      [da41142607c2] xfs: fix more xfs_db open-coding instances

Eric Biggers (1):
      [31db182a1c10] generic/314: remove from acl group

Eryu Guan (1):
      [4c99b91d0ad9] xfs/054: only filter ROOT_INO at the beginning

Xiao Yang (1):
      [dc46bab289da] xfs: remove the device parameter from __populate_check=
_xfs_dir


Code Diffstat:

 common/quota           |  4 +--
 common/rc              | 21 +++++++++++-----
 common/reflink         | 26 +++++++++----------
 src/seek_sanity_test.c | 41 ++++++++++++++++++++++++------
 src/t_truncate_self.c  |  7 ++++--
 tests/generic/043      |  2 +-
 tests/generic/044      |  4 +--
 tests/generic/045      |  4 +--
 tests/generic/046      |  4 +--
 tests/generic/047      |  2 +-
 tests/generic/048      |  2 +-
 tests/generic/049      |  2 +-
 tests/generic/156      | 16 +++++-------
 tests/generic/176      |  2 +-
 tests/generic/224      |  4 +--
 tests/generic/264      |  4 +--
 tests/generic/389      | 72 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/generic/389.out  |  6 +++++
 tests/generic/group    |  3 ++-
 tests/overlay/013      |  3 +--
 tests/overlay/013.out  |  2 +-
 tests/xfs/004          |  2 +-
 tests/xfs/007          |  8 +++---
 tests/xfs/021          |  4 +--
 tests/xfs/044          |  2 +-
 tests/xfs/052          |  2 +-
 tests/xfs/054          | 14 +++++------
 tests/xfs/099          |  2 +-
 tests/xfs/100          |  2 +-
 tests/xfs/101          |  2 +-
 tests/xfs/102          |  2 +-
 tests/xfs/105          |  2 +-
 tests/xfs/109          |  4 +--
 tests/xfs/112          |  2 +-
 tests/xfs/113          |  2 +-
 tests/xfs/114          |  4 +--
 tests/xfs/116          |  4 +--
 tests/xfs/132          | 12 ++++-----
 tests/xfs/136          |  6 ++---
 tests/xfs/184          |  3 ++-
 tests/xfs/190          |  4 +--
 tests/xfs/192          |  3 ++-
 tests/xfs/199          |  6 ++---
 tests/xfs/200          |  3 ++-
 tests/xfs/201          |  2 +-
 tests/xfs/204          |  3 ++-
 tests/xfs/229          |  2 +-
 tests/xfs/250          |  2 +-
 tests/xfs/278          | 16 ++++++------
 tests/xfs/291          |  4 +--
 tests/xfs/307          | 21 ++++++++--------
 tests/xfs/308          | 21 ++++++++--------
 tests/xfs/328          |  2 +-
 tests/xfs/344          |  3 ++-
 tests/xfs/345          |  3 ++-
 tests/xfs/346          |  3 ++-
 tests/xfs/347          |  3 ++-
 57 files changed, 267 insertions(+), 144 deletions(-)
 create mode 100755 tests/generic/389
 create mode 100644 tests/generic/389.out
--=20
Dave Chinner
david@fromorbit.com

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYFtRXAAoJEK3oKUf0dfod/wcP/14hJg8CiLLh2fJWw9ZZMEz/
HUNzvGZAmEQtozPxNqnXa8sOT7KduXOW2LHXKzzAIN30ByqQqEtjtGB19ZeUrtvm
Tj+D54z0wxiXsN55q9D2kdecjCqQYf5/kifJBC00AQ54y97xi4qrFt8MDO3xUZ1x
gbJJ2eBwH+4UuAmEEWBAbzN6vkWggWyVrtK9wWEux0ys2lX1Wm59k3tbY57e3mg/
r1zgdbQOSySknMAceR3EODNZMbJ+TtBf9CAlrf1gumpS7L9NnZobyj4Sa4MKLH1x
AmKzNi3sUB92degbJN17IyWfnL7IohETm/+xfBI49/lnUZOUbM5rw0roKnbGmeTC
4HyOW+5Y5JbmaQS04TrbclaJF4lcp9o1uwFVtT25pPwK14Q0WZBhVHNWSmTjV+X0
2S5Olr0SOc6fsZLmAkZ/1lSP6yiJHTOjPAwM5JQP7+jGegbRlsVKcGvyFGlnZcql
8vU+nQ64cjRR1lf2m/JhSV67em4o3P6wABuLfYeVdzyrQ4jsl37QjAYehvh+9PHt
Forrc/lClNBlsMCKxytecdiPHSKZvXfMOwEiIZ20lESh3m20zVqyGtryLTbpANYE
npXpdV/vnfaOjzK2ET5AQ7X4kmRCnzqMkCRz5FhYndyp6TOy7ztw06+UxjKwsSg/
A2/qpIMnaAPx0Bn1kgcC
=ehXd
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
