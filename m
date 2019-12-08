Return-Path: <SRS0=dvpu=Z6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7AC43603
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Dec 2019 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BBB20409
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Dec 2019 17:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgD8L4F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLHRNy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:13:54 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:42947 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRNy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Dec 2019 12:13:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id o11so4785989pjp.9
        for <fstests@vger.kernel.org>; Sun, 08 Dec 2019 09:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=IRQy9qN7Oss4lIkqVhphelYsE3pRI/Zp8EtqOioqq1E=;
        b=kgD8L4F8ChQD+yvySnj2hW37hOFLydVPkKFbzn3uKLqoISUaarNbYe4V/FdkLbBiyr
         Lcf95g1OBg5zgcgnSY41d+ZRIJISC4GXQL9cqOkUmACo8roQ/+YM/IbcShXdaqEWtUWF
         /Pn1sm5kZzkAyRHLbxu5Obe7Ry98oi4QQG0wMXD0uhaa+4n38vyz8XPLGikJ7Ypd2Yva
         PtTw22G7tq4SMOw9Zz6mJIMSQXX9/sk1ZrmZG+vF3lzY7ZYngPvF8Or7QnYvFsqhoqhA
         rvritjwLx7xFxRo4SsomUagf/55e2j7QOTxlBLPQTHvVgTMQVLhf1JKekzW3R7TuWgwd
         WDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=IRQy9qN7Oss4lIkqVhphelYsE3pRI/Zp8EtqOioqq1E=;
        b=eysa7fZXU25+6x+e/SXvMuT/F7EOhXb80U70Jhcpc4klYz3GV5PHxxHSfiat2lkYE0
         1+5LaVrG0bQchipqcRSORRtF18UvSwv5eXxQOG4zgHQpPGJlAxnRc9rLe/TnWKtC7c+N
         c8RYVWMOwAtLh35VJMHYhPjx3mRF8uSZexWo/BkqIUF4iVhbnpS9mToj0hZYueWd2keT
         fLi/+dDVhww3dgqiRIu6bu4g4lLzer0+kBeuB6rnNMnjuiWVkY23s1fxFRqZpmhuQoO9
         KSHdGziA5aPhiOwjCeqYpm6qqaa4WMzrlWcabTw+Y7YWekWZa0+PgjWv8zELkT84qk1l
         QVGQ==
X-Gm-Message-State: APjAAAUzYSoVVZN2ufe73sTaXqFzwamtFHhyzdXMPT6TC7nTyVUSofB4
        dLxn0/eSId4g2yyMp9JtBRc60jNJ
X-Google-Smtp-Source: APXvYqwjifQC9+w9e6XU+zfge06oegfhkxuDW6faWrt4psd/9zebC34wFAkJQEtJVVYDJZdxaEx8DQ==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr2832231pjn.85.1575825233312;
        Sun, 08 Dec 2019 09:13:53 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 68sm22098541pge.14.2019.12.08.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:13:52 -0800 (PST)
Message-ID: <5ded2f50.1c69fb81.ac815.9e61@mx.google.com>
Date:   Mon, 09 Dec 2019 01:13:47 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 568920df38f4
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ddZIzAdjnzUq"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ddZIzAdjnzUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is another new tests and bug fixes update, and the
three new tests all should pass with latest upgream kernel. Also thanks to
Kusanagi Kouichi for fixing some old & hard-to-find bugs!

Thanks,
Eryu

The new head of the master branch is commit:

568920df38f4 generic: test splice() with pipes

New commits:

Darrick J. Wong (2):
      [8c9705b7987e] xfs/148: sort attribute list output
      [568920df38f4] generic: test splice() with pipes

Kusanagi Kouichi (4):
      [5568077041bb] generic/386: Fix _filter_quota_rpt
      [ccef999f47b5] common/rc: Prevent _scale_fsstress_args from consuming -n
      [8acea1c0228d] generic/{075,122}: Use $RESULT_DIR instead of $here
      [37520a314bd4] fstests: Don't use gawk's strtonum

Omar Sandoval (1):
      [313f26e05fa8] generic: truncating mixed written/unwritten XFS realtime extent

Zorro Lang (1):
      [0a36980542cc] generic: test mount move semantics


Code Diffstat:

 .gitignore            |   1 +
 common/filter         |  22 +--
 common/rc             |   8 +-
 src/Makefile          |   2 +-
 src/splice-test.c     | 173 +++++++++++++++++++++++
 tests/generic/075     |  10 +-
 tests/generic/112     |   6 +-
 tests/generic/386     |  10 +-
 tests/generic/589     | 182 ++++++++++++++++++++++++
 tests/generic/589.out | 374 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/590     | 104 ++++++++++++++
 tests/generic/590.out |   2 +
 tests/generic/591     |  42 ++++++
 tests/generic/591.out |   7 +
 tests/generic/group   |   3 +
 tests/xfs/009         |  10 +-
 tests/xfs/148         |   2 +-
 tests/xfs/148.out     |   4 +-
 18 files changed, 929 insertions(+), 33 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ddZIzAdjnzUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl3tLtIACgkQJlKqKVyP
52PyHxAAz1qVJPj3ACpeSfV3zSxB5hs3kvVlpmp/TwH+aAuCssf9I0DOBxl/p+Z1
cBPfvr25DVaqVw2o2tFih9XiB3NlrBaJ7wck0xz5gIhd95CnZgJTvy69Vx9UAitJ
WxHE/L31t4x6j0yl0UBmMGEDPq27pXR+eEK4mhb7Xjm3U6DbMnU70c0FiJBcC5YU
UHawqxN4BDif83FNJpKZaNv/6KWgXeh8HCkPHmduV4W7CrLuCKtzPCxgbDPo4Krt
KnJliAoIpNIL5qttS/fOxATCYIqYL8y/77V2IzteJevleJlVrI57KbW1AuYwqCFj
Zfm45DyxV1QqcD6epK46xPSppSXT2+yO+bAOHyxoTZbtBNesSUxW4ErFANlOo/5w
KalDRXW6uSmSeJtOWEYuVwUAg9O+zWuEyMQ0eYxzrDS/LOjvnkbcpBEFRQdskJNy
slj32xMAmJINZtbEXuudbrAF3AyvT+nASzuZ8FkAHHf9/waaFQShlX8bIKA3d8TW
gN/TcfzaNI2e8a4FyW8J0eQbV90BEowU73hMgyKdZIMF7/uh2z5TfyWEQBclidAe
HLQpUdkXAwMmQKPE8YtQJV8Myn/PbfGAq208ctkqXrbVk4mFKfu9S645cnXygEKP
8rZkXpbgzaHJfQs8JQw+EMjwBD0OTc7O68w2gtrVWb++r6bguv0=
=t/ZV
-----END PGP SIGNATURE-----

--ddZIzAdjnzUq--
