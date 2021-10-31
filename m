Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9073AC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Oct 2021 15:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679FF60F46
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Oct 2021 15:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJaP2p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Oct 2021 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhJaP2o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Oct 2021 11:28:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D81C061570
        for <fstests@vger.kernel.org>; Sun, 31 Oct 2021 08:26:12 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so7096538wmj.5
        for <fstests@vger.kernel.org>; Sun, 31 Oct 2021 08:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=uKFTSlHl+yA98J+ljSkcqpa8brOYKXNCSXX8WsFZj70=;
        b=Ch9y5apJPDo5eTHJ5EgIJ9o6rU6VBIA+p84/nTeuMDHwKeewLae2bqzH3FM4eeCFOW
         AnMSYXDa58Reomu0g9M+LYdUgmEpwJ2KZO062MZqV5b2chDSQHfnLhCGhyQkskYkK5W8
         Xwy8mJymOJHrTgw6/4crua7xzNnxCBuzhn8K9TpldJtHBhY0cqOd6OpA1UM8v550mwh2
         6GcAcflRQ79t1lptAgCDZ/7LcR2jjuv4WNfM7HGLm7wPm0WNK0QpdgP/xLq3fnSwUERE
         ZDqKaaX9EUCtXZxOXriM+DUyqLbs/0sdMWWI1L/ayT7N3rAg9rBg1mIxmqBsx380IDYg
         wazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=uKFTSlHl+yA98J+ljSkcqpa8brOYKXNCSXX8WsFZj70=;
        b=xbrzNSo+EVH7Z5kM47vYFwwbtzKVM2mCEkjZf4lkZUV6uCZ2HKss01v4+a0s9EhKX+
         M2Bgo1S/82vJjtsqKaZNMKZETt9qQYEqXAaiQxOjS1sv4FqJ5Tv0/Nw3sJWgOu8vGMp3
         hDp6h0L/WfbOIaUvtQgnvGpQLHiE9EZvqVAsORdDWU8OuWFiGFjTyQrdce+3ym3z4HpO
         sup/FsgQHTe0tq0OBNJcxUnNDv8ho6o0BC98uW6ZnV9zISXkeK2OnXYnPAJG80muvRVS
         vgD9fHTueQJfm1pPKvJJmpvYB2vb+cnvdJx/R5ga82gkenukq3/oUFZPHe6NSU/r/sm0
         Sj0A==
X-Gm-Message-State: AOAM533ISHiXWVGAOvNmilC7Flp/QkRkI1iW1A87JmLwaU2/cv+0xFCy
        IDQdnBhSDwQeXWJgQCy7DywNcvx4A9o=
X-Google-Smtp-Source: ABdhPJxr8NfVUEm9JyyM3G94gXXArt1nxZ3YcotutpPQ3SJJ7bhJF1CBoz4ScKTbjFYkEwDlU1mHgw==
X-Received: by 2002:a05:600c:5117:: with SMTP id o23mr25104816wms.81.1635693971170;
        Sun, 31 Oct 2021 08:26:11 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id z1sm11601683wre.21.2021.10.31.08.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 08:26:10 -0700 (PDT)
Message-ID: <617eb592.1c69fb81.924d5.f704@mx.google.com>
Date:   Sun, 31 Oct 2021 23:26:05 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to f67dd9d11c53
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="da5mz17FSbj1"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--da5mz17FSbj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is mostly a random bug-fixe update, and contains
only one new btrfs test. Currently the new btrfs/250 fails with latest
v5.15-rc7 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

f67dd9d11c53 generic/201: fix the description

New commits:

Darrick J. Wong (1):
      [45d3cae176a5] dmflakey: fix environment-destroying mistakes in _cleanup_flakey

Dave Chinner (1):
      [5c4de305a3a7] fstests: _require_dm_target should not always skip DAX capable devices

Filipe Manana (1):
      [61cad300bd49] btrfs: test direct IO write on NOCOW file when low on unallocated space

Ma Xinjian (1):
      [6ebdbddac7a3] btrfs/091: remove noinode_cache option

Shiyang Ruan (3):
      [8f10101caa4e] generic/138,139,140: fix the name for check file
      [db71335ef63f] generic: fix description or typo in head comment
      [f67dd9d11c53] generic/201: fix the description

Zhu Yifei (1):
      [7ca10f2b05e5] btrfs/012: check size after mounted


Code Diffstat:

 common/dmflakey       | 12 +++++---
 common/rc             | 21 ++++++++++----
 tests/btrfs/012       |  4 +--
 tests/btrfs/091       | 21 +-------------
 tests/btrfs/250       | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/250.out   | 18 ++++++++++++
 tests/generic/138     | 54 ++++++++++++++++++------------------
 tests/generic/138.out |  8 +++---
 tests/generic/139     | 54 ++++++++++++++++++------------------
 tests/generic/139.out |  8 +++---
 tests/generic/140     | 54 ++++++++++++++++++------------------
 tests/generic/140.out |  8 +++---
 tests/generic/155     |  3 +-
 tests/generic/201     |  2 +-
 tests/generic/201.out |  2 +-
 tests/generic/269     |  2 +-
 tests/generic/270     |  4 +--
 17 files changed, 219 insertions(+), 132 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--da5mz17FSbj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmF+tWEACgkQJlKqKVyP
52MDxxAAxtOttp0vuzVILlPeDwMNLJ4DAUvDHd9zJ3OifX23G7WCn30OktLHd4ye
KxwEzeMuofGirDUncB7mG1EPd7jw+BF73YzHFJ/+ETUtHMq8GX2m9jmqcOzwhZJk
UOfoeKdCq5nIJs480wBx/ZTIN6ninP1x5MNkKEiBTZAGOFIhw3k9+5vKYrVJNWsc
S926K429gapBJYpXHCjHzcAKUeXMVX47fGs59Tc9v87MfDDUh2oekqfp3uAnXc4r
REWu7NviORaxifuvkJGU9ep6gd9Ni3F3eTWi67oz+MbGEi/VPiYZaUn7KWYm9a4z
nCQHp921tga5VKwNud8KcAELQ3/KnSyvMKWIZT36BYYUh6XhrP5zUp0WpGedaIbo
mpD6FgmIbJ82ujIau01PzqXMmaBOnj8k9lcT4YTVhL2Ip544TEDO+2lq54F9L9/6
wf6tZKoLbTnwptO3LiyghavA4NKfvA95DvhBcMEF03h0IHrKYBKfIYis4SrgT6m9
XqqbILxu44X9GmQNoPjGHNxz9vr/v0+v/3udxfjIHBQFb7G1PsQnzXRGqTvLRf34
WxSJtmTMag2FxMPBPeeMkGfUWtniZft9VMfub2XiXucr4l5mxcmnZ333Wj3ZUZ+S
i1/AhjasIcCn3+kyW38yr+xGhfsbSNqxR3liLgN99XsMe0hKUM0=
=3J6k
-----END PGP SIGNATURE-----

--da5mz17FSbj1--
