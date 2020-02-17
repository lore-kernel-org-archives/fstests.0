Return-Path: <SRS0=4lTT=4F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A62C761A6
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7DA2072C
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Feb 2020 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhStM4av"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbgBQN0c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:26:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgBQN0c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Feb 2020 08:26:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so9178648pgk.0
        for <fstests@vger.kernel.org>; Mon, 17 Feb 2020 05:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=mHebBYjUlzvQAhath1FpUvaBB0NT4aPLBEdAeuiw4io=;
        b=YhStM4avYKfnMSp5MLL8oiONGSldOcED2/02HUnBm8taJYePW84qXImFFqsRUHPOrG
         hIB4bk1fcPZ7owz1QcETi6zU5K8gsl131CWvuYP1xXfnklDdW2x9b3pBL5IUXHrawNC/
         HlkMDPzdZAuFw0IMl1MP2DFl5OAIs92CmjqLxZoxWucJbbSzLn7CTWoixsJ9yiUG1pN+
         JkgISKfEiqn790GPRK0rPhIRonckVJhM/r6f078Cg4wPlF7cPYFQ98jKH6cfTf6+ZUmG
         Gja53iYvdN5uZnM1bwBpqiNVMS5vRimONtSwRPMXir0HsEfafD5NEAMolBB0tJNdtbKW
         RVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=mHebBYjUlzvQAhath1FpUvaBB0NT4aPLBEdAeuiw4io=;
        b=XD2EG+DAtxwSCPwGWBD1LN9gThqffZ/J/809F84n50oGR7xAfLmEKojkFgDbpKpmdM
         xXcoG7LHaWwICY7rLfJy0RlcH7vcgXcqsDVFSUJWWKSnvM+0UAPKFcwVN30QY+FGJOHL
         hPVJdS3VbWiuNNfgTkwMiLBkg/KKrV2csv+07gVrzXzRSSCiNZY3pVCywGsvAePvFOir
         v131YSCT6EEJGn8fgom2lE/ILjMnCLMqS/MHx/G7jvN4HJHd14E5wZm0mwfz3/CzJv6S
         UQ1ilLr9M1Nn97iRmn0i7l541fMzO+ZJveOyVIiBl+kZDVmkmxaSZFpntF1lZOqIxlRK
         4xcg==
X-Gm-Message-State: APjAAAXg7U1oB2tYfdRG141dK/ucPnlszvVBr97UR9D7N0LJYpL/qCdV
        7mFXi6lMoKxvjXI2Pvbvj17Nmprn
X-Google-Smtp-Source: APXvYqyekL2s+TihmutrToyvJJ9O37aKQq+Af4Wz79GlXHact3c28VWc0/TfWPTB15ckVJEH31OuKA==
X-Received: by 2002:a63:3c08:: with SMTP id j8mr17787366pga.223.1581945991907;
        Mon, 17 Feb 2020 05:26:31 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id r145sm595758pfr.5.2020.02.17.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:26:31 -0800 (PST)
Message-ID: <5e4a9487.1c69fb81.368a7.1386@mx.google.com>
Date:   Mon, 17 Feb 2020 21:26:26 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 62ec71f6b29e
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oSFAYL2oKd4"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--2oSFAYL2oKd4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're three new tests added, which including one
re-created test btrfs/204 (was btrfs/172), and one ext4 test deleted. btrfs/204
still fails with v5.6-rc2 kernel, but the fix is pending in btrfs list. The
other commits are random fixes.

There're a few pending patches left in my to-review list, I think I'll catch up
soon :) And I really appreciate if someone could help review patches!

Thanks,
Eryu

The new head of the master branch is commit:

62ec71f6b29e ext4/002: remove EXT4_EOFBLOCKS_FL test

New commits:

Anand Jain (2):
      [108d8cde1c4e] btrfs: test unaligned punch hole at ENOSPC
      [26e6cda8aaf8] btrfs/179: call sync qgroup counts

Christian Kujau (2):
      [e28ee0bdac4c] shared/032: add options for reiser4
      [e7aab383558a] README: fsgqa needs a home directory too

Eric Biggers (3):
      [231f24650155] common/rc: handle option with argument in _require_xfs_io_command()
      [0d9ca511e115] common/encrypt: move constant test key to common code
      [0ea2b67b095d] generic: test adding filesystem-level fscrypt key via key_id

Eric Whitney (1):
      [62ec71f6b29e] ext4/002: remove EXT4_EOFBLOCKS_FL test

Marcos Paulo de Souza (1):
      [2f9b4039253d] common/btrfs: Improve _require_btrfs_command

Zorro Lang (1):
      [30612dc06ac1] xfs: xfs mount option sanity test


Code Diffstat:

 README                |   4 +-
 common/btrfs          |  13 +-
 common/encrypt        |  95 +++++++++++---
 common/rc             |   2 +-
 tests/btrfs/179       |   9 ++
 tests/btrfs/204       |  73 +++++++++++
 tests/btrfs/204.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/ext4/002        | 168 -------------------------
 tests/ext4/002.out    |   7 --
 tests/ext4/group      |   1 -
 tests/generic/580     |  17 +--
 tests/generic/593     | 155 +++++++++++++++++++++++
 tests/generic/593.out |  73 +++++++++++
 tests/generic/group   |   1 +
 tests/shared/032      |   1 +
 tests/xfs/513         | 335 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/513.out     | 100 +++++++++++++++
 tests/xfs/group       |   1 +
 19 files changed, 850 insertions(+), 208 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--2oSFAYL2oKd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl5KlDsACgkQJlKqKVyP
52ONjg/8D6LDUkk9k5IhXutdl6V0JYqvG8NGopGLCBwuSJTZagF3pVUK7ur02Mu0
FJ1uX3VmKZOS/WgPYNlFpvL1/ZWXpMHGHwrUF8nJYVhSTDBp9+HWfWBQDweBLR1c
JNiV7vuoiqEgToNjprPw6ptq4WJfchW0uTTdmpgaRTTqXJU4tik8u5rVzgsrrjxk
NK6hLAxsz4mVSkkWdFNiJvn55FoQtBojowl7My238ceJHXy0cibudkBpUdraZxpl
brKosMU3Bdz6S0BqDxEl89ka6QI/TrMj4YxVAz4RbyHiCaBUcTCLND2qT+ymkrvI
U2eTS7NxlN5RXpSdb1a7dH96sU8X9u2iN9Pstx+ZVrva9Lsh57hprN3ESaAEhbMB
1sXT4SUgNDDHImvOncS4vFXHfOOW2AkxeWii+7zvANLwcJDN1gkML5unm0voF2dN
KiqTSKx+bRrpjZLdzSRzPiuLyEdzmKLe8qfimjB5t+3FX2DR4MGRlC6fx8WGBSFq
Dpu3tJXp0sJwbr+v9DPmsNcVPk7WvFnk4QhmIFa5Q70eByFF8Zx9eOVk8+LC3FnK
EgUeUVvYhwJS9lqPVE7KL1DZ1JmSOEj1dOMekvJY3MASTvQk/oaHTq397U5HSXRZ
uFoDaTBz+GEvfpduQQY9GAGKezOQHEpjDll3ZWah8XJ4nItlE1Q=
=WSpM
-----END PGP SIGNATURE-----

--2oSFAYL2oKd4--
