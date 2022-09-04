Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C709FECAAD3
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Sep 2022 14:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIDOJQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Sep 2022 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiIDOJP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Sep 2022 10:09:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0238456
        for <fstests@vger.kernel.org>; Sun,  4 Sep 2022 07:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C39ECE0E7A
        for <fstests@vger.kernel.org>; Sun,  4 Sep 2022 14:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED7DC433D6;
        Sun,  4 Sep 2022 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662300549;
        bh=7Tq8vrVb0Wa3irHjIKV/xMZYn2N8Lw4QVU6nJ5ceylk=;
        h=Date:From:To:Subject:From;
        b=oC83U2k/4S09MuMLnsJM5Ii5uUb+LHr8Oo/6o0ugEBjU8w+97erxUICy5pIKMlTJz
         fkSvbQLlF3A7+bMAWpspw45ZSad2tTnMJSv+gbtuziKQhUcSXep4BzCV0EsKeXg7cv
         63To9SLqKRhfoNz8yPYre3zkFjl0shx7DX0GWGp+G3sVJmz59pW2rJoFWfDv6nC82n
         Jslo3MBQnxXv283H4108hFV4dUNyoUfHCEITsIcTbME8STAOr3dhlNNopmaurLkJn6
         fCDrlBWazgTH1tpJlox2COQJxaxrUn1WiBsU6ENlcLxyyjOFqYOOiEL8xbzpdxmDgw
         hQrVFuXc4hSwg==
Date:   Sun, 04 Sep 2022 22:09:06 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: for-next branch updated to 890c50823b64
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6ZAEWJGol1DB"
Content-Disposition: inline
Message-Id: <20220904140909.2ED7DC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--6ZAEWJGol1DB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The for-next branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

has just been updated and tagged as v2022.09.04 release.

Release Note:
1. There're 5 new cases (btrfs/272, xfs/553 and generic/695~697) in this
   release. All of them are known regression test, you can find the related
   kernel commit id in source code. Generally they won't cause panic or hang,
   so might not break downstream kernel testing.
2. Thanks Darrick keep improving eio testing.
3. ext4/053 removed "nouser_xattr" testing.

Feel free to reply this email if you have any questions. Thanks all your
contribution. More details as below.

Thanks,
Zorro

The new head of the for-next branch is commit:

890c50823b64 vfs: Add new setgid_create_acl test

New commits ([N]ew, [U]pdate, [D]elete):

BingJing Chang (1):
[N]      [ea66d27cb5e6] fstests: btrfs: test incremental send for changed reference paths

Chandan Babu R (1):
[N]      [0044157d9027] xfs: Check if a direct write can result in a false ENOSPC error

Christoph Hellwig (2):
[U]      [aa309b96fb5d] btrfs/271: include common/fail_make_request
[U]      [3e8936c3e84d] btrfs/271: use the common fail_request setup helpers

Darrick J. Wong (3):
[U]      [f3c314574d01] common/xfs: fix _reset_xfs_sysfs_error_handling reset to actual defaults
[U]      [4f929ebc5928] common: disable infinite IO error retry for EIO shutdown tests
[U]      [de3717ae0985] common: filter internal errors during io error testing

Filipe Manana (1):
[N]      [e42fa9fec802] generic: test fsync after punching hole adjacent to an existing hole

Xiubo Li (1):
[U]      [c935c7dce550] ceph/004: fix the ceph.quota.max_bytes values

Yang Xu (3):
[D]      [f9bf0d5130e1] ext4/053: Remove nouser_xattr test
[N]      [c87543428673] vfs: Add new setgid_create_umask test
[N]      [890c50823b64] vfs: Add new setgid_create_acl test


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

--6ZAEWJGol1DB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEI6yX1/+Fhk84DbzBlNbPkfr2tMwFAmMUsEsACgkQlNbPkfr2
tMy7xQ//UtALponD6vyeQA0Puvnws0A04XFX6uuH0qwPllXZrHuzCWxHsM4Qv9UH
0kRuhCzNpTP8N0Z9O9Vv4+pwhZxsA6iWgg28I9hw54auMC5q10jVzlidy+V+LvsL
XOjxkWd1Q5OQoc0aiFr9nquxPmdqFXL+7pn9MtWWTozmxb6lQEjCk9v1KgvGHsE9
wv5WCwNLs9eYh9/LMlJsgL26Sh/AnlVhhUEi9/dQ4Z5jkksX5Rv4BRvsXB5g7JR7
rQlPpU9Qp9m/k0zWQF45ty6ub+TVMvEfbih0totg3LDFeEEI38+l0FOhcTPHrP6E
3G+TiAFpo4jRHTDCewj8rcDBQ7vv/cvmj4GssXh8TCS2d8cHyGodA5X83Ve0InZn
wNwRZDxsTASv4k9KzFVDW7CZ5NtUo0n+5j4a5I/Obz1SZt87caBYEdiE8B+vouy2
qxHu9Iu6uWYkZXAnO6uUoE+hFmFWohBeGJU7F41qUFDeqN5e5iYfal2e31JqtdPc
DiFOqwMvSjdXDecV0pHZpRZwUGOSQlfaAEXjNi94mS8E9pU70P30ZzUrZGhr/PRF
Nd0f/ekCV5y5oCj65RgoPK+wi8JFcDrpsawgfBcIdjFwsL8jmMD/gKGeuz7a9sAl
UhSUQUTNoCLyVCEMcgsRNAWn1Zzade9+Qt4rTwmc6aO1u4YpcNQ=
=EnKp
-----END PGP SIGNATURE-----

--6ZAEWJGol1DB--
