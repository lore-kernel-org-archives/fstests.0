Return-Path: <SRS0=tq7v=7G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DAC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 24 May 2020 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DB820787
	for <linux-fstests@archiver.kernel.org>; Sun, 24 May 2020 17:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsXdZEdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgEXRGG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 May 2020 13:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgEXRGG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 May 2020 13:06:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117CEC061A0E
        for <fstests@vger.kernel.org>; Sun, 24 May 2020 10:06:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n18so7859805pfa.2
        for <fstests@vger.kernel.org>; Sun, 24 May 2020 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=UFAiWqzXXhr0HN2CmbUbEwSwlH5SxOfvNQeHhIeIVj0=;
        b=KsXdZEdf4Ir+c3Aw6ohH9a/i5v4DkhZ5m5YR4Bc5O5tXnkFR+K/KP8Zngnua5YthD4
         kJKCDfKxvLM4SJFakkaHesBhLgoLemJO1UKG5035ABL1wa89QZtKGfNezuhUuM/3WHg8
         puEcRnyZwoQJrCSv1TgzkEAG5s7vtbQ01MFGNEFS2fn8Ieo8+Vj/YmlnNI73pjNat8vd
         ZNBhh7Lm4KYs7UVH8z69xLFbB7VoVD5fAMXAz6RVDVgX4ADLd0MhREkorRg1mPG7eEwo
         KYlsI3S+SilfHpsDV5JCXndDUb/08d0kce+munp3Aft9a2rSBodCnGZd5c3HvM8vAmxl
         14dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=UFAiWqzXXhr0HN2CmbUbEwSwlH5SxOfvNQeHhIeIVj0=;
        b=T7kdmglh2cLtFmvyfRy3NBCaxSphevDSeJF2phdoRRukkSg5sFsFNFt3Zyl/S3Dqhf
         Qgd+JxhO/O/ltYOlK3xYvqVs0rkOMTLuDQNveIbtYxPRT6brd9LZ/AQYLyT9+XFEqQoz
         wZzkmlgjNyNYy93tvk9SVYENis46pvhtr8zK7cafySMT81Entw0tlFo7s3elD0p+VJNl
         YUqqvikkHAXXfJCaeD3+P8rfhYAXf0Q0Jx3UpCcWJSHM1qUaZ90jzfcPolZkYUc765KJ
         G0Rg6SCbwdKYwySqs6wf3EsM9c3UFIfKIX+phPli4kjnAP5m3WCewtyMnRIvvctMMmba
         ijFw==
X-Gm-Message-State: AOAM531jzmShqGppEC1QSwKW51bm1mxFvgIM/UaPNYiiraUKbJ+PabGi
        aDmQWNkS/uzAS/Uxcnwf5ANgZ5Gz
X-Google-Smtp-Source: ABdhPJxvYt2vmkag7hKU4TW7rVcwPrpj63wriQW2Z7Z5gKiZMm6ceu9sPniAwfwdI5yHVpFy1391xg==
X-Received: by 2002:a63:a062:: with SMTP id u34mr23484480pgn.62.1590339965147;
        Sun, 24 May 2020 10:06:05 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q15sm11119676pfh.188.2020.05.24.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 10:06:04 -0700 (PDT)
Message-ID: <5ecaa97c.1c69fb81.2e77c.a238@mx.google.com>
Date:   Mon, 25 May 2020 01:05:57 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 1cb1f7eccf98
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B2KcHSvUIKVR"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--B2KcHSvUIKVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 8 new tests added in this update, including 2
generic tests, 2 btrfs tests and 4 xfs tests, and all of them should pass with
v5.7-rc6 kernel. The other commits are random bug fixes, as usual.

Many thanks to those who helped review patches!

Thanks,
Eryu

The new head of the master branch is commit:

1cb1f7eccf98 overlay/031: fix failure with whiteout inode sharing

New commits:

Amir Goldstein (1):
      [1cb1f7eccf98] overlay/031: fix failure with whiteout inode sharing

Darrick J. Wong (4):
      [06fd8dbbfe31] xfs: test that reflink forces the log if mounted with wsync
      [88e954ae9b69] xfs: race freeze and fsmap for a while to see if we livelock
      [5e76656346b0] xfs: make sure our default quota warning limits and grace periods survive quotacheck
      [5053ed2ff0a6] xfs: test sunit/swidth updates

