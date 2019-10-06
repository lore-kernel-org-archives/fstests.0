Return-Path: <SRS0=R/5/=X7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5091AC4360C
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Oct 2019 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171FC20862
	for <linux-fstests@archiver.kernel.org>; Sun,  6 Oct 2019 15:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYZoS4kC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfJFPIH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 6 Oct 2019 11:08:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33647 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPIH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 6 Oct 2019 11:08:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so7037368pfl.0
        for <fstests@vger.kernel.org>; Sun, 06 Oct 2019 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=8IJrri1q3Wj2PyWh4tE5qJDwIvEWiQYCE7g+XnFDqVU=;
        b=vYZoS4kCV8rQLYjS5CQRj9aGBO9vF1mn6JfTC+/xwg+GwYhyr8mTsKoIG2+qMzERLe
         llENT+loTbZe5TCnhzATNi1X5D58fkWlquG5KjN6j8ruJQUqBwSr5B6rt5M8DWm3YXOC
         2IjJS2l0JklwSjGSqANTSqCWKFfDEAcvTggaAOMnjjCU28Kp2i2WFr5lVrz2QlfBNdUW
         PZrLxEAXPl5D7pruqCUOlEhtrIB9XzBV2g9buGt8ip8cB2x2kkKycWrZhxHdtCNseDt+
         C5+92N4xvyKXlHWRqOnUvnONhRQ5imJeYxjCY54z72SKcDl1R3buYYcPT8TE0domjLLN
         uTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=8IJrri1q3Wj2PyWh4tE5qJDwIvEWiQYCE7g+XnFDqVU=;
        b=rBJz4q7FpdBpzarLoNJ9C0q1/F6rV3/P+SYZ+f+EBALUq1o3IAe+8G3NkxnSS95h+p
         iMV3MwyerzhQcrtCdqzdg3TWgVei9fJz9wbeZmbF07hdxJWkrC+LAKcDoL3iRlJ+vK6v
         uk2zNI/CJlNuAjzeaorDPyIMtx7nMeM1bHBNLETzfHEBZ1JdKTWj4lbgE+ryc544CeeZ
         JWueyux0tcMMI9S/Vlr2ANbYJh4b2/NkNs1PiaqokAEnbjTvaFQLvIEZGLnZliqOs371
         DTvvwi/WykKRx/9aD2YxtfTrP2ohw2hB1SNcLelw0eLZ0lc56bVvFiskW8kQiQrGjmRC
         tj+Q==
X-Gm-Message-State: APjAAAXRZfH35u98COsBkRPzcIRWfXZYIX88yjm+jWP26wtk9y9/MDG0
        UeoGIUq52FmlY1kPCxmeqp5ZuuDf
X-Google-Smtp-Source: APXvYqzvDM0yN7vY6Vtb0qp8Fl4rD743GjJ+cTDbQQ48R7jN/8adiROV+4s44/opjevBl//+s2KsqA==
X-Received: by 2002:a63:1608:: with SMTP id w8mr26152808pgl.223.1570374486223;
        Sun, 06 Oct 2019 08:08:06 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y28sm13758789pfq.48.2019.10.06.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 08:08:04 -0700 (PDT)
Message-ID: <5d9a0354.1c69fb81.98520.97e7@mx.google.com>
Date:   Sun, 06 Oct 2019 23:07:57 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 94c19d60a2ce
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ryPggeHGbgei"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ryPggeHGbgei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a relatively big update, which contains 11 new
patches, includes 5 new test cases and other random bug fixes.

New failures I've noticed in this update:
- btrfs/194 and btrfs/195 currently fail with latest kernel on btrfs
- generic/568 fails when testing on XFS
- generic/569 & generic/570 fail on all filesystems that support swap file

There're still two big patchset that need review (lease tests from Ira Weiny
and fs-verity tests from Eric Biggers), hopefully I'll review them in next
week.

Thanks,
Eryu

The new head of the master branch is commit:

94c19d60a2ce btrfs: test balance profile convert functionality

New commits:

