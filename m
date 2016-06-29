Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:46252 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423AbcF2BEd (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2016 21:04:33 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1bI3uu-0002EC-GB
	for fstests@vger.kernel.org; Wed, 29 Jun 2016 11:03:48 +1000
Date: Wed, 29 Jun 2016 11:03:48 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 54774d4
Message-ID: <20160629010348.GN12670@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qp4W5+cUSnZs0RIF"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--qp4W5+cUSnZs0RIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repositories at:

	git://oss.sgi.com/xfs/cmds/xfstests
	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Many thanks to Eryu for putting this all
together again.

-Dave.


Patches sometimes get missed, so please check if your outstanding
patches were in this update. If they have not been in this update,
please resubmit them to fstests@vger.kernel.org so they can be
picked up in the next update.

The new head of the master branch is commit:

54774d4 ext4/271: _notrun if there are journal related mount options

New Commits:

Anand Jain (1):
      [bbb351f] btrfs/006: ignore btrfs filesystem sync stdout output

Andreas Gruenbacher (1):
      [733f096] generic/026: This test doesn't require runas

Brian Foster (1):
      [3ba258d] fstests: support check for uuidgen utility

Eric Sandeen (1):
      [619f648] xfs/186: fix test for crc=3D0, ftype=3D1

Eryu Guan (7):
      [a173f8e] xfs/186: run test on expected XFS configuration
      [3832aff] dmthin: express low_water in cluster_size not sector size
      [4fb7f2d] overlay: test visible whiteout issue after rename
      [b3b54d0] overlay: getcwd() after a failed rmdir
      [6842811] overlay: create new file over whiteout
      [497363b] fstests: introduce _exclude_scratch_mount_option helper
      [54774d4] ext4/271: _notrun if there are journal related mount options


Code Diffstat:

 README                |  3 +-
 common/config         |  1 +
 common/dmthin         |  2 ++
 common/rc             |  9 ++++++
 tests/btrfs/006       |  2 +-
 tests/btrfs/006.out   |  1 -
 tests/ext4/271        |  6 ++++
 tests/generic/026     |  3 --
 tests/generic/192     | 11 -------
 tests/overlay/006     | 77 +++++++++++++++++++++++++++++++++++++++++++++++=
++
 tests/overlay/006.out |  2 ++
 tests/overlay/007     | 65 +++++++++++++++++++++++++++++++++++++++++
 tests/overlay/007.out |  2 ++
 tests/overlay/008     | 85 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 tests/overlay/008.out |  3 ++
 tests/overlay/group   |  3 ++
 tests/xfs/134         |  8 ++---
 tests/xfs/186         | 24 +++++++++++++--
 tests/xfs/306         |  3 +-
 19 files changed, 284 insertions(+), 26 deletions(-)
 create mode 100755 tests/overlay/006
 create mode 100644 tests/overlay/006.out
 create mode 100755 tests/overlay/007
 create mode 100644 tests/overlay/007.out
 create mode 100755 tests/overlay/008
 create mode 100644 tests/overlay/008.out
--=20
Dave Chinner
david@fromorbit.com

--qp4W5+cUSnZs0RIF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcx5zAAoJEK3oKUf0dfodgx4QAJ1HGlhMceQhgMaZTSaxgGlh
zgNQsLflF+sYSyJ4oxI+QEo0OHXbzxUmD80VPylQ+wqsfIWKWjjSWNoBjwrNh1Qi
Z2SwKj8QV7tqum4+o96+xBVur5tRilkSF/2OLXhmdVnlc+ynGFW0jFNm714d5OmF
y2rvoKs6xWbo0EsErj+y4nC6czw/vdmbjvvkcp3CtEI9Yij7i+DPt4qywAwK5U2a
LFHoNzEGjP+rr+vOhzMUdp8xYGcd9tArdFiN6u8l/ubYv4uGev4oLGqc6mt4BErP
idVfQWz9/W0jVNXW9lODKVMhNvJCRiQZcwj8vvq/cPKe/hshZtniIT0rzIPbJJ/9
r9XNu6RAmZm+VEzizfkYsNOi2sY8uK4vAH8OMB6Jb2QaNtHrh2Gfwnvxqtfq50CO
Zpv+r5B0Fs0JGIF+I7+GLWZ4rii74porwCZnFrMflwKpUv8a8ZHtZeE4KdjInxDg
Veo/5eVXUfi65VmqKFUN4EcZHroYAWNh3m7qKXzHCisWIqKRtN73DTGmTs8S3vjZ
viP8Y0cCqdUq9KjWzt7KciKD6HowFyO4dcgtPWseJZhOnlEWmA1jqrV+IXqHOH/Y
RctYS5O2LQU4XwXCUBNkaYVKmegj4m7NNMs2Ulk0+Lqws/2P8KOx03948i6f0WtS
iU0m/THyd2jvk31zRiHI
=0X8B
-----END PGP SIGNATURE-----

--qp4W5+cUSnZs0RIF--
