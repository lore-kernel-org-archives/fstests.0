Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F622C433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  8 May 2022 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiEHPdz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 May 2022 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiEHPdq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 May 2022 11:33:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98FFBF7C
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 08:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 882D3B80DA9
        for <fstests@vger.kernel.org>; Sun,  8 May 2022 15:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8A4C385A4;
        Sun,  8 May 2022 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652023793;
        bh=rpRXJ4x+B6/6tigoqvQZPfc5tDtqTxc3JOBnXy14MYc=;
        h=Date:From:To:Subject:From;
        b=uPzPnIaxmdXsxSnWU1ft5xTAxcbsbY3b7pSbRdVWDOJ9E4ym3FhWrfqPVgVPFuskB
         fJnUXxuzHVQK3OqamO0IrpiWUbD55Cj1b+42335yTdEerfMusFcuZCTSoxZS1wpbqB
         huOJxpV6QYfQOFm3YgFddcpCc7iVsc4dlfYCldEr+pkN95rfZvaPiNia4Y//i6gTyj
         rqDzkY9ftoiDTbXphKO/Ap35EehH1vk3VtvpmaES82tPZuJbnR7W0Rie1juC+84JiF
         rskXQXXOO0JYvygoPbGDixXjOn0qvGDP8CXhATKpWBTVgNxJXg85Ih189NRiINlPcn
         fFB+QTuNs/Rzg==
Date:   Sun, 08 May 2022 23:29:49 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merged v2022.05.01 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LdbUKnWLyhCi"
Content-Disposition: inline
Message-Id: <20220508152952.9F8A4C385A4@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--LdbUKnWLyhCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.05.01 version (merged from for-next).

Note: The master branch just merged from for-next branch, there's not new
changes on master branch.

Thanks,
Zorro

The new head of the master branch is commit:

bb04d577435d fstests: add some missing _require_loop's

Merged commits:

Christian Brauner (1):
      [31c01ce18f73] generic: add test for tmpfs POSIX ACLs

Chung-Chiang Cheng (1):
      [987700db300d] fstests: btrfs: test setting compression via xattr on nodatacow files

Darrick J. Wong (4):
      [af8aeeea48d0] xfs/019: fix golden output for files created in setgid dir
      [ad5f89ef3013] generic/019: fix incorrect unset statements
      [7f27a290aca8] xfs: make sure syncfs(2) passes back super_operations.sync_fs errors
      [e81417a0964a] generic: ensure we drop suid after fallocate

Eric Sandeen (2):
      [80a82f6926fa] xfs: test xfsdump when an inode < root inode is present
      [7753e08d22e9] fstests: remove xfs/144

Jan Kara (2):
      [858a19c5e9b0] idmapped_mounts: Prepare for support for more features
      [95c10ab90c28] generic/633: Avoid failure without CONFIG_USER_NS

Josef Bacik (1):
      [bb04d577435d] fstests: add some missing _require_loop's

Murphy Zhou (1):
      [0fd8e26141f5] chown: fix ownership format string

Rishabh Dave (1):
      [1dac95cb0d6e] cephfs: add ceph-fuse suport for ceph-fuse

Theodore Ts'o (1):
      [5528f7843b1a] generic/681, generic/682: add debugging information to $seqreq.full

Yang Xu (1):
      [298f60c81a93] generic/673: Add separate sgid stripping sub-tests

Zorro Lang (2):
      [380ee98d92e6] fstests: remove _wipe_fs from dump testing entirely
      [ab47e281b70f] fsstress: remove ALLOCSP and FREESP operations entirely


