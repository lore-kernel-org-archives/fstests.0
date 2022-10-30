Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB1FA373D
	for <linux-fstests@archiver.kernel.org>; Sun, 30 Oct 2022 10:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJ3KsS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 Oct 2022 06:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3KsS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 Oct 2022 06:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7EB1A1
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 03:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB1DB80D47
        for <fstests@vger.kernel.org>; Sun, 30 Oct 2022 10:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50B3C433C1;
        Sun, 30 Oct 2022 10:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667126894;
        bh=fALNMd5HMyFrrJfl+Gc1u7N8kJSA3ziM2L6ogX/pjdI=;
        h=Date:From:To:Subject:From;
        b=dqUH/8a/BzimeCSnAX36oKrnVl/NkpmktanbpQ+WWtJkXL4wnI1pflb5vyXLQif0M
         ML9BYoWRQ66jk0j8J/0mSSU4FHQPSYBNpWQKFuQM/hn8lP+4FlDS74tOQ47I0/Dblg
         +V7bw51lsMAz/BYvBWanukrORA274F65wWmPEFnQaw2bLqofBudmW+JTo6AI7ZgZIw
         odihEVV64ybJsg4zNhvwpgTLLeV521wXf/lJoP83JBkUWCKYoL+IamuMDfAqskOKU8
         GNPeVpEsgMFa8ZNcV10sQbjEo+3gzg4mk9yX07xOQ84GDreXrXE0/gtf4z7cfu8q+Q
         VVG8PkYaQE5pQ==
Date:   Sun, 30 Oct 2022 18:48:11 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.10.16 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="g3XcXSODHVr8"
Content-Disposition: inline
Message-Id: <20221030104813.D50B3C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--g3XcXSODHVr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.10.16 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

a75c5f50584e fstests: get section config after RUN_SECTION checks

New commits:

Darrick J. Wong (6):
      [81a2acdc6d3a] check: detect and preserve all coredumps made by a test
      [ff4e41531f71] check: optionally compress core dumps
      [3436c281c43b] populate: wipe external xfs log devices when restoring a cached image
      [fe535b38337f] populate: reformat external ext[34] journal devices when restoring a cached image
      [fbeba9696c47] populate: require e2image before populating
      [e94831608039] fstests: refactor xfs_mdrestore calls

David Disseldorp (2):
      [436cb87154a4] lsqa.pl: fix --header output
      [bd19653e345f] seek_sanity_test: drop unused pagesz

Filipe Manana (3):
      [c21c99b4d30e] fstests: add missing require of xfs_io fiemap command to some tests
      [31a16db46b73] fstests: add fiemap group
      [fa7644ccaa14] generic: test fiemap reports extent as shared after cloning it

Josef Bacik (1):
      [a75c5f50584e] fstests: get section config after RUN_SECTION checks

Theodore Ts'o (1):
      [317d1c6cd84b] ext4/053: remove test for i_version mount option


