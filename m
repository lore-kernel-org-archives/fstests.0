Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:43983 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750701AbbKBAyp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 1 Nov 2015 19:54:45 -0500
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1Zt3O3-0000nB-6y
	for fstests@vger.kernel.org; Mon, 02 Nov 2015 11:54:15 +1100
Date: Mon, 2 Nov 2015 11:54:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 8deb635
Message-ID: <20151102005415.GV19199@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated.

Patches often get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

8deb635 generic/312: fix dev_blocks calculation

New Commits:

Eric Sandeen (1):
      [a71e9bb] common: properly quote strings tested with -n

Filipe Manana (2):
      [64bd48f] btrfs/112: add missing _require_xfs_io_command for falloc
      [7ff4bb2] btrfs: cloning of compressed inline extent after truncation

Liu Bo (1):
      [17f7ca2] btrfs/012: add a regression test for deleting ext2_saved

Theodore Ts'o (1):
      [8c94797] ext4: move 30[1234] from the dangerous to the auto group

Xiong Zhou (1):
      [8deb635] generic/312: fix dev_blocks calculation


Code Diffstat:

 common/attr         |   8 ++--
 common/quota        |   4 +-
 tests/btrfs/012     |  12 +++++
 tests/btrfs/112     |   3 +-
 tests/btrfs/113     | 135 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/btrfs/113.out |  12 +++++
 tests/btrfs/group   |   1 +
 tests/ext4/group    |   8 ++--
 tests/generic/312   |   2 +-
 9 files changed, 173 insertions(+), 12 deletions(-)
 create mode 100755 tests/btrfs/113
 create mode 100644 tests/btrfs/113.out
--=20
Dave Chinner
david@fromorbit.com

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJWNrQ2AAoJEK3oKUf0dfodcwQP/0Ue0SDC2xMvyQK7TijmUYfF
pS2EIYF0Bo4ePzv3Y6uz0o1WPOxUdrtjgjUFY28fqsPfQ5N6pv6Mi5KztIBoN+1F
6ifb8iBvPD0b3+F62gBKuvVWhhdtQVP9mGHniwoMUj6yBOedmAouxqHWYyITqMSF
TVjHukiP+WMrhVaLnYV+y9ErnyhlbxbXIo1KTXtO0XEJBwrM2pRDLTiz/BaNGswo
561XePCjxUW53ggcYgmrHRTtmC9b+qOIixYF8WENmqAjutAvoqLWEQ9CkszxzEme
sS77vqLE6tdfDxTfcOpaWgeRik1Z3jIDDqjnzMNEWhQWDLdh3pReCajDG/6JIt8S
wcQwg50nRyTCXDsUfVgoB4ZIeZlg/OTDbAJZilGzOVWaLCP8q0IlFcIujGUKTV9y
VyvXIp+3c0cLanxKClKSnWBJoF/5aCnUjEBLCIuF3JxCznZFYXb3xv+sgJGvtCto
7CmnMpAgCxjmTJJXN7LiBnGo7HDkjJ63L6+B2X9WPGjOtiFo1O6+adFNUYlaJYbW
022Pa+oHrnWIDBWj/a9GjFzIY01A/ZtidZgndoiNoMyPu9UA7Yw7qRsf1fWhDOAX
K4t4PqmYEUyTKBNUCctCk34kk+/d9I/gFRU+Gt21oaaNa+XFzk+tFB0ZoETCs5a/
exlJONqg90f8xcNvdJoh
=i9EF
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
