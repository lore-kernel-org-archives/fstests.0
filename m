Return-Path: <SRS0=HuhN=YU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBECCA9EAF
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Oct 2019 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572A20717
	for <linux-fstests@archiver.kernel.org>; Sun, 27 Oct 2019 11:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qR7ReG5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJ0LIR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 27 Oct 2019 07:08:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39576 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJ0LIR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 27 Oct 2019 07:08:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so3888937plp.6
        for <fstests@vger.kernel.org>; Sun, 27 Oct 2019 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=/BMx1QrZVzuR8i6v4wzpywmWFTTB2ZsRZQXG/1QabvE=;
        b=qR7ReG5Jpa91ykmBjfGTir/6hbw3WhwC8zEWh81hjtL2mjtu1Q63diZb77zDvaG/hH
         nJ4bbsZY2nVDSA1wjsP+VJEJ1EAUhjOOtPvlorwR22u+ospkrzFTq+ko1i28+iV1lDFl
         bMwCsLWOlgdZwqe12hHKxTdSK12MSddR23HKutCZ9ECNzoBS/bN9/BGGzNrmYOoCqiav
         Nlrx1uVd5yzoKhUKqkx0dYrQXO0Yhwwm2DzUWp563+ORCwdZbuqmvlaRUps8sHprUHrI
         6UHC3AaOu43wZxb3FiriTUs6nMiytzHKGYuQ5gWvWRWW2Wsu5gbpD+U4DLb1HtRaQN1w
         tCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=/BMx1QrZVzuR8i6v4wzpywmWFTTB2ZsRZQXG/1QabvE=;
        b=MzLh+/zr1hsvgsFMnEDSzD3GEDWMXiK318lLuxWFYli6xMQBwhLTuycY1DE5ZMFDA5
         BPx+3yQyvInDo3o9AuXLB16e3kOYLfir6HqMvBZobmUknu0crUPwm8NIw3rSesvugcOL
         hodxVjqR7KjdFSvUlzBZ3AYwiQ81tATbqqCPutnIMHWHVvXogpl8B8Vb5iinVUj6TXTZ
         Q+JchAM1iL7dSwn8bA/AkfjjbRNxs6f1k31IiBkk0g7FO+4hJK/crbHlUwkGh6llNeDU
         44TWOlb6zp546xH+Htp1q2AUZKULZuHFhUZfOhIc2g8yaDBbEuwdkD983nbaA3Ff8+6M
         ZCkA==
X-Gm-Message-State: APjAAAUGSRskl2ft3ak0DN5zjPryBUg013IzabPAwF/r2XkwefQIC27A
        m3TM7AQwRaGj1q9LcaNBXIqO0nWp
X-Google-Smtp-Source: APXvYqxhGZQ9ivy66p/pupIW3MphKIsiFKZcZZLoHAuh72dAti4j+bXVjrE6siF+23TZWKdKonx/fA==
X-Received: by 2002:a17:902:a503:: with SMTP id s3mr13355332plq.203.1572174495900;
        Sun, 27 Oct 2019 04:08:15 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id i126sm8463515pfc.29.2019.10.27.04.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 04:08:14 -0700 (PDT)
Message-ID: <5db57a9e.1c69fb81.e6b74.994d@mx.google.com>
Date:   Sun, 27 Oct 2019 19:08:09 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to b2b1f60e0b7c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AsQ8RJwLizQ"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--7AsQ8RJwLizQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is another huge update, notably that I pulled in
more fsverity and encrypt tests from Eric Biggers. Also there're three new
btrfs tests and one new overlayfs test.

Note that the three btrfs all fail with current v5.4-rc4 kernel.

The patchset that adds renameat2 support to fsstress and adds new test
exercising deadlock in rename path in XFS is in a good shape now, and will
probably be merged in next update.

Thanks,
Eryu

The new head of the master branch is commit:

b2b1f60e0b7c generic: verify ciphertext of v2 encryption policies with Adiantum

New commits:

Anand Jain (2):
      [43602315cad9] btrfs: test for alien btrfs-devices
      [6344f142bcd4] btrfs: test for alien devices

Chao Yu (2):
      [3d5ce2a6f129] common/defrag: support f2fs
      [1767b2fc6fe4] common/casefold: support f2fs

Chengguang Xu (1):
      [e036a11f813d] overlay: copy-up test for variant sparse files

Darrick J. Wong (1):
      [85357715c8e5] xfs/435: disable dmesg checks

Deepa Dinamani (1):
      [03d3f75cb45c] generic/402: fix for updated behavior of timestamp limits

