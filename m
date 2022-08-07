Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5790EC19F2A
	for <linux-fstests@archiver.kernel.org>; Sun,  7 Aug 2022 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiHGPbg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 7 Aug 2022 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHGPbf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 7 Aug 2022 11:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62864EE
        for <fstests@vger.kernel.org>; Sun,  7 Aug 2022 08:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D5D260F06
        for <fstests@vger.kernel.org>; Sun,  7 Aug 2022 15:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF6AC433C1;
        Sun,  7 Aug 2022 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659886293;
        bh=AX0HZ9GfU+fAXQkAgyj3MSu/hcw6jeJlmDlsXOPNKIA=;
        h=Date:From:To:Subject:From;
        b=fNjEOAL712vkItniMGlGjVfR5IcacovFaF2rEbL7QM26hyRcDVfKkX8Zj/khlUMQL
         AQj5hgFsypuNxtDi38coQMSN1fMhEBDYeD5hwCKhoC0nZAhxJ7TXBtWPKPpgNfhHFG
         AmOU9kZstLK271CMmcO3N4jt2mS3U/eT5Jbfhu0pHE9f9hb9+K1NZxmVcwZLoAwb82
         jd2ND3jETAoh7PEKP0tvqDSpVt2J6adlBda2PkXRvgeNG2awM3jZCTF3/MplVImYkj
         929kjcfu44c3yVO7cMP6IbKw5BDC4ISADF05amavre5eTaciPh41BC8v5yUrMeehAx
         MG2nX3VnyfjAQ==
Date:   Sun, 07 Aug 2022 23:31:27 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.07.31 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OfgqYyGrh4PJ"
Content-Disposition: inline
Message-Id: <20220807153132.0AF6AC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--OfgqYyGrh4PJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.07.31 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

b91889d79e1d seek_sanity_test: use XFS ioctls to determine file allocation unit size

New commits:

Boris Burkov (5):
      [7ba973a15d0d] common/verity: require corruption functionality
      [ea5b5f41fb61] common/verity: support btrfs in generic fsverity tests
      [6defaf786e80] btrfs: test btrfs specific fsverity corruption
      [85fb8eb0523b] btrfs: test verity orphans with dmlogwrites
      [1bc6935c9b97] generic: test fs-verity EFBIG scenarios

Christoph Hellwig (1):
      [bcfb2b00eea8] btrfs/270: fix uncompressed data from previously bad mirror

Darrick J. Wong (12):
      [ef25a29fa49a] generic/275: fix premature enospc errors when fs block size is large
      [2048658186d3] misc: use _get_file_block_size for block (re)mapping tests
      [ed329de34763] misc: skip remap/fallocate tests when op length not congruent with file allocation unit
      [9f6312a49078] misc: skip extent size hint tests when hint not congruent with file allocation unit
      [181c9826a5b7] misc: avoid tests encoding FIEMAP/BMAP golden output with weird file blocksizes
      [a4acb097a6d1] punch: use allocation unit to test punching holes
      [ce205e9a4a96] punch: skip fpunch tests when op length not congruent with file allocation unit
      [793f5a860d2a] filter: report data block mappings and od offsets in multiples of allocation units
      [9e0b9837cc49] punch: skip fpunch tests when page size not congruent with file allocation unit
      [50f6d4641036] dmlogwrites: skip generic tests when external logdev in use
      [91f2a0f472e6] common/rc: wait for udev before creating dm targets
      [b91889d79e1d] seek_sanity_test: use XFS ioctls to determine file allocation unit size

Jeremy Bongio (1):
      [d628ffcb3278] ext4: add test for ext4 uuid get/set ioctls during fsstress.

Josef Bacik (1):
      [4e040ac3c568] btrfs/257: not run if we have compression enabled

Naohiro Aota (1):
      [2925f3b7f773] btrfs/253: skip on zoned mode as we cannot change the chunk size

Qu Wenruo (1):
      [9347bb488cde] btrfs: add test case to make sure btrfs can handle one corrupted device

Sun Ke (2):
      [88ac8622fae1] ext4: set 256 blocks in a block group then apply io pressure
      [affcc6dd6735] ext4: resize an ext4 which resize_inode feature is disabled but has reserved GDT blocks.

Theodore Ts'o (1):
      [33ac1a74fb63] report: add support for the xunit-quiet format

Yang Xu (4):
      [196721f3b730] xfs/270: Fix syntax error
      [b994a3bc4395] xfs: test xfs_db whether still can get corrupted field value
      [b7962b76ec24] xfs: test mkfs.xfs whether terminate getsubopt arrays properly
      [8a74eaaebe2a] xfs/191: Add missing xfsprogs commit


