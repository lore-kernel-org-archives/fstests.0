Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:36965 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756829AbbCRVe1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 Mar 2015 17:34:27 -0400
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>)
	id 1YYLb9-0007Er-Tm
	for fstests@vger.kernel.org; Thu, 19 Mar 2015 08:33:55 +1100
Date: Thu, 19 Mar 2015 08:33:55 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE] xfstests: master branch updated to 7a1ad74
Message-ID: <20150318213355.GG10105@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

The xfstests repository at git://oss.sgi.com/xfs/cmds/xfstests has
just been updated. Patches often get missed, so please check if your
outstanding patches were in this update. If they have not been in
this update, please resubmit them to fstests@vger.kernel.org so they
can be picked up in the next update.

IMPORTANT NOTE ABOUT PATCH REVIEW
---------------------------------

I have not picked up all the outstanding patches on the list because
I do have not the bandwidth to review and test every change posted
over the past month (e.g. due to LSFMM/vault).  I've just picked up
all the patches that have been reviewed (i.e. have a "Reviewed-by"
tag attached) are fixes I thought were important enough to pick up
immediately.

What it comes down to is this: review only scales when everyone who
posts changes for review is also reviewing other changes. i.e.
if you are posting patches and expect other people
to review them for you, then you also need to be spending time
reviewing other people's patches.

As such, there are a large number of patches that I skipped over
that still need review. They'll get committed much faster if the
review bottleneck (i.e. me) is resolved. Hence if you want your
patches committed quickly, then please find someone to review the
patches you have posted to the list.

-Dave.

The new head of the master branch is commit:

7a1ad74 common: fix "utility required warning" with empty utility name

New Commits:

Dave Chinner (4):
      [d0a3cc5] xfs/104: log size too small for 4k sector drives
      [354108e] xfs: don't output mkfs sector sizes into golden output
      [ee6ad7f] xfs/049: umount -d fails when kernel wins teardown race
      [4f9fb9d] generic: Add rudimetary RENAME_WHITEOUT test

Eryu Guan (4):
      [d3d25b0] new: fix template for new case to use a single tab not four=
 spaces
      [30c7a09] generic/027: discard mkdir error message
      [8346e53] common: append -d option to XFS_COPY_PROG when testing v5 x=
fs
      [74984c5] xfs/073: be quiet about mouting with nouuid option

Filipe Manana (2):
      [e22b586] generic/065: fsync file 'hello' before checking its content
      [57914b8] fstests: generic test for fallocate

Zhao Lei (2):
      [9165e41] common: fix a typo in _require_block_device()
      [7a1ad74] common: fix "utility required warning" with empty utility n=
ame


Code Diffstat:

 common/defrag          |  2 +-
 common/rc              | 13 ++++++---
 new                    |  4 +--
 src/renameat2.c        |  4 +--
 tests/btrfs/003        |  2 +-
 tests/btrfs/004        |  2 +-
 tests/btrfs/011        |  2 +-
 tests/btrfs/012        |  6 ++--
 tests/btrfs/079        |  2 +-
 tests/ext4/004         |  4 +--
 tests/generic/027      |  6 ++--
 tests/generic/065      | 28 ++++++------------
 tests/generic/065.out  |  5 +++-
 tests/generic/071      | 79 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 tests/generic/071.out  |  9 ++++++
 tests/generic/078      | 66 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/078.out  | 51 ++++++++++++++++++++++++++++++++
 tests/generic/group    |  2 ++
 tests/xfs/049          |  8 ++---
 tests/xfs/073          |  8 ++---
 tests/xfs/073.out      |  1 -
 tests/xfs/078          |  4 +--
 tests/xfs/094          |  2 +-
 tests/xfs/096          |  8 +++--
 tests/xfs/096.external | 15 +++++-----
 tests/xfs/096.internal | 16 +++++-----
 tests/xfs/103          |  2 +-
 tests/xfs/104          |  8 ++---
 tests/xfs/104.out      | 46 ++++++++++++++---------------
 tests/xfs/119          |  2 +-
 tests/xfs/122          |  2 +-
 tests/xfs/195          |  2 +-
 tests/xfs/206          | 33 ++++++++++-----------
 tests/xfs/216          |  2 +-
 tests/xfs/217          |  2 +-
 tests/xfs/250          |  4 +--
 tests/xfs/291          |  2 +-
 tests/xfs/297          |  2 +-
 38 files changed, 330 insertions(+), 126 deletions(-)
 create mode 100755 tests/generic/071
 create mode 100644 tests/generic/071.out
 create mode 100755 tests/generic/078
 create mode 100644 tests/generic/078.out
--=20
Dave Chinner
david@fromorbit.com

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVCe9DAAoJEK3oKUf0dfodbvoP/01gKD4bt0BT1mMM8HWNoMOs
nLfuX3cTebPNUCmdSS1BTHHxunmj7cnDbo5VBRh262uiJQfVueh4piABh7CJQWTA
5A8VOcLmR0Jd5m+OWlAbm4Bz3EMt0Zm3wjDsFPiEA+ae9Gp6EHxkEok2JOadBr7i
Tpbp7qu76kv+HeE01PjC6ovYdt2MGn6Wth+dsfktjXxbNmvA81UFHKk61UY4kBWP
8bA5MNgjpO4JwBjTyljY4OduADsD4hYA+jkZzhkj0wLeUKNPo2JjBersZARH45XE
EiaMXQco9J3fAgzbUVshulmZHcGgabybPkvZeILRMmk5Yad8aAm8Ysqp8xH1HPHR
a4vt5sCcc8brRLdKHPkPcfW8ozwbec7NZqbFff9tiMScHym6zs9AFUpqxTkIR3qn
MRMk/gArUjY5oyl5B+tdH40E8Zz3Z83D5cpQt9D/AF+s7ST4GdnPMcCMd1u2/YEf
fUrCWDB3zt8fw7x2S2/h0q476S/W2y7P0OprwNNq6ldF0d1bWSg+rwpxV/qlsMgT
ZEai/wKm1qhvmJd9rzFjUZq/92h7sYjM10w86/KYituf7Sa2C8jDvdxM9ShoiNQ+
YS0c0lwhk9weKpb9sVS9JErQAmxvOiU6azggfh5dPuSbhnNMr9smfTSI/TN68x9s
fM46mybRaRzKhST/liDR
=8ejK
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