Eric Biggers (11):
      [f198f0647dc8] common/rc: skip encrypted direct I/O tests on f2fs
      [85bb7969ade1] generic: add an fs-verity stress test
      [4e3ef46d2980] common/encrypt: disambiguate session encryption keys
      [ca4ef3f7b981] common/encrypt: add helper functions that wrap new xfs_io commands
      [72af926020a7] common/encrypt: support checking for v2 encryption policy support
      [f78b6daf26f6] common/encrypt: support verifying ciphertext of v2 encryption policies
      [ba4414c1d4b6] generic: add basic test for fscrypt API additions
      [9866a83c5124] generic: add test for non-root use of fscrypt API additions
      [15409503aae7] generic: verify ciphertext of v2 encryption policies with AES-256
      [e764a4aba039] generic: verify ciphertext of v2 encryption policies with AES-128
      [b2b1f60e0b7c] generic: verify ciphertext of v2 encryption policies with Adiantum

Qu Wenruo (2):
      [9b56b948e90a] src/log-writes: Add new discard check point
      [24f2c46da114] btrfs: trim adjacent extents across adjacent block groups boundary

Yang Xu (2):
      [74dfaaaacd91] xfs/097: Remove wrong broken assignment operation
      [4bd44aa86be6] generic/{569,570}: use _filter_xfs_io_error to filter pwrite64

Zhihao Cheng (1):
      [b7cecbea22ba] fstests: Add path $here before src/<file>


Code Diffstat:

 common/casefold             |   9 ++
 common/config               |   2 +
 common/defrag               |  11 +-
 common/encrypt              | 183 +++++++++++++++++++++-----
 common/locktest             |   4 +-
 common/populate             |   2 +-
 common/quota                |   4 +-
 common/rc                   |  73 ++++++-----
 common/renameat2            |   6 +-
 common/repair               |   2 +-
 src/fscrypt-crypt-util.c    | 304 +++++++++++++++++++++++++++++++++++++++-----
 src/log-writes/replay-log.c |  10 +-
 tests/btrfs/197             |  88 +++++++++++++
 tests/btrfs/197.out         |  25 ++++
 tests/btrfs/198             |  77 +++++++++++
 tests/btrfs/198.out         |  25 ++++
 tests/btrfs/199             | 153 ++++++++++++++++++++++
 tests/btrfs/199.out         |   2 +
 tests/btrfs/group           |   3 +
 tests/ext4/024              |   2 +-
 tests/generic/002           |   8 +-
 tests/generic/014           |   2 +-
 tests/generic/035           |   4 +-
 tests/generic/042           |   2 +-
 tests/generic/068           |   2 +-
 tests/generic/084           |   2 +-
 tests/generic/088           |   2 +-
 tests/generic/093           |   3 +
 tests/generic/120           |  12 +-
 tests/generic/124           |   4 +-
 tests/generic/125           |   4 +-
 tests/generic/129           |   8 +-
 tests/generic/223           |   8 +-
 tests/generic/252           |   2 +-
 tests/generic/257           |   2 +-
 tests/generic/310           |   5 +-
 tests/generic/317           |   6 +-
 tests/generic/331           |   2 +-
 tests/generic/332           |   2 +-
 tests/generic/340           |   6 +-
 tests/generic/344           |  10 +-
 tests/generic/345           |  10 +-
 tests/generic/346           |   8 +-
 tests/generic/354           |   8 +-
 tests/generic/379           |  12 +-
 tests/generic/385           |   2 +-
 tests/generic/397           |   4 +-
 tests/generic/398           |  34 ++---
 tests/generic/399           |   4 +-
 tests/generic/401           |   2 +-
 tests/generic/402           |  66 ++--------
 tests/generic/402.out       |   2 +-
 tests/generic/413           |  18 +--
 tests/generic/417           |   2 +-
 tests/generic/418           |   2 +-
 tests/generic/419           |   6 +-
 tests/generic/421           |   4 +-
 tests/generic/426           |   4 +-
 tests/generic/428           |   2 +-
 tests/generic/429           |   8 +-
 tests/generic/435           |   4 +-
 tests/generic/437           |   2 +-
 tests/generic/438           |   2 +-
 tests/generic/440           |   8 +-
 tests/generic/462           |   4 +
 tests/generic/486           |   3 +-
 tests/generic/524           |   2 +-
 tests/generic/569           |   4 +-
 tests/generic/570           |   4 +-
 tests/generic/576           |   2 +-
 tests/generic/579           | 115 +++++++++++++++++
 tests/generic/579.out       |   2 +
 tests/generic/580           | 127 ++++++++++++++++++
 tests/generic/580.out       |  91 +++++++++++++
 tests/generic/581           | 144 +++++++++++++++++++++
 tests/generic/581.out       |  62 +++++++++
 tests/generic/582           |  43 +++++++
 tests/generic/582.out       |   6 +
 tests/generic/583           |  43 +++++++
 tests/generic/583.out       |   6 +
 tests/generic/584           |  45 +++++++
 tests/generic/584.out       |  11 ++
 tests/generic/group         |   6 +
 tests/overlay/066           | 130 +++++++++++++++++++
 tests/overlay/066.out       |   2 +
 tests/overlay/group         |   1 +
 tests/shared/032            |   2 +-
 tests/xfs/009               |  22 ++--
 tests/xfs/024               |   4 +-
 tests/xfs/030               |   8 +-
 tests/xfs/032               |   2 +-
 tests/xfs/033               |   6 +-
 tests/xfs/034               |   2 +-
 tests/xfs/041               |   4 +-
 tests/xfs/042               |   2 +-
 tests/xfs/048               |   2 +-
 tests/xfs/052               |   6 +-
 tests/xfs/061               |   2 +-
 tests/xfs/062               |   2 +-
 tests/xfs/066               |   2 +-
 tests/xfs/071               |   2 +-
 tests/xfs/081               |   2 +-
 tests/xfs/097               |   2 -
 tests/xfs/111               |   4 +-
 tests/xfs/114               |   2 +-
 tests/xfs/121               |   2 +-
 tests/xfs/136               |   2 +-
 tests/xfs/181               |   2 +-
 tests/xfs/197               |   4 +-
 tests/xfs/206               |   2 +-
 tests/xfs/238               |   2 +-
 tests/xfs/240               |   2 +-
 tests/xfs/241               |   2 +-
 tests/xfs/260               |  18 +--
 tests/xfs/269               |   2 +-
 tests/xfs/272               |   2 +-
 tests/xfs/274               |   2 +-
 tests/xfs/276               |   2 +-
 tests/xfs/282               |   4 +-
 tests/xfs/283               |   4 +-
 tests/xfs/285               |   2 +-
 tests/xfs/286               |   2 +-
 tests/xfs/294               |   2 +-
 tests/xfs/331               |   4 +-
 tests/xfs/335               |   4 +-
 tests/xfs/336               |   4 +-
 tests/xfs/337               |   4 +-
 tests/xfs/341               |   4 +-
 tests/xfs/342               |   4 +-
 tests/xfs/422               |   2 +-
 tests/xfs/423               |   2 +-
 tests/xfs/435               |   1 +
 tests/xfs/443               |   4 +-
 tests/xfs/444               |   2 +-
 tests/xfs/509               |   2 +-
 tests/xfs/510               |   2 +-
 136 files changed, 1948 insertions(+), 375 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--7AsQ8RJwLizQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl21ejIACgkQJlKqKVyP