Code Diffstat:

 common/config                         |   2 +
 common/dump                           |  23 +--
 common/rc                             |  47 +++++--
 ltp/fsstress.c                        | 117 ----------------
 src/idmapped-mounts/idmapped-mounts.c | 257 +++++++++++++++++++++++++++-------
 tests/btrfs/012                       |   1 +
 tests/btrfs/264                       |  91 ++++++++++++
 tests/btrfs/264.out                   |  11 ++
 tests/generic/019                     |   4 +-
 tests/generic/070                     |   2 -
 tests/generic/099                     |   4 +-
 tests/generic/237                     |   2 +-
 tests/generic/318                     |   2 +-
 tests/generic/380                     |   2 +-
 tests/generic/597                     |   6 +-
 tests/generic/598                     |   6 +-
 tests/generic/648                     |   1 +
 tests/generic/673                     |  37 ++++-
 tests/generic/673.out                 |  24 ++++
 tests/generic/681                     |   4 +
 tests/generic/682                     |   4 +
 tests/generic/683                     | 127 +++++++++++++++++
 tests/generic/683.out                 |  33 +++++
 tests/generic/684                     | 127 +++++++++++++++++
 tests/generic/684.out                 |  33 +++++
 tests/generic/685                     | 127 +++++++++++++++++
 tests/generic/685.out                 |  33 +++++
 tests/generic/686                     | 127 +++++++++++++++++
 tests/generic/686.out                 |  33 +++++
 tests/generic/687                     | 127 +++++++++++++++++
 tests/generic/687.out                 |  33 +++++
 tests/generic/688                     |  77 ++++++++++
 tests/generic/688.out                 |  13 ++
 tests/generic/689                     |  33 +++++
 tests/generic/689.out                 |   2 +
 tests/xfs/019                         |   3 +-
 tests/xfs/019.out                     |   2 +-
 tests/xfs/022                         |   3 +
 tests/xfs/023                         |   3 +
 tests/xfs/024                         |   3 +
 tests/xfs/025                         |   3 +
 tests/xfs/026                         |   3 +
 tests/xfs/027                         |   3 +
 tests/xfs/028                         |   7 +-
 tests/xfs/035                         |   7 +
 tests/xfs/036                         |   3 +
 tests/xfs/037                         |   3 +
 tests/xfs/038                         |   3 +
 tests/xfs/039                         |   3 +
 tests/xfs/043                         |   5 +-
 tests/xfs/046                         |   3 +
 tests/xfs/047                         |   7 +-
 tests/xfs/055                         |   4 +
 tests/xfs/056                         |   3 +
 tests/xfs/059                         |   3 +
 tests/xfs/060                         |   3 +
 tests/xfs/061                         |   3 +
 tests/xfs/063                         |   3 +
 tests/xfs/064                         |   3 +
 tests/xfs/065                         |   3 +-
 tests/xfs/066                         |   3 +
 tests/xfs/068                         |   3 +
 tests/xfs/144                         | 128 -----------------
 tests/xfs/144.out                     | 151 --------------------
 tests/xfs/266                         |   3 +
 tests/xfs/267                         |   4 +-
 tests/xfs/268                         |   4 +-
 tests/xfs/281                         |   4 +-
 tests/xfs/282                         |   4 +-
 tests/xfs/283                         |   4 +-
 tests/xfs/296                         |   4 +-
 tests/xfs/301                         |   2 +
 tests/xfs/302                         |   3 +-
 tests/xfs/545                         |  62 ++++++++
 tests/xfs/545.out                     |  47 +++++++
 tests/xfs/546                         |  43 ++++++
 tests/xfs/546.out                     |   2 +
 77 files changed, 1611 insertions(+), 521 deletions(-)
--
Zorro Lang
zlang@kernel.org

--LdbUKnWLyhCi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmJ34FYACgkQlNbPkfr2
tMwg4w//cE/BIQqLI9kdCvEBUQUxcAUd08JjGopqMH0lOZdPBedDDykJAuLkM30t
ZfVGcOFZZDWX/sk3bpAHmifru7wddclWnKrMRal4dIn9tQRssoiwxqOJ8d+6rJKB
8+c9qL4Wlj6FJ9UekIp9+p1pHWVIP7lskBaUBxGSOl5Sz2tvfqTLVYp0bFbDucK5
JPviOcV5tB7o43lfaCSJXX/J+4b15fxn5+w5UAKUN1u2evNn3djzqWudXHzhaaAc
hy9wYVXgOtvAAgvppfaKk1kdp+gssqTpW1YEFV9T5uG9s6dxInlt5DIl/JZthBUj
LcjMKlZ6BoEIlasjdbVDB4KDCw8fU5zHfmb20zaPItR8uLEr2kjYujSfpopnc/9K
Fr8LN8JEN4ZWE4b8aoneiysDYLtC2zsO6Koeir/IeYwBYAc/j6QeLT4UIEPQ4QLu
72PKSU0/ISUDhQRGOETgc5hTmii1j/3D/WuDLaI+luwuqgpQA8p8EvxS+7Kp6M44
1kfA5RSm9U+EcB871OmFmCgD1u+R6wEsqGsKSRk8z6+WFq2X2SKBl8O7+/3m3L54
XrAyCtXLISUFOZ1gYmgYk4ROHUWe3guqlftnmeSlOEDFTzLcfVqpJB+/GxWNd9c3
PB8ZAYaG3j3DFE1QE+7JiAYoW6Jb7ZcQHrizAC5FG4dCLjLUNYA=
=0hfw
-----END PGP SIGNATURE-----

--LdbUKnWLyhCi--