Eric Sandeen (5):
      [d4c5b1cabd53] fstests: add _require_sysctl_variable helper
      [fad7fc57f7d2] fstests: test restricted symlinks & hardlinks sysctls
      [6c5ab7590174] fstests: test restricted file access sysctls
      [04f13c4ee3e2] fstests: add _require_mknod
      [e63337b1eda1] fstests: check for unknown flag result in _require_xfs_io_command

Eryu Guan (1):
      [2efe93a3be1f] fstests: renumber tests after merge

Qu Wenruo (2):
      [a297366f5621] btrfs: Add a test for leaking root crash at unmount time
      [b77be1c0ca38] btrfs: Add a test for dead looping balance after balance cancel


Code Diffstat:

 common/rc             |  15 +++++
 tests/btrfs/212       |  85 +++++++++++++++++++++++
 tests/btrfs/212.out   |   2 +
 tests/btrfs/213       |  66 ++++++++++++++++++
 tests/btrfs/213.out   |   2 +
 tests/btrfs/group     |   2 +
 tests/generic/062     |   1 +
 tests/generic/184     |   1 +
 tests/generic/306     |   1 +
 tests/generic/401     |   1 +
 tests/generic/434     |   1 +
 tests/generic/479     |   1 +
 tests/generic/564     |   3 +
 tests/generic/597     | 117 ++++++++++++++++++++++++++++++++
 tests/generic/597.out |  14 ++++
 tests/generic/598     | 128 +++++++++++++++++++++++++++++++++++
 tests/generic/598.out |  28 ++++++++
 tests/generic/group   |   2 +
 tests/overlay/031     |   1 -
 tests/xfs/516         | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/516.out     |   9 +++
 tests/xfs/517         | 108 ++++++++++++++++++++++++++++++
 tests/xfs/517.out     |   4 ++
 tests/xfs/518         |  69 +++++++++++++++++++
 tests/xfs/518.out     |  13 ++++
 tests/xfs/519         |  65 ++++++++++++++++++
 tests/xfs/519.out     |   7 ++
 tests/xfs/group       |   4 ++
 28 files changed, 931 insertions(+), 1 deletion(-)
--
Eryu Guan
guaneryu@gmail.com

--B2KcHSvUIKVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl7KqRMACgkQJlKqKVyP
52OPyA//YkA50hNZsmzycTxUK/oV5egvsNJoucxnS26IMv6s1EacsWvsORcKjxTT
JA/s0ChbNOM6d+Kp12EBIrVBVxSm7hauoUdR0JpjtlkriE7Ro1XKb2RYV6fMtdSP
ur+EO8zgsD4boSshZTJWDiffvXjeLiRmO15KrZ5laHUvoPFR/8P0Kq1en97mtJNk
aReF6twB5lw2RzTEzzcQYjsQ3Ws/5Ox50UumMKXH+aB1wHaBq3MuiLMVXi/5YduU
zd7PchGtPBVuBRa73JGDUK35Kqx7bwEnyN7bUTQ/05xjRZYQvhmCeD8pmvhRJUfC
xBRZv9ldjgjJgS8N5Ap3fGM/qVjgCHonb/dcMnIzwFUGn/etMjH3KnsrBhJ/scFb
FHg6zOM5Loho8X/5urse9THavbIu/BEkF+uEuFvX0bkisI15VYXx8G8Ij3UbgO2c
zwhVqxWEHRq+rVT+04vEYuHvjb7IDS7qwOcrwyIKEkOJ/OiA8ZSh7jJPenbMjfXn
5R7g/9FFT9KNtf3dbDl8lKaCccVrAm6gixdpzWdpsFrBKuZjK1D7j4RFf18Cxiep
RkmaNEQcy5+dTDND5jq6IFghMDE0qn6wLY4iccU4fqpS0UTgvh1yblKVOf6aYeok
O/AM5lzbcDwkaYfj4OzWu14vndcE86E1cbGdBFQv9JXjrL0eezw=
=Oidn
-----END PGP SIGNATURE-----

--B2KcHSvUIKVR--
