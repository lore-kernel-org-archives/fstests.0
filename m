Return-Path: <SRS0=/bTx=EH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D57C2D0A3
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0552071E
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="An8RYPfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAQb6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Nov 2020 11:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQb6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Nov 2020 11:31:58 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B8C0617A6
        for <fstests@vger.kernel.org>; Sun,  1 Nov 2020 08:31:56 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i7so6788036pgh.6
        for <fstests@vger.kernel.org>; Sun, 01 Nov 2020 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=AgZyQdp397ijrVis1JSmP6KCExFQBc8bGQ81O4RCcko=;
        b=An8RYPfvkwOYPZd7p8Ow/CdPVq8xVjuEjH/yTp4roxYYl35LZFqnb7uQMPDtgDBlNW
         CR/RH2R8tWKWmqXbwpMa1i9c+IPYyteHnJhuyiM+gpW+q6b3gHNqQy1bPp+Ad3bYKpQ+
         dgilWZIvhystsOv8W1xAlsOj94cNYES6LlQUg9FYJQc3XoclThZBWCne1RbU+Zty1Fa5
         N95i4uW6vzMJG+4jhalcBMwviOVO3LLvX17JuNYv7NoRFF7HFfmNSB+k1zZecQaQ6V1o
         GrnkCN+/5bCD/gmFEqBk8GAOCmRzy5Taly+8ziK9H0YD74FOk5W/7MJm7BLIWjY6UePu
         MZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=AgZyQdp397ijrVis1JSmP6KCExFQBc8bGQ81O4RCcko=;
        b=gsuoy6JKWm0XjrpyxvlFr0+l46xhV9uSfikqGbt61ZfMLqpP0cMhYAJxmgOQp0w0rk
         SH2QxKR5e8GdPsie061DthGMeZsFFoP7mXmSJaHMU0ym1iZD66fGFU8UYIr4BJDL8XQk
         KQJ1i57l940ZcgiAsgsak2bZlj6AFUK/+j88jvu0I+teafz6s66YEWRqa/Uyzt0XC22S
         V/OX4QTR0b86qBaVwKuKe3/wSe8ELl2GT2Ze/tY0EaYJ64qqUp0gBEkQFQpkVrlsdu4R
         xJQ/vG3fj9bH0atL6akvTgygrICIV/euxrZbPaK7TMpeu0ONYSGiOOl3spXl729sgoSO
         VFXQ==
X-Gm-Message-State: AOAM530Rv3Du0QOvnbmWowvbq3xAL5JNzqW+VQBPf5LoUIKwaFsr7uC2
        RxGlRzp1Vs3kIsVADL0iQAXtn00CTrE=
X-Google-Smtp-Source: ABdhPJxa1yPiP0VfYgX3OdgpsP25NuHyZPSQEdXjuxvqfuZeql1RhCiNJwcirBnqezes4H52Z4RUbw==
X-Received: by 2002:a63:4141:: with SMTP id o62mr10127669pga.363.1604248315634;
        Sun, 01 Nov 2020 08:31:55 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id u194sm11992952pfc.176.2020.11.01.08.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 08:31:54 -0800 (PST)
Message-ID: <5f9ee2fa.1c69fb81.abde7.f5f4@mx.google.com>
Date:   Mon, 02 Nov 2020 00:31:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to b09ba3318ebb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2Zsnr0CLQQnP"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--2Zsnr0CLQQnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. We're having more ceph-specific copy_file_range tests
in this update, one fs-encryption test and one new ext4 test. Others are random
bug fixes.

Thanks,
Eryu

The new head of the master branch is commit:

b09ba3318ebb generic: test that encryption nonces are unique and random

New commits:

Eric Biggers (4):
      [c8e29174c923] generic/397: remove workarounds for wrong error codes
      [faf1f9356ef1] generic/395: remove workarounds for wrong error codes
      [59b43407a9cc] generic/398: remove workarounds for wrong error codes
      [b09ba3318ebb] generic: test that encryption nonces are unique and random

Filipe Manana (1):
      [eb7f35472b2e] fstests: add missing remove of the $seqres.full file for some tests

Luis Henriques (3):
      [10f3f9707cca] ceph: add copy_file_range (remote copy operation) testing
      [5f460552c8f4] ceph: test combination of copy_file_range with truncate
      [fce32d21f868] ceph: test copy_file_range with infile = outfile

Xiao Yang (1):
      [27774be17b64] ext4: Add a test for inline_data vs. DAX inode flag

Zorro Lang (1):
      [f81829d98ca6] common/repair: filter unknown block state properly


Code Diffstat:

 common/ceph           |  23 +++++
 common/rc             |   1 +
 common/repair         |   4 +-
 tests/btrfs/033       |   3 +
 tests/btrfs/036       |   3 +
 tests/btrfs/114       |   3 +
 tests/btrfs/115       |   3 +
 tests/btrfs/205       |   3 +
 tests/ceph/001        | 233 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/ceph/001.out    | 129 ++++++++++++++++++++++++++++
 tests/ceph/002        |  79 +++++++++++++++++
 tests/ceph/002.out    |   8 ++
 tests/ceph/003        | 116 +++++++++++++++++++++++++
 tests/ceph/003.out    |  11 +++
 tests/ceph/group      |   3 +
 tests/ext4/047        |  56 ++++++++++++
 tests/ext4/047.out    |   2 +
 tests/ext4/group      |   1 +
 tests/generic/395     |  31 ++-----
 tests/generic/397     |  25 ++----
 tests/generic/398     |  35 ++------
 tests/generic/613     | 118 +++++++++++++++++++++++++
 tests/generic/613.out |  16 ++++
 tests/generic/group   |   1 +
 tests/shared/298      |   3 +
 25 files changed, 840 insertions(+), 70 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--2Zsnr0CLQQnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+e4pUACgkQJlKqKVyP
52O76Q/+Igwny2+o+LiPkF2MmJ6Ac0QxQ+SV31MpldgslPVDk3nCRvDUkzfERBZc
6ru9TzgGR1w114CKwrPAq5i2Vt/+3FS8vfhKwHm4jARNZFM/XzfBiTYqg+9Pre5Y
pFokTwDyx6A9m1mEnZWN/gz1UsR5zy+LZGRo7uxebz4giU9jH+KIeTdplrIeg06j
ma2oOa9pH15FA38XIuAtnKHu4ruZb/4A2QQpoTnAFinhWn9i3ws4QD0OdjW9XEj0
0K4T5F0+pQ2KrVoHpCdIzn2TgE6UFvmLhyCS0Aed1tamSrF7pdUIVnK8Kb6WoTi3
6aagHkr01ZEXMOs/Oq1FYnS6c5I/UAJ2ZmHAVWPTXMe1w2QSVwbTsNbeb1WjbADt
+ux6QmAtYNlaBRvw2FYk4InDi90nF4Gc3Mb/dAPbhMWy/xCMx0gdatzWKvATzTnM
xbTiaAVDru8R7YwPhXT28MGdhO6TV8W84D7ahDAMBbj8FeIlwLZAh/tw2XxRL9/4
8SOw83jR25Dvy9ekispVZ3oTUuWVnkZh9dGJhLHTURnOg7+ZzggEq7I78ktTcKbk
ZSlqmPy67+A0qSODeohstgffaJEUeWQASYLCUq4+Tu2HCr95FYS1JbFWtm4+H5zw
2ZYwV5R6K2szUkPVpYkHMjMXiXhZy0GfH6i60mIynBM7uOqS/E8=
=PhIK
-----END PGP SIGNATURE-----

--2Zsnr0CLQQnP--