Code Diffstat:

 .gitignore             |   1 +
 check                  |   2 +-
 common/btrfs           |   5 ++
 common/config          |   1 +
 common/filter          |   4 +-
 common/punch           |   3 +-
 common/rc              |  41 +++++++++++-
 common/report          |  21 ++++--
 common/verity          |  48 ++++++++++++++
 src/Makefile           |   5 +-
 src/seek_sanity_test.c |  36 ++++++++---
 src/uuid_ioctl.c       | 105 ++++++++++++++++++++++++++++++
 tests/btrfs/253        |   2 +
 tests/btrfs/257        |   3 +
 tests/btrfs/261        |  87 +++++++++++++++++++++++++
 tests/btrfs/261.out    |   2 +
 tests/btrfs/270        |  11 ++--
 tests/btrfs/270.out    |  34 ----------
 tests/btrfs/290        | 172 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/290.out    |  25 +++++++
 tests/btrfs/291        | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/291.out    |   2 +
 tests/ext4/057         |  64 ++++++++++++++++++
 tests/ext4/057.out     |   2 +
 tests/ext4/058         |  33 ++++++++++
 tests/ext4/058.out     |   2 +
 tests/ext4/059         |  41 ++++++++++++
 tests/ext4/059.out     |   2 +
 tests/generic/017      |   2 +-
 tests/generic/031      |   1 +
 tests/generic/064      |   2 +-
 tests/generic/116      |   1 +
 tests/generic/118      |   1 +
 tests/generic/119      |   1 +
 tests/generic/121      |   1 +
 tests/generic/122      |   1 +
 tests/generic/134      |   1 +
 tests/generic/136      |   1 +
 tests/generic/137      |   1 +
 tests/generic/144      |   1 +
 tests/generic/149      |   1 +
 tests/generic/153      |   2 +-
 tests/generic/158      |   2 +-
 tests/generic/162      |   1 +
 tests/generic/163      |   1 +
 tests/generic/164      |   1 +
 tests/generic/165      |   1 +
 tests/generic/168      |   1 +
 tests/generic/170      |   1 +
 tests/generic/181      |   1 +
 tests/generic/183      |   1 +
 tests/generic/185      |   1 +
 tests/generic/186      |   1 +
 tests/generic/187      |   1 +
 tests/generic/188      |   1 +
 tests/generic/189      |   1 +
 tests/generic/190      |   1 +
 tests/generic/191      |   1 +
 tests/generic/194      |   1 +
 tests/generic/195      |   1 +
 tests/generic/196      |   1 +
 tests/generic/197      |   1 +
 tests/generic/199      |   1 +
 tests/generic/200      |   1 +
 tests/generic/201      |   1 +
 tests/generic/275      |  15 ++++-
 tests/generic/284      |   1 +
 tests/generic/287      |   1 +
 tests/generic/289      |   1 +
 tests/generic/290      |   1 +
 tests/generic/291      |   1 +
 tests/generic/292      |   1 +
 tests/generic/293      |   1 +
 tests/generic/295      |   1 +
 tests/generic/352      |   1 +
 tests/generic/358      |   1 +
 tests/generic/359      |   1 +
 tests/generic/372      |   1 +
 tests/generic/404      |   2 +-
 tests/generic/414      |   1 +
 tests/generic/455      |   1 +
 tests/generic/457      |   1 +
 tests/generic/470      |   1 +
 tests/generic/482      |   1 +
 tests/generic/483      |   4 ++
 tests/generic/495      |   4 ++
 tests/generic/501      |   1 +
 tests/generic/503      |   4 ++
 tests/generic/515      |   1 +
 tests/generic/516      |   1 +
 tests/generic/540      |   1 +
 tests/generic/541      |   1 +
 tests/generic/542      |   1 +
 tests/generic/543      |   1 +
 tests/generic/544      |   1 +
 tests/generic/546      |   1 +
 tests/generic/574      |  38 ++++++++++-
 tests/generic/574.out  |  13 ++--
 tests/generic/576      |   1 +
 tests/generic/578      |   1 +
 tests/generic/588      |   2 +
 tests/generic/673      |   1 +
 tests/generic/674      |   1 +
 tests/generic/675      |   1 +
 tests/generic/677      |   4 ++
 tests/generic/683      |   1 +
 tests/generic/684      |   1 +
 tests/generic/685      |   1 +
 tests/generic/686      |   1 +
 tests/generic/687      |   1 +
 tests/generic/688      |   1 +
 tests/generic/692      |  64 ++++++++++++++++++
 tests/generic/692.out  |   7 ++
 tests/xfs/069          |   1 +
 tests/xfs/114          |   2 +
 tests/xfs/166          |   4 ++
 tests/xfs/180          |   1 +
 tests/xfs/182          |   1 +
 tests/xfs/184          |   1 +
 tests/xfs/191          |   7 +-
 tests/xfs/192          |   1 +
 tests/xfs/193          |   1 +
 tests/xfs/198          |   1 +
 tests/xfs/200          |   1 +
 tests/xfs/203          |   4 ++
 tests/xfs/204          |   1 +
 tests/xfs/208          |   1 +
 tests/xfs/209          |   1 +
 tests/xfs/210          |   1 +
 tests/xfs/211          |   1 +
 tests/xfs/212          |   1 +
 tests/xfs/215          |   1 +
 tests/xfs/218          |   1 +
 tests/xfs/219          |   1 +
 tests/xfs/221          |   1 +
 tests/xfs/223          |   1 +
 tests/xfs/224          |   1 +
 tests/xfs/225          |   1 +
 tests/xfs/226          |   1 +
 tests/xfs/228          |   1 +
 tests/xfs/230          |   1 +
 tests/xfs/231          |   1 +
 tests/xfs/232          |   1 +
 tests/xfs/237          |   1 +
 tests/xfs/239          |   1 +
 tests/xfs/240          |   1 +
 tests/xfs/241          |   1 +
 tests/xfs/248          |   1 +
 tests/xfs/249          |   1 +
 tests/xfs/251          |   1 +
 tests/xfs/254          |   1 +
 tests/xfs/255          |   1 +
 tests/xfs/256          |   1 +
 tests/xfs/257          |   1 +
 tests/xfs/258          |   1 +
 tests/xfs/270          |   6 +-
 tests/xfs/280          |   1 +
 tests/xfs/312          |   1 +
 tests/xfs/315          |   1 +
 tests/xfs/322          |   1 +
 tests/xfs/326          |   1 +
 tests/xfs/329          |   1 +
 tests/xfs/346          |   1 +
 tests/xfs/347          |   1 +
 tests/xfs/436          |   1 +
 tests/xfs/507          |   3 +
 tests/xfs/533          |  34 ++++++++++
 tests/xfs/533.out      |   5 ++
 tests/xfs/537          |   2 +-
 tests/xfs/549          |  29 +++++++++
 tests/xfs/549.out      |   2 +
 171 files changed, 1216 insertions(+), 86 deletions(-)
