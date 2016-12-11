Received: from mx1.redhat.com ([209.132.183.28]:55832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbcLKG64 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 11 Dec 2016 01:58:56 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67D7B61B8A
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2016 06:58:55 +0000 (UTC)
Received: from localhost (vpn1-5-48.pek2.redhat.com [10.72.5.48])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uBB6wr8b017679
        for <fstests@vger.kernel.org>; Sun, 11 Dec 2016 01:58:54 -0500
Message-Id: <201612110658.uBB6wr8b017679@int-mx10.intmail.prod.int.phx2.redhat.com>
Date: Sun, 11 Dec 2016 14:58:53 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: [ANNOUNCE] fstests: master branch updated to e6111674ea18
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lNHgrpiV1RJx"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


--lNHgrpiV1RJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're only bugfixes and improvements in this update,
no new tests. We have improved btrfs qgroup tests, disabled swapfile tests on
btrfs, overlay test fix and a build warning fix. There's no new failures I've
noticed in this update.

Currently there're three big outstanding patchsets sitting in my review queue,
they're filesystem-level encryption tests from Eric Biggers, XFS online
scrub/repair tests from Darrick and copy_file_range tests from Anna Schumaker.
I'll work on them after this update, I appreciate if someone could help review
them too!

Thanks,
Eryu

The new head of the master branch is commit:

e6111674ea18 overlay/016: use xfs_io -C for executing commands

New commits:

Amir Goldstein (2):
      [53d31765f607] common: implement _require_xfs_io_command "open"
      [e6111674ea18] overlay/016: use xfs_io -C for executing commands

Omar Sandoval (1):
      [8c96cfbfe530] generic/35[67]: disable swapfile tests on Btrfs

Qu Wenruo (2):
      [47bb69de19c6] common/btrfs: rename and enhance _require_btrfs to _require_btrfs_command
      [180843c1f468] btrfs: Use _require_btrfs_qgroup_report to replace open code

Ross Zwisler (1):
      [490baac3805a] build: fix build warnings and notify_others() bug


Code Diffstat:

 check                 |  4 ++--
 common/btrfs          | 47 +++++++++++++++++++++++++++++++++++++++++++----
 common/rc             | 35 +++++++++++++++++++++++++++++++++--
 ltp/fsx.c             |  8 ++++----
 ltp/growfiles.c       |  3 ++-
 tests/btrfs/004       |  3 ++-
 tests/btrfs/022       |  4 ++++
 tests/btrfs/028       |  5 ++---
 tests/btrfs/042       |  1 +
 tests/btrfs/048       |  2 +-
 tests/btrfs/059       |  2 +-
 tests/btrfs/099       |  1 +
 tests/btrfs/104       | 20 +++++---------------
 tests/btrfs/122       |  9 +++------
 tests/btrfs/123       |  5 ++---
 tests/btrfs/126       |  1 +
 tests/btrfs/131       |  2 +-
 tests/generic/356     |  1 +
 tests/generic/357     |  1 +
 tests/overlay/016     | 27 +++++++++++++--------------
 tests/overlay/016.out | 11 +++++------
 21 files changed, 128 insertions(+), 64 deletions(-)
--
Eryu Guan
eguan@redhat.com

--lNHgrpiV1RJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJYTPbPAAoJECZSqilcj+dj/bwQAIHefbgyH/QIMWh+F5YZo7V4
1AMlXf/beqRnV/4xiZGhLUqutZFdiePWhzQC6IRgiRKXgL4qZ3XTCiIHnVOr9Mvl
3DJ552Uw5byqewlV1Il5f8BcDKtxfpAabLNHLJj+2sNznxLIU/MQQBLJ2EY58dIb
i14zc93m6sNRW3WZxc+Sp3+s3p1bzA4QZK2vuzMivYGJ5ZcB1PMTk/sKrqfIDX/y
W3PZUTJnKl54jDCD9kDHrem4GQpmiJGDAsw0jXEnEOflx7bkG4CMZfSUgc6Gu4V6
+lxBuGolNWdO/GOOElBhRPkcDOh4H4xOeVq8gE/yN0eBS9OIsTjP7JdzbODy7Uuj
hzDDMzgTo7ZkD7nXbys3FOn4xxf2qAV9iFjjBsoBuSUMkroSLW7PPY9kryN7MsX+
ugoXvnSUu7kzU+ZEc2FPCFCL37ZF+NGwiUP7m+zDYh4s3FNu35iyj+lu2A2nkcQc
zJRWC/NZJxppsf5s6/WzE7VBbBxIr0giQcAcJrn/OCZTxv5kb73uOSgIb/pdiLar
b6IDXMLCYpPtBDcuH14s6Gl5kmPLoST1VN3ABk9Zkkh1jATjHmerJC1XLnZyKx4S
unesY83VFjM1h4HCydYz+mTl+fObf2j2ZrwMe6k5/aVw7iT0jMpjBUxrAlO8O8SL
ddGOKVqK4ZVbz2VzwNav
=qa1m
-----END PGP SIGNATURE-----

--lNHgrpiV1RJx--
