Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:6854 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752602AbcGUARl (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2016 20:17:41 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bQ1gG-00036d-MT
	for fstests@vger.kernel.org; Thu, 21 Jul 2016 10:17:36 +1000
Date: Thu, 21 Jul 2016 10:17:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 2caf9a3
Message-ID: <20160721001736.GB12670@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Many thanks to Eryu, again, for putting this
all together in a nice, neat bundle.

-Dave.

Patches sometimes get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

2caf9a3 generic: add _require_block_device to more tests

New Commits:

Eryu Guan (1):
      [2caf9a3] generic: add _require_block_device to more tests

Filipe Manana (3):
      [baa017a] btrfs: incremental send after moving directories around
      [b7dd83b] btrfs: incremental send after removing a directory
      [96bb332] btrfs: invalid rmdir issued by send operation

Jan Tulak (2):
      [2ba1258] common/rc: add _require_xfs_mkfs_validation
      [e5df569] xfs/096: run test only if mkfs.xfs accepts invalid inputs

Qu Wenruo (1):
      [20abd13] btrfs/079: Fix wrong value passed to available space check


Code Diffstat:

 common/rc           |  35 ++++++++
 tests/btrfs/079     |   2 +-
 tests/btrfs/127     | 263 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/btrfs/127.out |   2 +
 tests/btrfs/128     | 129 +++++++++++++++++++++++++++
 tests/btrfs/128.out |   2 +
 tests/btrfs/129     | 125 ++++++++++++++++++++++++++
 tests/btrfs/129.out |   2 +
 tests/btrfs/group   |   3 +
 tests/generic/067   |   1 +
 tests/generic/299   |   1 +
 tests/generic/300   |   1 +
 tests/xfs/096       |   1 +
 13 files changed, 566 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/127
 create mode 100644 tests/btrfs/127.out
 create mode 100755 tests/btrfs/128
 create mode 100644 tests/btrfs/128.out
 create mode 100755 tests/btrfs/129
 create mode 100644 tests/btrfs/129.out
--=20
Dave Chinner
david@fromorbit.com

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXkBSgAAoJEK3oKUf0dfodK+8QAJVhg7kbhzC6LV8TVyG0MsEz
FImyslN0IA2gX855UIYW0jkgZM9JBGsRUsQiszuWmTephxWloTAA2KOZfkcLQ9v+
apIST82mv50Ec/faeQaRZirmShKhbKJRY/IarVfHpPJx0TzOkZYVhVr0l0+IfVwa
9JkjymVqx8V2pHoYKGOwjQqAT8MJiAS/WsaxIqtUDkrYyHbHrtd52HoP9SmUEqkn
of5kGG5Apb7ojxjKCZQezzvbxbdRam9OLTuLpOxJrz56QhxJU2wwwDisdC1mpA1D
iE/m8MG2Aa4xaFztyAJyEgUYQq4SsRuT6Bn7TcqgFVvcJ3HfZHQa4y/afgtN5quq
Vnh7wOeFC5LlOtAtGxUDn6UVYrP6MQGN1t8i+FWwd/IVtMCUYPXsd2TNV4L1N9YH
/8Yf+sEo8i4dqWYegpC0FMFbeHPlur6ul0KhilkKZhcZQEDrZFdZ5jVl12/DYsJv
XUEFCMCAgVusfhLlfJOnGMQdiBlRDE4W4zZqxCQ4yooYBVq+Unx3Txl00JhFnEYv
PLS9n9H3lJzcmGvl/gdq4lRp3+IcMUZKSffYMpAdQxfB6GkqmdKUSasAdq4gHnm0
lOnVuYDvYKctap+bVIb6Z2t/9JRNjDm8mE+Mue5TX73Hr7SBVs5SYeS0WqO6r7Vo
QSdMgZQPDfM50dmWTmk5
=ll0o
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
