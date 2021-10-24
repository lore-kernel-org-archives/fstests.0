Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43658C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FF36058D
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Oct 2021 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhJXQek (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Oct 2021 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXQej (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Oct 2021 12:34:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9424C061745
        for <fstests@vger.kernel.org>; Sun, 24 Oct 2021 09:32:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e12so8111299wra.4
        for <fstests@vger.kernel.org>; Sun, 24 Oct 2021 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=TTesTb9TPjj/9NYv3dSh8CuPvRv7M5F7/KiQ47gWNJg=;
        b=juunHM1mi70q5hLanWb9AluWTGoSalzpL0p4/siiGcz1BeT6fYWLB4V+lap/Oex9bC
         7C5kwh/+2ilCyFeTo7zBdP7vB5oGL06Jd34a3GnvNWVSOYRQ89IFry9yBqTT7+AfJWJw
         8U6bejERWz/Fc1Y2FRZrjRCARZ8s6rwS+JxOehU5XeQj5dGJMKE/g3NAMAoeQAfKe92e
         D5GqePg21SPCElWNz6QKoDt30foCKEo7qzGzL6B1QBmTDNZxdY9fDRgTzG2+6OCgSh+7
         vsuj8j0JPuw5llqdwEJ/Z/YL5gM9nnSUt3EL/mSAGTvQEptgI1gOnHzPh4OlPbNCTe8j
         5gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=TTesTb9TPjj/9NYv3dSh8CuPvRv7M5F7/KiQ47gWNJg=;
        b=g+UlAqGL9O4nVitG8O/4J4ZiriSSPhFCw1JYVlJRui5jyM63074yfhw6IC3xUZ9Wbr
         S1SoRX6eNUbS5jt9xHOduJO4DrSZv8HTA+6AoWNRv98GiD8154U8PN3Nd69SympSjCuQ
         qab9qOSG2hT1TbwfWeisZs8PLTzQ+s0bVr/UttN1xvkR0sVC7WPI267ytqA093kVLKME
         /nw2S+R3sy5HutC6VLimgrC9gb9M94eITRWnWmIatfQ0GJ/kKweV18T9VqbUfT+faF9o
         A6bkgFf3cAEQAqQzO74KQcYYaUHFRDBy18/05p2HuICvr+t1My6ZHxgs9K0F/UDQYec3
         5PfA==
X-Gm-Message-State: AOAM533ztFC3L29d+DPUtOiwFEQc51QUlMMIghlrwmuAgC/n5Eat8tZX
        oQfKzC/tov3BO+58vGJ4GNYNLB/U1IQ=
X-Google-Smtp-Source: ABdhPJygv0gLxFF2ePm2vyAE/8C1h+2lY0E8ToQ+VhyQyL8zq64/14vUnfOGXNwTgW8B/zaIYigEaQ==
X-Received: by 2002:a5d:64ee:: with SMTP id g14mr16582220wri.376.1635093137179;
        Sun, 24 Oct 2021 09:32:17 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id i13sm15225433wmq.41.2021.10.24.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 09:32:16 -0700 (PDT)
Message-ID: <61758a90.1c69fb81.dac48.58ed@mx.google.com>
Date:   Mon, 25 Oct 2021 00:32:12 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 359610a43c29
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="aWnpjdZ805hc"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--aWnpjdZ805hc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal new tests & bugfix update. There're
two new btrfs tests added and one btrfs test removed. And the build system has
been fixed to work with latest autoconf.

The new btrfs/249 currently fails with v5.15-rc6 kernel and latest btrfs-progs.

Thanks,
Eryu

The new head of the master branch is commit:

359610a43c29 btrfs: test btrfs filesystem usage command on missing seed device

New commits:

Anand Jain (3):
      [cdc96c304c37] common/btrfs: add _require_btrfs_sysfs_fsid helper
      [0e35c0548abd] btrfs: validate sysfs fsid
      [359610a43c29] btrfs: test btrfs filesystem usage command on missing seed device

Dave Chinner (2):
      [7b2e36d1bc6c] fstests: autoconf has deprecated a bunch of macros
      [acb516fdfe72] fstests: groupfile generation needs force overwrite

Luís Henriques (1):
      [74055e9afecd] generic/095: align DIO read/writes with the supported sector size for the device

Ma Xinjian (1):
      [668c859d37f2] btrfs/049: remove the test


Code Diffstat:

 acinclude.m4          | 16 +++-------
 common/btrfs          | 14 +++++++++
 configure.ac          |  9 +++---
 m4/package_libcdev.m4 | 63 +++++++++++++++++---------------------
 m4/package_ncurses.m4 |  7 ++---
 m4/package_xfslibs.m4 |  7 ++---
 tests/btrfs/049       | 85 ---------------------------------------------------
 tests/btrfs/248       | 66 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out   |  2 ++
 tests/btrfs/249       | 67 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/249.out   |  2 ++
 tests/generic/095     |  5 +--
 tools/mkgroupfile     |  2 +-
 13 files changed, 196 insertions(+), 149 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--aWnpjdZ805hc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmF1hvkACgkQJlKqKVyP
52NSuxAAhTlRYSlvUq0qLzju1xcE/fyN/eNHah2my+bffDhvq+f7gIVtlnTQQoS7
qEszSIVKAQqEVkw7Xd1CoQyd37LobbYG0ZWKN7nGVwtJnQgaNhGwhVpuJMi4CzU1
yHI3K7dY6OdzQbTHhB8MQppDRaMRB8FANcUNdpvzjC400+A99CCsQGBcjCfFfwYM
Rw32MQ6AovhlynvOYkUQ1swD/YRFwajPoHIxTN+JgtlB9eO32FTzl86mfTGwE4uC
5syWxy8HGRTDhr/W1xl/qVSN0XbqfUNjMDntAuLWEYzxbDbnfekUKsZTmCJquG7/
VgEK5Iz6x1CFXZM5pIc94MmTvfLQXTHJ9aGkmnlGtiIJXPm73g89YJ36X8PRPicK
noDuYsAxpGg/wLznqTMP0KQDxuJJLM/gewJ4ZKHddXDadGspp0kFuxDgV1oB0/Mk
+15oC7ycwtXV7W3YEjJHv02+OCeBEwO/d7skLMz5rrI2UmU1bvptXikLnKP6Nd+p
CJERldigt6PUJl4ltKOvHf3utxy+abtXDMyjUW4O2M5b9sfXIygsX1Ux1YtBIcre
PktjvDh4/HA2BZMLPzVHZCUUYk8SSPbqbuhaVlMnnxX0twpjTxYZs8Vvm42O8xsn
PKjOG7EGknxtHcOCGqtWKc5c1t6W+fUditYvnI8OPXOqPiBqGlE=
=jFdw
-----END PGP SIGNATURE-----

--aWnpjdZ805hc--
