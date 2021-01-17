Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69C7C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Jan 2021 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A213A2251F
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Jan 2021 15:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbhAQPYT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Jan 2021 10:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbhAQPYP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Jan 2021 10:24:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B64C061573
        for <fstests@vger.kernel.org>; Sun, 17 Jan 2021 07:23:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c12so8676822pfo.10
        for <fstests@vger.kernel.org>; Sun, 17 Jan 2021 07:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=FO7P0/4rmYy403WvBTm1G57ctFsYORvGwXILEMkMlHs=;
        b=HjcQu2SUeyJwQPh36VMHY24U3HY5KQboK8KVeu8S9CnGaX3n5i59e0mvZkV1DYrxzY
         Zvs+sJQRAPtTN+OO7P0+hG94/QYgXyw0e0fGG92tP2HAuBpJa1/duW37wkViMXFEp6Bd
         4hUwC2EqE7mnXdzGG7GKXW9XD+zR9vtrqyyBJVmrLMvSNr9SVLfCk3LOwR+pq7cXmXSt
         FDOjgIjbMXAhNNA6mPfSlsx33hbHScSYuWJLSsh5y6LAue5IRpwkXoVZGkn/u7bxtAKh
         AiIn6vOeA4LihHNzNXYU6IOyhH4LKwfT50PHh4mtJsr2buGCxxF31IyNUDIFk7enW8aT
         ozAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=FO7P0/4rmYy403WvBTm1G57ctFsYORvGwXILEMkMlHs=;
        b=g8tSrLRB9rBYTvVdTXdjjkTytGZFF0bR5O0OYNW4YIqNQUwcbodVbYJvWPPSXZHMr/
         W1PI97qdHgn1Btw3mKyLTeVhgEcFtW+ufBsvQY6dTJKlPM6TJ/3B3d2A8fBrHPxvrIL2
         Wx/WL5vwteAQGzDh7F/II+2FizPOZh+5ommOte+GSFGjGkRPcOGRYIBPtzdhHGIxRCjG
         IxmuEk9mV5/VtzUafeLKRkLdyTP8ntUvhUkJVdPQoGqOQG4QB7vMCCVcG3hZEcda7cbF
         eiS7TBuqO1udmnpQLp2nERkPVWJYBdp2rjd3ecwBybWGrR2Jy/AuNgf27dZvj9H3Ykuf
         +oOA==
X-Gm-Message-State: AOAM530DF8htkY4E7RU4MQEOzlxWt5eIPMY3IcionZsH2rcoiSZ2GnZQ
        WB+sbHtgn8XcKq0R7Par+LN5aENMs5FDVg==
X-Google-Smtp-Source: ABdhPJzBZMw8nLZZRcmHT4u0gaWPGgYiAys5TkMgFREVsDKfvVKuhPetAKG5KWQXYeQRuV4/M9g47Q==
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id l143-20020a6288950000b029019e92ec6886mr22194231pfd.12.1610897012713;
        Sun, 17 Jan 2021 07:23:32 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id y1sm13665271pff.17.2021.01.17.07.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:23:31 -0800 (PST)
Message-ID: <60045673.1c69fb81.4c51.2709@mx.google.com>
Date:   Sun, 17 Jan 2021 23:23:20 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 0e195a4ca997
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6kC4IzYQZjNM"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--6kC4IzYQZjNM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're mainly 3 new btrfs tests added in this update,
and btrfs/229 currently fails with latest v5.11-rc3 kernel, the other two
should pass. Also there's a bug fix to filter "cannot stat" to "cannot statx"
for newer coreutils.

Thanks,
Eryu

The new head of the master branch is commit:

0e195a4ca997 btrfs: check qgroup doesn't crash when beyond limit

New commits:

Filipe Manana (1):
      [c1537fc9f212] btrfs: test incremental send after cloning extents from the same file

Murphy Zhou (1):
      [d6dafbf074d3] common/filter: add _filter_stat

Nikolay Borisov (1):
      [3334128e4f53] btrfs: test correct operation of free objectid related functionality

Qu Wenruo (1):
      [0e195a4ca997] btrfs: check qgroup doesn't crash when beyond limit


Code Diffstat:

 common/filter         |   6 ++
 tests/btrfs/228       |  83 ++++++++++++++++++++++
 tests/btrfs/228.out   |   2 +
 tests/btrfs/229       | 109 +++++++++++++++++++++++++++++
 tests/btrfs/229.out   |  24 +++++++
 tests/btrfs/230       |  59 ++++++++++++++++
 tests/btrfs/230.out   |   2 +
 tests/btrfs/group     |   3 +
 tests/generic/397     |   6 +-
 tests/generic/397.out |   6 +-
 tests/generic/435     |   2 +-
 tests/generic/435.out |   2 +-
 tests/generic/440     |   2 +-
 tests/generic/440.out |   2 +-
 tests/xfs/348         |   2 +-
 tests/xfs/348.out     | 188 +++++++++++++++++++++++++-------------------------
 16 files changed, 393 insertions(+), 105 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--6kC4IzYQZjNM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmAEVfoACgkQJlKqKVyP
52ML0xAAqoZSLC6IHP0RCc+vfWQadY/dzne4RrbK6afKiIylka87J54STQ0EaVrr
S715CUg7ZqB0PMnJmyvBS++q2JWsnsytUJmJeXg6Mp/p7niCA0uevauhoBoI4xmA
SlYsz7xtn3f92mKLH1Oylpgh+jCn14wXbvw31Y9jZnqJG3S0PhAEx6iDUtqCHS33
qJ5Y4rfS2IhBeA1k1fV9UZFrDZFw+b+EJp6PzvpB4XE03SXhC1cpyyqinDzTrwit
kd88xpnP4fyqanFQk2Gflz/JnL5DOXApLcwidtby401hq8X6F3lynhahdVLlaJgf
cS3bfbKKB3pYEMhOSbngWHg5uDXApLFexkp9PG5dJMBuxlVsNcVkIiiJvDsdiiYp
dLqjU53+BcdXj0NTpsmTL+02JiVOaPZ7ZBTjJ6QRIkE5Hn8yY2a3RLjbpDOu5nqx
eWWOZdJtdsd416vcSmdrrlxY0HlNFjshh427NYhBvMcMSWlDHKPT5OtG0D6SH7iG
5QGW+CPDQw+EzZ0z/a1dYq01M5U/ZiQBMDXH9e2EnNd1w/dobAdxRHXODlIpqZvP
WTil0e4vkO9nNMYOTNaZegoDJU9UAERfEJNyKZtx5cmep6VD4zgnsIB1CM71GzcH
ghQRtLi2jNhVfSBWw5SjYrlfR2GjNhaYwmWwpMknj8FtpqDmIEc=
=KtKQ
-----END PGP SIGNATURE-----

--6kC4IzYQZjNM--