Code Diffstat:

 README                 |  4 +++
 check                  | 29 +++++++++++++---
 common/config          |  1 +
 common/fuzzy           |  2 +-
 common/populate        | 43 ++++++++++++++++++++---
 common/rc              | 26 ++++++++++++++
 doc/group-names.txt    |  1 +
 lsqa.pl                |  2 +-
 src/seek_sanity_test.c |  1 -
 tests/btrfs/004        |  2 +-
 tests/btrfs/079        |  2 +-
 tests/btrfs/137        |  2 +-
 tests/btrfs/140        |  2 +-
 tests/btrfs/199        |  2 +-
 tests/btrfs/200        |  2 +-
 tests/btrfs/211        |  2 +-
 tests/btrfs/257        |  3 +-
 tests/btrfs/258        |  3 +-
 tests/btrfs/259        |  3 +-
 tests/btrfs/260        |  2 +-
 tests/btrfs/263        |  2 +-
 tests/btrfs/276        |  2 +-
 tests/ext4/001         |  2 +-
 tests/ext4/034         |  2 +-
 tests/ext4/053         |  1 -
 tests/ext4/308         |  2 +-
 tests/f2fs/002         |  2 +-
 tests/generic/009      |  2 +-
 tests/generic/012      |  2 +-
 tests/generic/016      |  2 +-
 tests/generic/017      |  2 +-
 tests/generic/021      |  2 +-
 tests/generic/022      |  2 +-
 tests/generic/032      |  2 +-
 tests/generic/043      |  2 +-
 tests/generic/044      |  2 +-
 tests/generic/045      |  2 +-
 tests/generic/046      |  2 +-
 tests/generic/047      |  2 +-
 tests/generic/048      |  2 +-
 tests/generic/049      |  2 +-
 tests/generic/058      |  2 +-
 tests/generic/060      |  2 +-
 tests/generic/061      |  2 +-
 tests/generic/063      |  2 +-
 tests/generic/064      |  2 +-
 tests/generic/092      |  2 +-
 tests/generic/094      |  2 +-
 tests/generic/110      |  2 +-
 tests/generic/111      |  2 +-
 tests/generic/115      |  2 +-
 tests/generic/177      |  2 +-
 tests/generic/225      |  2 +-
 tests/generic/255      |  2 +-
 tests/generic/301      |  2 +-
 tests/generic/302      |  2 +-
 tests/generic/305      |  2 +-
 tests/generic/316      |  2 +-
 tests/generic/326      |  2 +-
 tests/generic/327      |  2 +-
 tests/generic/328      |  2 +-
 tests/generic/352      |  2 +-
 tests/generic/353      |  2 +-
 tests/generic/372      |  2 +-
 tests/generic/414      |  2 +-
 tests/generic/425      |  2 +-
 tests/generic/473      |  2 +-
 tests/generic/483      |  2 +-
 tests/generic/516      |  2 +-
 tests/generic/519      |  2 +-
 tests/generic/540      |  2 +-
 tests/generic/541      |  2 +-
 tests/generic/542      |  2 +-
 tests/generic/543      |  2 +-
 tests/generic/578      |  2 +-
 tests/generic/654      |  2 +-
 tests/generic/655      |  2 +-
 tests/generic/677      |  2 +-
 tests/generic/679      |  2 +-
 tests/generic/695      |  2 +-
 tests/generic/702      | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/702.out  | 23 +++++++++++++
 tests/overlay/066      |  2 +-
 tests/shared/298       |  2 +-
 tests/xfs/129          |  3 +-
 tests/xfs/180          |  2 +-
 tests/xfs/182          |  2 +-
 tests/xfs/184          |  2 +-
 tests/xfs/192          |  2 +-
 tests/xfs/193          |  2 +-
 tests/xfs/198          |  2 +-
 tests/xfs/200          |  2 +-
 tests/xfs/204          |  2 +-
 tests/xfs/207          |  2 +-
 tests/xfs/208          |  2 +-
 tests/xfs/209          |  2 +-
 tests/xfs/210          |  2 +-
 tests/xfs/211          |  2 +-
 tests/xfs/212          |  2 +-
 tests/xfs/213          |  2 +-
 tests/xfs/214          |  2 +-
 tests/xfs/231          |  2 +-
 tests/xfs/232          |  2 +-
 tests/xfs/234          |  3 +-
 tests/xfs/252          |  2 +-
 tests/xfs/253          |  3 +-
 tests/xfs/284          |  3 +-
 tests/xfs/291          |  3 +-
 tests/xfs/336          |  3 +-
 tests/xfs/344          |  2 +-
 tests/xfs/345          |  2 +-
 tests/xfs/346          |  2 +-
 tests/xfs/347          |  2 +-
 tests/xfs/432          |  3 +-
 tests/xfs/443          |  3 +-
 tests/xfs/503          |  9 ++---
 116 files changed, 330 insertions(+), 121 deletions(-)
--
Zorro Lang
zlang@kernel.org

--g3XcXSODHVr8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNeVjoACgkQlNbPkfr2
tMyYag/8Cqv87NJLGbqq6vXmeKMH46CMjj4amOXZpcDGxL0JVWxYxTMC2xtD/WSD
nS6xc0fUbqnPLEJChHk3x830GxjslXGIOG/LB21FRwWuRHhaBbE6cbJaI/Sbo3WG
D070+nrwNN53vdlLBBGVZMDGyFt1qH84EUOen78jwDXbdp63dLSaHQZnhksAAkFv
7ZNT7Px9bSKFsr9a//1xzL8NKL0oWytfKQoC+bnANdysTpdbgR0JqV4fiRGHRGJN
OW1rc1Ieojgh9P4j9nOG4kn9/6m5v9rO3TxAvsLK+Ci732OnUz3NgB1DUW4Wapj8
hYguZ23LZ98vwLR9k33B6mV/W5I9l2AfrkEwK9eQszQEB9lWfgvaGEnGbbFzbwzS
lny2g7WlBVKj1LoK4ao1L9vAHk6AKe/SEe7evNaiBXITpy7KNsJfVEHWKb0Fawle
M2PIs8wF157OTwG8EPzYXLA/XY7fyivFX2GTDibsDZWOEgJ9OO8dNPqGgEcJJRSr
/kvFvp71Eq67ENIUybC5/kBMC1cQ6Ocs7aotg+C/YplVZv+3UKhgTgLvrOGRapft
LfqgMq3h/39orts7BwXUQnAB8eSNvok0EMi5aI+X+Q0ki8rOsJPB6tqWe94tEaik
Hv+xXe5bQsTOdZNXbFHu0LN5EkqVihEV/0Z/jFZIOuqgyY/DK9Q=
=AtqZ
-----END PGP SIGNATURE-----

--g3XcXSODHVr8--
