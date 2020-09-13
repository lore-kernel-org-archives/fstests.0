Return-Path: <SRS0=2o40=CW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045BDC43461
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Sep 2020 17:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71E420723
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Sep 2020 17:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAVr7z/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgIMRGw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Sep 2020 13:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMRGu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Sep 2020 13:06:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B1C06174A
        for <fstests@vger.kernel.org>; Sun, 13 Sep 2020 10:06:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t7so4255126pjd.3
        for <fstests@vger.kernel.org>; Sun, 13 Sep 2020 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=foUdD0W0o/8rncQxoKDjymV7yzQ/X7lSEoqvqM+YTQM=;
        b=bAVr7z/ssLI6mPPOgihTXFa+fzxBcpU0mw5ZV7duUUHdSJTWrnzc7zWIpBK0nEwo8N
         ocvSG5txh5jMDTsPC3s8MFoInbUuoGtYUUyQ6QrxrpgZHOS7xOzYF3I+6s3tVKaoqdx9
         GOuAEtDyWatS2X8XJtgJAUpPkfaSWT4Le0DVL8qEUn5jTPkwZRHA8+Q+D4kZUOHMO5+E
         djfWb8rss/3YXCNqoWavk3DvPKnRGFdXsBVAiXvprc7fT/71IZnaWidTJkGoQTD/y0BQ
         grD0uUZgugZA70qZZaFiXwTKwrKilxv2Eff6jLuxeCNwLgIX8FTEY0srUaRRRpyShwFJ
         AKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=foUdD0W0o/8rncQxoKDjymV7yzQ/X7lSEoqvqM+YTQM=;
        b=L7E8d6KDoDqLDa0hdHS87/5CAjf35F902jkAiGOY4y2FZr4+U/Y6LF9RtmpDoz6CTH
         cUTz0i8DJh89SNsDEmt0gPhRQfjSGD44uaqIhHQ9jYUgnRBaHrnNAcBRcpjm7hMC8Zg4
         dMHl8PrjzdGX1Ah915h9WbbMT8hXjZxhzA3JO5toK2lzS3gtyqiOZ9KMMKrkp6ov3CF8
         JLmIV56zeYHjI70Q7uv+N/LgzgUQmJnt9hsgDQtjW7C8f/sAG3pGdLzey+JHoxkLEANZ
         m6LoSYVAGFE5Y+Hnpud8nZnI5s1Cy5A9/LHLPbFpeNkvMslV3C8BmVttILsPhEJsnruq
         rPpg==
X-Gm-Message-State: AOAM532PfWL+ganAs+6myICZtK/7K61MXb+pNylvwlgCqpeCXQjwiwom
        LH0eyeZhzmE0M6t58vn7+uygRvmFpLqsDg==
X-Google-Smtp-Source: ABdhPJz77SbKpoqHQaTmr8+IRr65b32C6l8Mu5sOn1M1R4yZapjF3sbneFLf3ZSQBEHVlj5SaztM8A==
X-Received: by 2002:a17:90a:fc8:: with SMTP id 66mr6066768pjz.217.1600016808872;
        Sun, 13 Sep 2020 10:06:48 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id q190sm8419315pfq.99.2020.09.13.10.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 10:06:47 -0700 (PDT)
Message-ID: <5f5e51a7.1c69fb81.f8050.63d3@mx.google.com>
Date:   Mon, 14 Sep 2020 01:06:44 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to fc5870da485a
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MbRfPG6YWpUP"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--MbRfPG6YWpUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're a bunch of new btrfs tests and fixes in this
update, along with other random fixes. New test btrfs/219 and generic/610
currently fail with latest v5.9-rc4 kernel, otherwise I don't expect any new
failures.

Thanks,
Eryu

The new head of the master branch is commit:

fc5870da485a generic/470: use thin volume for dmlogwrites target device

New commits:

Brian Foster (3):
      [96bcbcabd0f3] generic/455: use thin volume for dmlogwrites target device
      [3713a3b37d72] generic/457: use thin volume for dmlogwrites target device
      [fc5870da485a] generic/470: use thin volume for dmlogwrites target device

Darrick J. Wong (1):
      [43d4800333ec] xfs/010,030: filter AG header CRC error warnings

Filipe Manana (1):
      [c235b26103e8] generic: add test for zero range over a file range with many small extents