--
Zorro Lang
zlang@kernel.org

--OfgqYyGrh4PJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmLv2R0ACgkQlNbPkfr2
tMxDoA//Rdqw2kSXtNbKPHNEoJprPOGdd0s7c/6z4BFuGAoVPVbgK7VapiG7AQT8
yI7f2bE1luxUUYS1xseiEDyRhB5xJtiyVxze9uwZbAaqWzoZjVdqtsRbSKhQPe9C
6izA1OO6QSdcVHalCQYA0JYFNqPTJG0x0CxC7Co1W97Krxegde7wzQBtwnePVRp4
IiBUKFflpoS62t7tEOdRqcRwfR/3PGr+2Fqebk9k8t4WQVsG0o3wB3sLzSRx44Y2
RoHQYaG3bUOU+swhsSwIGBBhuzAtpSVt0seMlWXGhm6n+j0JZHeNnxo+6FAHUmkY
9ob9W0Luu1ev7eA9NSDFp/41twZo0H58g0QnGqC8pkB4afv6mLp7P0qmhfqiuFh6
en8B9TwvBkUokPz/j71Y+1V7MTiFvnyI42C3YYf6hLcJZ8PGvAvi8M/VALG8ZxZ4
CzoaWQQL0J2X4hr9lH0OxmEo/ZUAzioIXQeZDfmb728X5l/n6wKOaq0ZA8J17XHw
ZrHJJ22sEvg8frGHOI8FbXzt3Sgk1NBNiInLWn3wbrwyLWA+HeUBmkKjzZxVj8TL
RD2sm97uefVJEoRFBdSMJPfG/PTW3RSm5GLz3Tdj+s6CSzQCvqHt3GTQ3NnGzhUP
HE9NdTAo081XVCDvuXuwC5pjT8/W1V9gjiXXaCM+murBqwURP8k=
=rrcD
-----END PGP SIGNATURE-----

--OfgqYyGrh4PJ--
