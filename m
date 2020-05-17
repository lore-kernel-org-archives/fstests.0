Return-Path: <SRS0=PZom=67=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDBC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FB1206D8
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWGuqhYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgEQQ4d (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 May 2020 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEQQ4d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 May 2020 12:56:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50DFC061A0C
        for <fstests@vger.kernel.org>; Sun, 17 May 2020 09:56:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y18so3706539pfl.9
        for <fstests@vger.kernel.org>; Sun, 17 May 2020 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=kTd5xUqN5anQJncKEwA1bpEUDBD3MVu03iv937Cdxwo=;
        b=YWGuqhYLWhfoDipggi8mEbyjx8j3Lm+T/C7JFxlUuaDhoRdNzCut/DfXgtVxanvLbK
         R/6cdwfyr9jtcNfjl1tIXKeFC2Pu82jgZN06R453WwIGK5M0zhr0gt6YFsmPLHv/wzor
         B4lFiJiXyJ1hM4XvuhrEAHAMK+js7JYZvuQeB25LWO12eci8vLtERLxkzIJpgbzc+M2h
         suwHP16JFK0K8dJBg091RclUA4BaSsx5dilRiE/GTzNwsv9Qo8TKhZoWL2KB2U9NPMJf
         DOhsw6W5P/T921Ok99v6s9R1h1ztPUj3d1ML0yJk7KB8fRblQaD05ocUoEh8r5AbFVlE
         q4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=kTd5xUqN5anQJncKEwA1bpEUDBD3MVu03iv937Cdxwo=;
        b=D5WJkupzrv0kyu3UG2vGwVOZw9SE8AsvOjHv2FEQhbc4B3NB46ojh1jki+0KyCsNjk
         HZ2i8Q0EK0iR8REa6s4ZvwQRLOHhPLwz1LN1CB+IEkgYUvyqKON0EFK7HG8yOyeAcBlv
         6nVreDbFATJiEIf+IVKUtWyx0K5RRAnV1STxWh/abT15hDFFPNvwIeSAjaHRTZWjcwl9
         bHvHOe4j56Zae7mHCRcCPEnCFNqBD2PxTmvn2nRLGqRwftOwS/7YXSdXjtut8v554LX1
         2PGuY9cOoJHT8ATvGrrSRJSMIj8+4Zta4L2n0zhZ2TS/JFwrgHnzrCVD7tegEIIM7FPI
         Zs3Q==
X-Gm-Message-State: AOAM530rrA3y8MZ7FK/E6EZSx8jikO0BokDm7fhqT+qSZSP8LBjygsov
        psPaIDhZgjF5FAQwpo0XYafnTPV6
X-Google-Smtp-Source: ABdhPJzVAZI+JDG2BC0q9LDEUuHLE48wi+jt/lA/Wc1ggijjdZwnL01HISXNwnTTfM4pocGzt/BtjQ==
X-Received: by 2002:a65:608c:: with SMTP id t12mr11823962pgu.46.1589734591788;
        Sun, 17 May 2020 09:56:31 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id s199sm6716226pfs.124.2020.05.17.09.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 09:56:30 -0700 (PDT)
Message-ID: <5ec16cbe.1c69fb81.f4ef.e44d@mx.google.com>
Date:   Mon, 18 May 2020 00:56:27 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to e2e468d4dd85
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MQFl2rdWv7oN"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--MQFl2rdWv7oN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. overlayfs ganis a new test to exercise the newly added
whiteout inode sharing feature (still in overlayfs-next repo), and a new
generic test to cover the syncfs writeback error, and this test currently fails
with latest Linus tree. Other updates are various fixes as usual.

There're still some pending patches sitting in the list, like the new xfs tests
posted by Darrick. Hopefully they'll be picked up or reviewed in next update.

Thanks,
Eryu

The new head of the master branch is commit:

e2e468d4dd85 btrfs/14{2,3}: use dm-dust instead of fail_make_request

New commits:

Chengguang Xu (1):
      [1ee4e5f83d2a] overlay: test for whiteout inode sharing

Eric Sandeen (2):
      [1636dd169e27] generic/506: fix _require test, use xfs_io vs chattr
      [52794c5a8a5f] fstests: update sparse file & negative timestamp tests for exfat

Jeff Layton (1):
      [2e21bf376e9c] generic: test reporting of wb errors via syncfs

Omar Sandoval (1):
      [e2e468d4dd85] btrfs/14{2,3}: use dm-dust instead of fail_make_request


Code Diffstat:

 common/dmdust         |  35 +++++++++++++++
 common/rc             |   5 ++-
 tests/btrfs/142       |  88 ++++++++-----------------------------
 tests/btrfs/143       |  90 ++++++++------------------------------
 tests/generic/484     |  84 ++++++++++++++++++++++++++++++++++++
 tests/generic/484.out |   8 ++++
 tests/generic/506     |  12 +++---
 tests/generic/group   |   1 +
 tests/overlay/073     | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/073.out |   2 +
 tests/overlay/group   |   1 +
 11 files changed, 294 insertions(+), 149 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--MQFl2rdWv7oN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl7BbH4ACgkQJlKqKVyP
52PYlRAArOMvJZsj2w/D7w319psF3UdQ1dskvu9MX2Hz/U0rfODea04wO6Y8vJIC
uPFfyUeIR2XGK0vUJN+9UDAiwPEGR/AwD/dPpwZkvrt3VtV11PJgq2NFYbZrUcWV
oDPUacPX+fU6EHNFEynBz/W156f7IZuDgtbQsrfcVFg3FZttn4ypPd8zBqv6ZnI4
VUXefnHwpWKSLGst97pJpdrI6FK7EzcF8CSUAMGuTG4EniEnwwjFun2VPJIU63zf
6ZMO8dPlv8pimV+r+o8re/7tEXJEEvXpvqTMVk23mLsVVZFj5BEP1pb3ygS5o993
tlefwAlF8Bjk5m5uOHPT+T1iLyoTaEIvDz59NEUR2+e977nwyPDllchk6rjxCnwx
itvACByUZLEVbSceRrAio/mVp0iqqAuUUj0xr/gv/3kz1rOysAu0DctxWSesbklp
PhknuWbT00/swcgFyMRORSHWQKqLYNGZbHmIyxQDCA1nwy2yvXUYJlYIhBHkfBib
GGV5Vn1T/DbvMnT5RX9Z2DVrtSIgt9CyhPM9w0ccs+G/awAJlnugmxYyAnem5LAa
A+N0RDQHt2hqahRKaR4oW1rNQ+QuOlwjQwLDZiM5FM5av0bCTGxgrmkTt0asjU7d
GxQzTF8EluP4I9Uxt3HYR2j6FFux3ObKzbSafMu9nA85OYSG3cM=
=C1P+
-----END PGP SIGNATURE-----

--MQFl2rdWv7oN--