52OSeg/7BRSQAZKxSvIUUDE4M7vy8FP78Hnxl14R3y3VQkX1NaPG1QfHJ/L2nzZo
M+LbzjxRICXUbT6hMLb4H8KdxiGUbpSxyG5In3yYYaYs9B5RnZ5dSgMkWrGsFW56
/ZmtxzQgzcsUq7Auz7p3dGciraMAJHyToR2MTVmFHxNrG2b4qBsd74yq7bUhoh5L
Ws1Q+eMgwy03KaGLxiN4NfeMT/nw8ZX+4EQIl1+dNDm8H8/rfyD3naClWOpIXEvg
Kq/oKxdWsF8egHKYZfrIIVIm4yujms/GG5eqrunWmS5O7xIMib1llyxTM/OADjuy
Vb24bLU6OsFRnkPenwjxppXKbwFOJJu2sqR2OaT+K2BdQMy33M0agSGap+oGCxjh
Ac4rt5HRs7K+Fy10Ajh44CxHn2hzdUvwXYYdqzmlFK8HpPSik1sKhox5XR6JZOhO
6MfUgsVYzxGSHvdv9VmjGbcIFe1AwzgK6UDOQM25bH1nzGzCRsK+r7hgLp6BbKmf
WpAJ2X2Y79wtCwQ7GI/web33KvHM7TQ3brysDBOKqtFIAj9l6TvwA+9KRyL6V8zu
EiK3BGuqXcg6XWbsFgpEuDNzAhEWXg0Jc+qMpw04Uep/OD2FlLSF9ZOl75jdRrx1
8WiefRl/Sk4/Fvsl9FsIls64m2HtzUo82xPZCk8J+RDZGG9+quY=
=ay+a
-----END PGP SIGNATURE-----

--7AsQ8RJwLizQ--