Chao Yu (1):
      [f45d9b2fecd1] generic/493: add missing dedupe group

Darrick J. Wong (1):
      [db8feee94964] generic: check that we can't write to swap files

Filipe Manana (1):
      [b727d8af324c] btrfs/036: fix sporadic failures when unmounting scratch filesystem

Max Reitz (1):
      [c599af2ca621] generic: fallocate two bytes at block boundary

Nikolay Borisov (2):
      [74f448265ac2] common/rc: Remove special handing of 'dup' argument for btrfs
      [94c19d60a2ce] btrfs: test balance profile convert functionality

Po-Hsu Lin (1):
      [771f879c1a06] check: convert spaces to tabs in help msg

Qu Wenruo (2):
      [fa85aa649760] btrfs/011: Fill the fs to ensure we have enough data for dev-replace
      [c0eab1ea2317] btrfs: Add regression test to check if btrfs can handle high devid

Zhihao Cheng (1):
      [4cec72bb1691] overlay: Enable character device to be the base fs partition

Zorro Lang (1):
      [7ddb754f15ce] common/xfs: wipe the XFS superblock of each AGs


Code Diffstat:

 check                 |  12 ++---
 common/config         |   6 +--
 common/rc             |  18 ++++---
 common/xfs            |  40 +++++++++++++++
 src/swapon.c          | 135 ++++++++++++++++++++++++++++++++++++++++++++++++--
 tests/btrfs/011       |  42 +++++++++++++---
 tests/btrfs/036       |   7 +++
 tests/btrfs/194       |  86 ++++++++++++++++++++++++++++++++
 tests/btrfs/194.out   |   2 +
 tests/btrfs/195       |  84 +++++++++++++++++++++++++++++++
 tests/btrfs/195.out   |   2 +
 tests/btrfs/group     |   2 +
 tests/generic/568     |  60 ++++++++++++++++++++++
 tests/generic/568.out |   4 ++
 tests/generic/569     |  70 ++++++++++++++++++++++++++
 tests/generic/569.out |  14 ++++++
 tests/generic/570     |  56 +++++++++++++++++++++
 tests/generic/570.out |  12 +++++
 tests/generic/group   |   5 +-
 19 files changed, 628 insertions(+), 29 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--ryPggeHGbgei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl2aAukACgkQJlKqKVyP
52PanRAAnzX1YHiY3XheeOHhd8jmbmS0N3ImPdcxZ8XNx9R2a3SwyksA1Ezh0tnv
vetql8xsXcp+o1f0IZdJIz3sXzGNwwgG4opkW6PctIYjShElfkcFV8SSdZ8PAxiB
DgkVqH7912k4R7Wbzos9cVSGTlIbbMjsXdTXuJVcZL+akQV3q9V55ZluM28X4vQz
ZuPTbc0soqNSUfeQzmT+QfWNQBkf2Wlmx//a/UpshLHsROJuOEthkKiWJtfHdfIz
2eXwwO8Y2eGp9wywiQH+CF7CC4cIj04RC9DQS72qmLiXKMraKxZL7sNqAnUqRL5h
fT3uBXCT4hMex/a1eiQ0Fm9qYOu8xX/FVughElCRdtaAZsUmUdcMZkkDIRiKITPU
N2b/wf9UVCnrsxGBSZz037OUxWxuFSRSL7iFDYDuM+wzURLuHqhqkZoT4sSlULwX
xslMOQ0I9CxSrpsm87mBbJSqW5RZbtogQ3IQYgxfc2yRKiLF+p1rxc2a1wg97oW2
KJ/i8udurCOscyOj4fANARbJu3T/AcqnRR/73phyoIV4JiQ6OVnAVgs4szHNbyBv
6845zMGFohX1Dk0PnPVZeOwImejTboPbH5eh7n2UwBIysZ/TAbZlzdd3EatIrJqY
9f5FWVg9O9wv+O3lEcyHuPfskBfM4PZkSZa7SGh3SDoJPZ0V024=
=bMai
-----END PGP SIGNATURE-----

--ryPggeHGbgei--
