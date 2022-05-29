Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B17C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiE2J5T (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2J5R (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 05:57:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808849C9E
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 02:57:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7A0BB80ABB
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 09:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03632C385A9;
        Sun, 29 May 2022 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653818233;
        bh=3jp1h81BX9qkA+iDI0GqlK/HuKuDlpSKLLrfntHPW0M=;
        h=Date:From:To:Subject:From;
        b=Hxg7GUteH2NpqDNiWaPoIPQEDbFGZRd/vL3uSbcj04ckJsN8YTp6EzLSgdnIRvUkm
         HU9m3Xl//fjIZWTHBrtIM0JVk57ZjHhqs+TnCD80/ILTG0gmVQ1sLQu15JP/nscndQ
         ZXkVXUQd2fHZBbyDNuiwxF4hX1H9oriOmnQPPVgRltpuvXI9OgH045cg6w9jiXGBqB
         z96Q5cnDi/gEgd/5CAEVTBPvNg8OZoA18KFR5DGBqKXmiIuFZxcItaM68JOQ3aqth9
         2RRKKlgyBSpk64i1DivDrTTZkUUkxoRuBDhW1dl9qwEmfkTCKnrz9wbBELB+LyYWGM
         hsCg4wSZAtstA==
Date:   Sun, 29 May 2022 17:57:10 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.05.22 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TrxF9LVUOdak"
Content-Disposition: inline
Message-Id: <20220529095713.03632C385A9@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--TrxF9LVUOdak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.05.22 version (merged from for-next).

Thanks,
Zorro

The new head of the master branch is commit:

6849744065ea tools/mkgroupfile: help the cases of group.list in number order

New commits:

Christoph Hellwig (1):
      [4c577efa1ee6] fstests: add a btrfs read_repair group

Dave Chinner (10):
      [6a1c3ac03574] fstests: tests should not source common/rc directly
      [fbb154f67dac] common/rc: fix test init performance regression on XFS
      [307f05149987] fstests: filter quota warnings
      [9a392f8d44e5] xfs/122: add attribute log formats to test output.
      [dbcc5493176a] xfs/348: golden output is not correct
      [460c460464cb] xfs/148: make test debuggable
      [6812c3b2603b] xfs/148: fix failure from bad shortform size assumptions
      [c1941d6f5d47] xfs/191: remove broken test
      [e6d4d963c698] fstests: remove xfs deprecated test
      [1a04a7c9e674] fstests: fix group list generation for whacky test names

Eric Biggers (1):
      [a7b978f8f55b] generic/556: add test case for top-level dir rename

Gabriel Krisman Bertazi (1):
      [3b878b60a77e] generic/556: Filter touch error message

Ojaswin Mujoo (1):
      [ee264b3fa676] common/rc: Modify _require_batched_discard to improve test coverage

Zorro Lang (3):
      [0110e1eeb73d] generic: soft quota limits testing within grace time
      [2eb19ea49c65] generic/603: use project quota create and restore common helpers
      [6849744065ea] tools/mkgroupfile: help the cases of group.list in number order


Code Diffstat:

 common/filter                      |    8 +
 common/quota                       |   52 +
 common/rc                          |   20 +-
 common/xfs                         |   12 +
 doc/group-names.txt                |    1 +
 tests/btrfs/140                    |    2 +-
 tests/btrfs/141                    |    2 +-
 tests/btrfs/142                    |    2 +-
 tests/btrfs/143                    |    2 +-
 tests/btrfs/150                    |    2 +-
 tests/btrfs/157                    |    2 +-
 tests/btrfs/215                    |    2 +-
 tests/btrfs/243                    |    1 -
 tests/btrfs/245                    |    1 -
 tests/ext4/053                     |    1 -
 tests/generic/556                  |   25 +-
 tests/generic/556.out              |    4 +-
 tests/generic/603                  |   36 +-
 tests/generic/644                  |    1 -
 tests/generic/645                  |    1 -
 tests/generic/647                  |    1 -
 tests/generic/677                  |    1 -
 tests/generic/678                  |    1 -
 tests/generic/679                  |    1 -
 tests/generic/690                  |    1 -
 tests/generic/691                  |  107 +
 tests/generic/691.out              |   34 +
 tests/xfs/018                      |   72 -
 tests/xfs/018.op                   | 4714 ------------------------------------
 tests/xfs/018.out                  |   17 -
 tests/xfs/018.trans_buf            | 1821 --------------
 tests/xfs/018.trans_inode          | 2609 --------------------
 tests/xfs/050                      |    9 -
 tests/xfs/081                      |   55 -
 tests/xfs/081.out                  |    4 -
 tests/xfs/081.ugquota.trans_inode  | 3091 -----------------------
 tests/xfs/082                      |  101 -
 tests/xfs/082.op                   | 4714 ------------------------------------
 tests/xfs/082.out                  |   39 -
 tests/xfs/082.trans_buf            | 1821 --------------
 tests/xfs/082.trans_inode          | 2609 --------------------
 tests/xfs/122.out                  |    2 +
 tests/xfs/148                      |   15 +-
 tests/xfs/153                      |    9 -
 tests/xfs/191-input-validation     |  324 ---
 tests/xfs/191-input-validation.out |    2 -
 tests/xfs/299                      |    9 -
 tests/xfs/348.out                  |    4 +-
 tools/mkgroupfile                  |    5 +-
 49 files changed, 270 insertions(+), 22099 deletions(-)
--
Zorro Lang
zlang@kernel.org

--TrxF9LVUOdak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmKTQzYACgkQlNbPkfr2
tMxyqxAAtLMxWvUAeNpUtaaQMgWnsV7112XeHmTF0URe3NWgOOALveDYDY0Gdjzr
ZnjLMaydOpKQI733RwHExoN5ZfvXowfXw6pJ2fbuu6zZZq/9blaht7lYT0A6vVd7
u+mpRcwlIO/fhBFQOYzoSBkE4J5l0q4MejYXEy5A2b+osDEYIfvlVINdkFbUGWqo
CGddMHLmj4NNMvS61IVMgCyN4xX959/KRByqSCZehhZgwQYZdnqcJKtx7KX+0nC0
unvsEQo1vtYPvSpjQgffZqvX39n0hjPPpHSJI63OAl65MkCyCd/XvPyUrHSbVBku
xXz2PGE/h1el4rnJ9rfzpabrPL+Bz06YeIZs3xqvqeYXhvggZW6xPFE2JUnfkbAK
3i5WNCJuMxKYMsykrKlRRNIyAqee7ROm+yANWbB8eNc9jcWlxGotH70HnPD+pTUf
iiBNAwRFfhczl+E310GckhSgYJa4ETZneMn7rdQnVYI9EO223ptzkATxYHhK9K39
H3x8/0R9cQ9DM6PWQX8QNygQ4zMnsbDJ5Mw1O2FKxLPEl5NQmw4VSlVOVYKAKObp
SUCxDwR5Yw1cqkjnK5UBamBlEela/I8HZY6D9RU6oOOy3enYFEUokujd39z2U/hH
fIR9CLp+qU11nl4PcKCd0GM8w6gzhxdVIyXfaLyaA+PJ5QsPjTo=
=Iquy
-----END PGP SIGNATURE-----

--TrxF9LVUOdak--