Frank van der Linden (3):
      [94dcbd03b49c] common/attr: make _require_attrs more fine-grained
      [da3cdb3b91ca] common/attr: set MAX_ATTR values correctly for NFS
      [986071261061] fstests: explicitly specify xattr namespace

Johannes Thumshirn (2):
      [2beaca087b29] btrfs/011: skip if on too small devices
      [43fbe02d8741] btrfs/154: remove test for fix that never landed

Josef Bacik (2):
      [4a109ce8d36c] btrfs: add a test for some disk caching usecases
      [47306c8951bc] generic: test deadlock on O_DIRECT|O_DSYNC

Marcos Paulo de Souza (1):
      [85de6a5e5395] btrfs: check if mount opts are applied

Nikolay Borisov (2):
      [f8b84ddfa5af] btrfs/173: Adjust compress file check
      [1781a22507a4] btrfs/174: Adjust error message when setting compressed flag


Code Diffstat:

 common/attr           |  64 ++++++-----
 tests/btrfs/011       |   1 +
 tests/btrfs/154       | 169 ----------------------------
 tests/btrfs/154.out   |  10 --
 tests/btrfs/173       |   4 +-
 tests/btrfs/173.out   |   2 +-
 tests/btrfs/174       |   2 +-
 tests/btrfs/174.out   |   2 +-
 tests/btrfs/219       | 104 +++++++++++++++++
 tests/btrfs/219.out   |   2 +
 tests/btrfs/220       | 302 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/220.out   |   2 +
 tests/btrfs/group     |   3 +-
 tests/generic/062     |   4 +
 tests/generic/093     |   2 +-
 tests/generic/097     |   2 +-
 tests/generic/403     |   2 +-
 tests/generic/449     |   2 +-
 tests/generic/455     |  36 +++---
 tests/generic/457     |  33 ++++--
 tests/generic/470     |  23 +++-
 tests/generic/609     |  44 ++++++++
 tests/generic/609.out |   3 +
 tests/generic/610     |  61 ++++++++++
 tests/generic/610.out |   5 +
 tests/generic/group   |   2 +
 tests/overlay/011     |   2 +-
 tests/overlay/026     |   2 +-
 tests/overlay/038     |   2 +-
 tests/overlay/041     |   2 +-
 tests/overlay/045     |   2 +-
 tests/overlay/046     |   2 +-
 tests/overlay/056     |   2 +-
 tests/xfs/010         |   7 +-
 tests/xfs/030         |   2 +
 tests/xfs/063         |   2 +-
 tests/xfs/267         |   2 +-
 tests/xfs/268         |   2 +-
 38 files changed, 656 insertions(+), 259 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--MbRfPG6YWpUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl9eUVwACgkQJlKqKVyP
52PX0Q//fRAxPHb6vxO1HCmxx6Ss37Hx8QN/dze/dSDxfIADGHaiuwIDnyoVDsls
OfVNL/vAyWg8NSuW+icxijvXSMYaeMLzxDYbRUfR71ptfi9wgUbG9JxmAFtMGXQy
/byHvVasCuvReDTJh1wony7ZbxOiXxSFwmPyJFKLhShWKB7qqiKISttVtxL27OZX
GhJo/ACnHqdwwIFcwR7bogo/KoMvE2XGG7/JhZne+WOOmn1YSs6PTF69B6/Sx8bA
bLaC1LAvf+x3+fx735r0McbJGVevWxF18ZcTxO1mLiwt3yCZpApJDDsJW7StVkh4
lR55vZ9tREL8VfyjUiSfYVPIwDFF1CLBz+kr4HoGSkQ43Qy+Do3+hgZo/p0Ys7Jf
0w74W+WcSIwCXiDF6Lr6poVNgerk0lDzGNwYIX4gKLgWeWsmpTjSXU5ck84Eiz77
s+yp4lBc0C5ELFp1gYO3fLnw4PQ0LrWHloSlhBJJTIkvgrqWTvQOXCmowXYEeVS1
8b9iMBpjYWIqVaWqu4kmwuzyWyMGvby/xOCMQBgcmF5GgQxjO40XAtj3Ko8V5tn3
Z2s7MQeyEw1m00maDbYnco/LiBate3lHWmdbC2A99SMW0YquxZ/BvRogbJJqsjDt
WqBxilQIcnSZmbOU/6bb18krBYipNqLJ4ge8NG/0JCjoy4yLMC0=
=d0Jf
-----END PGP SIGNATURE-----

--MbRfPG6YWpUP--
