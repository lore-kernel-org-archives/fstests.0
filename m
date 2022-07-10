Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74FCC43334
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jul 2022 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGJJlr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Jul 2022 05:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJJlq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jul 2022 05:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE3912625
        for <fstests@vger.kernel.org>; Sun, 10 Jul 2022 02:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A85461134
        for <fstests@vger.kernel.org>; Sun, 10 Jul 2022 09:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D364CC3411E;
        Sun, 10 Jul 2022 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657446104;
        bh=txxJkPIJDAStM7D0B+0dczxDNHeWITW+ptl4eOjF0jQ=;
        h=Date:From:To:Subject:From;
        b=vMW194CxWfWaAJIrXgtUSibJbH/2io5ds24I6JbuY46/WMQA+qxccQ6IlsFUCF4uD
         iexP7mbuSqpcareIOKf0erb9o4Wa1Hd0OcvUlnWTyhBKlkr78kv3v+5Tmh9GVri8zn
         s0SklKzn8Ewm/OhCFtSsxSXNi2oShRPrvKga9KGzZ3FKgSh8ybJjvN6BXHE3NGa03q
         Nq1OzHyDa8S1v6/tdVOB6NrBOd2p9E+/TASA0FEFcfjIPNkz/9JwOdr0T6NL95S2c6
         k72UQcZu6fz7AVLkzoHeoAl4JCbvJBTkrPRZsKcjC+zh3yfCPnY+aHUqYpVmBhIIt0
         0w6yDYVPPhc1Q==
Date:   Sun, 10 Jul 2022 17:41:40 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.07.03 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="384tozsPisK3"
Content-Disposition: inline
Message-Id: <20220710094143.D364CC3411E@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--384tozsPisK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.07.03 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

5834a0aab2c6 xfs: test xfs_copy doesn't do cached read before libxfs_mount

New commits:

Christoph Hellwig (4):
      [c4d2eeedf7f6] btrfs: fix the_btrfs_get_physical invocation in btrfs-map-logical
      [9de4ecd461d7] btrfs; add a test for impossible repair cases
      [504e5bcfdaf0] btrfs: test checker pattern corruption on raid10
      [6cbe7d91062d] btrfs: test read repair on a corrupted compressed extent

Darrick J. Wong (6):
      [e861a30255c9] seek_sanity_test: fix allocation unit detection on XFS realtime
      [36f382f991ef] check: document mkfs.xfs reliance on fstests exports
      [f0eb9b8d4a68] xfs/109: handle larger minimum filesystem size
      [a176070de75c] xfs/166: fix golden output failures when multipage folios enabled
      [10d5efecc0e0] xfs: test mkfs.xfs sizing of internal logs that
      [5834a0aab2c6] xfs: test xfs_copy doesn't do cached read before libxfs_mount

Luís Henriques (1):
      [56171bcb41d4] ceph/005: verify correct statfs behaviour with quotas

Theodore Ts'o (7):
      [f30169ce7341] ext4/050: support indirect as well as extent mapped journals
      [b60038cc226a] ext4/044: skip test if the file system does not have a journal
      [1800121a017d] ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
      [172b13b8e5c1] ext4/054: skip test if the dax mount option is enabled
      [9ac1dd12cd05] ext4/055: skip test if dax mount option is used
      [0a7a16123a67] ext4/035: skip this test if the scratch device does not support 1k block sizes
      [9d14711da549] ext4: create file systems with the encrypt feature as necessary


Code Diffstat:

 check                  |  3 ++
 common/btrfs           |  2 +-
 common/rc              | 16 ++++++++++
 src/seek_sanity_test.c | 12 +++++++-
 tests/btrfs/268        | 62 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/268.out    |  7 +++++
 tests/btrfs/269        | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/269.out    | 41 ++++++++++++++++++++++++++
 tests/btrfs/270        | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/270.out    | 41 ++++++++++++++++++++++++++
 tests/ceph/005         | 39 +++++++++++++++++++++++++
 tests/ceph/005.out     |  4 +++
 tests/ext4/003         |  6 +++-
 tests/ext4/035         |  9 +++++-
 tests/ext4/044         |  1 +
 tests/ext4/045         |  2 +-
 tests/ext4/050         | 58 ++++--------------------------------
 tests/ext4/054         |  5 ++--
 tests/ext4/055         |  1 +
 tests/ext4/306         |  5 +++-
 tests/generic/260      |  3 ++
 tests/xfs/082          | 38 ++++++++++++++++++++++++
 tests/xfs/082.out      |  3 ++
 tests/xfs/109          |  2 +-
 tests/xfs/144          | 51 ++++++++++++++++++++++++++++++++
 tests/xfs/144.out      |  2 ++
 tests/xfs/166          | 19 +++++++++---
 27 files changed, 517 insertions(+), 67 deletions(-)
--
Zorro Lang
zlang@kernel.org

--384tozsPisK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLKnowACgkQlNbPkfr2
tMy86w/+P8tSMdN5peS4H1MH269FWg3g3gQ5PMfHsZzYajjjU2X8tokgQYvbEvl1
pw4JmhTdj7ONuwogJTV+uDD6i2MfgZ7wfRZlA+pDvznx1hwJ1Vwp4qdg2ZLrxz2A
EzkLjJtjyEdBHmtmggJ/OEHfLgBzAE7+lNH5zSFkz1VxFIMERppITUuQwX3GUYRD
JwCvVesgMvR5QrU3GQXXemXfcW819hgUL0URBh1/Ylcv2oBZZESeaj7g2iGtGoAp
/wX30kI/iFzB6qAbIRBhM5Iunbp0U3GzZz8IalvYxIQDrn0fbz5oAWJ0QCAeKW/8
xileD+z/kVYR8NCAkrngDKnW+QrMKaPwzytyxcQFYgA1dM8YgAkGQXu6DT3SmvcR
Ga59t2BHqCo6I1XT1gvFxZ/h47t85zVMZ5BBv0/50ORna7cYomZwcuwDcdqHkkky
C7xsTitbKejI2AeGv5tE6xYLxL05zI/OmKu1hrACmweHnCzGSobS4qao+lyWlcFh
vq7SKvzCjQ+h8eWoX5dG5Aq4d7soMP511Dzws2lJiKlSJ5VLjPPF2LDubbHzoaqx
x7wrysVlzWF3O+7hmj0qzezoh2q8eNclYEEP+8g2awdngycRY935TXi1ONZ3yZEN
+oPuPEiKcjoQ4OBW4FXIZHco1lTt7mh5slcXZIM7t3amaIyk1wY=
=VCal
-----END PGP SIGNATURE-----

--384tozsPisK3--
