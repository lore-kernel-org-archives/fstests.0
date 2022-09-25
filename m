Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A950C6FA82
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Sep 2022 12:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIYMKx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Sep 2022 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiIYMKw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Sep 2022 08:10:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860C4303D4
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2022 05:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35207B80B96
        for <fstests@vger.kernel.org>; Sun, 25 Sep 2022 12:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0F8C433C1;
        Sun, 25 Sep 2022 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664107848;
        bh=s4jazL+kQqmLQLbw8O/4jyi9hSJlqkDEomLFjHg+0Ts=;
        h=Date:From:To:Subject:From;
        b=H3moiF83ywlg5QUcGwdYcfjSyxZwnFWR65rX0RAlo49AYINpNYZcZpWiVYo2k8jSg
         0vHzHoHjPCzj/z6hUnemI944v9meMqhl1azUXiI/dBusVwaiBeaYBUP7TMYblCqojO
         2bbtPgDPCobYzK1/nk6ftegFHBNDPOjhcLuHog02/aE9Ch0mShFvBlF6UlTn+h2qdj
         d7gxSNbH6i7d5dlJvCP/XJwDhpD102lVkrT2CawatzkLHQJg79sMX4gUsLiqVDmrud
         GwklBTwYbxy6rYvIZacgLTiKkAUf/EWSY4+/LkstnzNX+sU2FSyPj/oT5Vuw5Sta03
         bUfK8XK4ep03A==
Date:   Sun, 25 Sep 2022 20:10:45 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: merge v2022.09.04 onto master branch
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZjfQbTlISBk5"
Content-Disposition: inline
Message-Id: <20220925121048.5B0F8C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ZjfQbTlISBk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated to v2022.09.04 version (merged from for-next).
[TODO here]

Thanks,
Zorro

The new head of the master branch is commit:

890c50823b64 vfs: Add new setgid_create_acl test

New commits:

BingJing Chang (1):
      [ea66d27cb5e6] fstests: btrfs: test incremental send for changed reference paths

Chandan Babu R (1):
      [0044157d9027] xfs: Check if a direct write can result in a false ENOSPC error

Christoph Hellwig (2):
      [aa309b96fb5d] btrfs/271: include common/fail_make_request
      [3e8936c3e84d] btrfs/271: use the common fail_request setup helpers

Darrick J. Wong (3):
      [f3c314574d01] common/xfs: fix _reset_xfs_sysfs_error_handling reset to actual defaults
      [4f929ebc5928] common: disable infinite IO error retry for EIO shutdown tests
      [de3717ae0985] common: filter internal errors during io error testing

Filipe Manana (1):
      [e42fa9fec802] generic: test fsync after punching hole adjacent to an existing hole

Xiubo Li (1):
      [c935c7dce550] ceph/004: fix the ceph.quota.max_bytes values

Yang Xu (3):
      [f9bf0d5130e1] ext4/053: Remove nouser_xattr test
      [c87543428673] vfs: Add new setgid_create_umask test
      [890c50823b64] vfs: Add new setgid_create_acl test


Code Diffstat:

 check                     |    1 +
 common/dmerror            |    4 +
 common/fail_make_request  |    1 +
 common/rc                 |   50 +-
 common/xfs                |   38 +-
 src/vfs/idmapped-mounts.c | 1207 +++++++++++++++++++++++++++++++++++++++++++++
 src/vfs/idmapped-mounts.h |    2 +
 src/vfs/utils.c           |   14 +
 src/vfs/utils.h           |    1 +
 src/vfs/vfstest.c         |  558 ++++++++++++++++++++-
 tests/btrfs/271           |   36 +-
 tests/btrfs/271.out       |    2 +
 tests/btrfs/272           |   88 ++++
 tests/btrfs/272.out       |    3 +
 tests/ceph/004            |    6 +-
 tests/ext4/053            |    1 -
 tests/generic/695         |   91 ++++
 tests/generic/695.out     |   15 +
 tests/generic/696         |   46 ++
 tests/generic/696.out     |    2 +
 tests/generic/697         |   33 ++
 tests/generic/697.out     |    2 +
 tests/xfs/006.out         |    6 +-
 tests/xfs/264.out         |   12 +-
 tests/xfs/553             |   67 +++
 tests/xfs/553.out         |    9 +
 26 files changed, 2248 insertions(+), 47 deletions(-)
--
Zorro Lang
zlang@kernel.org

--ZjfQbTlISBk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMwRRwACgkQlNbPkfr2
tMxYDA/9E5YQY3eDIAAT2Woj9gO3J76AXvvTaqqOWmObEEElVp9sGp35sA2C1740
9sVTQvghdYCxJrb716jx0QJypwYZVQfM2HaV2Tv0mO3u19NRkrMSr27Jd9ZeBZsn
T89aiIMJY6YHuzUDg8EQWhF9T6YopFhlfaUGS/8RL/wsR/aPo/3fb3ZiRrFqan7e
jGntLMCUhcC0cmk+PQ0T93O1WSFM3Wa5m9mqsBpFqCpqdwEBbDv7BqAON9utTiSM
vVg0m7sscWiRSO31fkEsG2o3vMvSgwIY5embsf83L+n6/M0O8UrA74wvOuyxxqf2
R7/ZLLUtaYm6UUgLzj4q/hviPxWSpt5eRiBNfQ6tGHCS03sfokQVfzHgQgl9/oqB
4urO0aEmnoFiCDsUA5iMobSmrdMe10oWKV2n9q50JPainovk6zFVtJgM2ayMPNSf
JdV0yNmnTdmmoRdG0SQeh+6D5gyxh5Wiiw9gt6WGEvXSIZrnAEsx/Taf3qoEDPI3
0KLBzWZym/FYk4iy7omWBlZqEcidmeJlXaBVaw6LkWOPZD2TndQB4sX5XMvgby7n
RMqrS+oMoNFloZVZuimAVJZGyW+CvZXtIgQgBwlBopXbuRpQl7JfgKhqKY0zVRoY
uflQE8GOPAMokItRlyJV5OO0Dj1M08kA2BvHW8qKU3oK1WezTGk=
=7UEJ
-----END PGP SIGNATURE-----

--ZjfQbTlISBk5--
