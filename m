Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC3EC433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 16 Oct 2022 12:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJPMVk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 16 Oct 2022 08:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPMVj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 16 Oct 2022 08:21:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05AA32D91
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2022 05:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AE0CB80B88
        for <fstests@vger.kernel.org>; Sun, 16 Oct 2022 12:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4353FC433C1;
        Sun, 16 Oct 2022 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665922894;
        bh=TmW8Y3ZlELKbmldCEHq5DYuQ5wmx0k/Z6Jm3hwS/Z10=;
        h=Date:From:To:Subject:From;
        b=qFxZ7MRAsIX8jRwEgkbG4G6pmW+fwNqYmfnEYQfc9aEdm4n27cFPbUDTrBDtpB8l0
         bBgDFayhzi/XlSjheRJklvYD1/iqL4UR3Jp7zDebbl9uQyoE1dHYwLyTLJjWQbLkh3
         8vDIg6/ybWM7SQIqpwR9SHPh9T0NRQn/8GpKu8JR6UgPtEiQUqVI0bTbyx0pEWIvwb
         SLN714b+hvZEFVK2G/O9IpgdaGaWJEGfMOotSOqeBn8C78WKfoFzwFRO3avtmBMsCu
         p8vL6OjrKAnjJ3AXdNyXwi3lKTStlOm7i7eTTvku59EW1qLQbWOELDG9+jik3VW2nM
         QfEujEvaUh3zg==
Date:   Sun, 16 Oct 2022 20:21:31 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to a75c5f50584e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eenQvPYC0oTM"
Content-Disposition: inline
Message-Id: <20221016122134.4353FC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--eenQvPYC0oTM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.10.16 release.

Release Notes:
1) This week we have one new test case -- generic/702, it fails on btrfs for
   a known fix.
2) A new test group name "fiemap" can be used now.
3) A new global parameter -- COREDUMP_COMPRESSOR can be used to choose a
   compressor to compress coredump file (if there's). To use this parameter
   you can set it as COREDUMP_COMPRESSOR=gzip or other compressor.
4) The i_version mount option test has been removed from ext4/053.
5) A small change on fstests section config part, it won't affect old general
   usage. If you have some special usage, and hit something wrong, please
   send email to tell us.

More improvement and update are in this release, details as below. Thanks for
all these contribution!

Thanks,
Zorro

The new head of the for-next branch is commit:

a75c5f50584e fstests: get section config after RUN_SECTION checks

New commits ([N]ew, [U]pdate):

Darrick J. Wong (6):
[U]      [81a2acdc6d3a] check: detect and preserve all coredumps made by a test
[U]      [ff4e41531f71] check: optionally compress core dumps
[U]      [3436c281c43b] populate: wipe external xfs log devices when restoring a cached image
[U]      [fe535b38337f] populate: reformat external ext[34] journal devices when restoring a cached image
[U]      [fbeba9696c47] populate: require e2image before populating
[U]      [e94831608039] fstests: refactor xfs_mdrestore calls

David Disseldorp (2):
[U]      [436cb87154a4] lsqa.pl: fix --header output
[U]      [bd19653e345f] seek_sanity_test: drop unused pagesz

Filipe Manana (3):
[U]      [c21c99b4d30e] fstests: add missing require of xfs_io fiemap command to some tests
[U]      [31a16db46b73] fstests: add fiemap group
[N]      [fa7644ccaa14] generic: test fiemap reports extent as shared after cloning it

Josef Bacik (1):
[U]      [a75c5f50584e] fstests: get section config after RUN_SECTION checks

Theodore Ts'o (1):
[U]      [317d1c6cd84b] ext4/053: remove test for i_version mount option


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

--eenQvPYC0oTM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmNL9yMACgkQlNbPkfr2
tMyJthAAuT/MmVpQ+RTxgKVdE+VKYSA938QrhehhI8bSYHfbbibjeXE3E+Ym4LsN
TZg+p4GLNNBP31Ohp9MQnSck8rUN5j09YoBBs8oxGS7dG4lRF0MFoDrgQfS14rhR
Db+C2FQbBc0hnxqT3CRzI84h0W60sfTPwijLyNpvgwRNw6MXWxQTlhiVrmENFYXM
uY2laLZ5Ib9FfPosQX9wPOMKfh/WU8oFjZGKMIDxokfknwTBxrFiUMMCZBvQw6sh
0EYxIQPuM6AR+2k9ypdzNlHQ+BBFAl7VmVFKynTGbi1TtZS/lgwvh67VbyONbCz6
5LylOVya32AJsBq67mC76TaNqfrTQM4/myF44wCk0g76mhpMoWmO1Gou/romUp5D
NnRqbYfg//OcqHnGU3bLuccW/egEpNky91PBlR8eYiutmNwVmnljjv7QMUPS/our
1+3OgIn42EF7/2Bwvmd4wwnlGmU8S8bpU4CcPkQLmm22bLB3T9uGPo6vW2KQMR/t
qYPAPQAfgB+wvG19ShYcDVMEBTbRI6ojGK9F18dI/fbBMeuCdWM4GOZqIuF9Lvk8
Vg8XagITMgekFUiXVT30AYIQ1PvgkDTXicdc/z+EeRM7qi/p0yVDitipNXBxgR/2
Kf5kmrBHkdkMu2EgXkce5Y+Uo3oKHDwNLQL9l0iwN4o3pDyfwz8=
=w50w
-----END PGP SIGNATURE-----

--eenQvPYC0oTM--
