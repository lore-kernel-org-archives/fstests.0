Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B0C433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jan 2021 11:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B785722581
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Jan 2021 11:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbhAJLNx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Jan 2021 06:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJLNw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Jan 2021 06:13:52 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F19C061786
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2021 03:13:12 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 11so9224171pfu.4
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2021 03:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=k1PqSGYxvbvYsrI0kVP/49o/60J9tDX/X+O+ZScsYgQ=;
        b=fjwDoZkZvj08JNkhcGvzPSgx63JjViHTM/EXOqsHLAwccTc8fkYTqVxD8GCVUgM8ur
         2kiyWVenV3xtL4f9lt+YJyC7iWlsPQW8fsktMCc+DlkYRqFsHaMtV85UWZXyZEf5evaN
         vWy1/A7ZpAgd0rJPlBBtzzHzOLQThY7FykGhaavQgJtjHMbe92kbDxFq3jHgi6sdffT4
         umFp2wK+t5+8lI1GjqQYYCILucWRG4azBJ+8rnPBK8b+S16lliYQ91S5L53i/Ak4ZDTK
         ry+XnJK6TS9B+56pn34a/V7NWxH3zKEVPssBBmye5sUgE5mrjxyRL1CUT1oVjSY1DGpr
         gwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=k1PqSGYxvbvYsrI0kVP/49o/60J9tDX/X+O+ZScsYgQ=;
        b=Isg7mPwUslw5en6D1tpg9u86lQi6eYgx19l0XUa9FDQF8CDaKzGKhk9cHV2or07G1g
         T2YyKOYRxZ6giQPeXj2czdalarScVYqI3OPizE2s5niU1Zq7NjM5G7KNp7YWPVt2P1SU
         yW6p26kBgSKvZZRDiiHfpPVDTi8tSE5YNCWQ7f43/wSlmfB3V2/pDcX+egt06V69WT72
         SqI827qrxPHYMbipzRH0yJDbopIPxyi5d7KT9seyvVcn//J4LlEOsVgv7YrI0jGUFeNh
         w45FRyL7mA1XcQLtMFTkDvF0A65TLD9TF2dt97+kG1iFK+8kV877w6rTDuQLYvJtoDWE
         SvdA==
X-Gm-Message-State: AOAM532/1+WmIRmyOOh6Whe333LuoXj26tdTb4hvK87V37BHymdZhcRL
        FtL3fqojV/sYYQav0o9art7plt52OmBAFg==
X-Google-Smtp-Source: ABdhPJyfRXNgAuXBJT7DVB+thmMiiHsiy6msm+pC8OxJeIsYkqfzSDrAl2ljd2xK+J53xvGnDl9gTw==
X-Received: by 2002:a63:d601:: with SMTP id q1mr15041648pgg.417.1610277191408;
        Sun, 10 Jan 2021 03:13:11 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id e21sm15611774pgv.74.2021.01.10.03.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 03:13:10 -0800 (PST)
Message-ID: <5ffae146.1c69fb81.ca05c.2992@mx.google.com>
Date:   Sun, 10 Jan 2021 19:13:04 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 2080ad637bbb
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K7NM6muRSuJO"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--K7NM6muRSuJO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is the first update in 2021, a late Happy New Year
to all! And many thanks to all fstests contributors!

This update fixed the compile error introduced in last update (because of /me
merged only part of a patchset..), and enhanced swap support detection. Also,
generic/388 is updated to cover a new bug, which should have been fixed in
latest v5.11-rc2 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

2080ad637bbb generic/496: ext4 and xfs supports swapon on fallocated file

New commits:

Brian Foster (1):
      [02f7e9feb9f9] generic/388: randomly recover via read-only mounts

Ritesh Harjani (2):
      [725feeff94cc] common/rc: swapon should not fail for given FS in _require_scratch_swapfile()
      [2080ad637bbb] generic/496: ext4 and xfs supports swapon on fallocated file

Xiao Yang (1):
      [c13150fe02fd] src/dmiperf: Remove obsolete dmiperf


Code Diffstat:

 .gitignore          |   1 -
 common/rc           |  20 +++-
 src/Makefile        |   2 +-
 src/dmiperf.c       | 275 ----------------------------------------------------
 tests/generic/388   |  10 +-
 tests/generic/496   |  16 ++-
 tests/generic/group |   2 +-
 7 files changed, 39 insertions(+), 287 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--K7NM6muRSuJO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl/64PAACgkQJlKqKVyP
52Nx8Q/+OUpsTePQAiOb+9fGttUzFdfogOe9hEfC+PBzLQIzAJtRUK3eemOL0sVw
Log5dP+Ur2l6mkeE2iZmD08+CSWdvP6U/IpLCI0zNo0w5A9VJdTfoqABIEaL4hPL
Gb6XfkP6Aa3zk0D2TfLWTT17wWMKpk/8okT5nJ7ypdIK5VGGk3zLhmngpXRhOAsz
Eoowj4dDD9sEjxPfk6dBofwwYBDGeE9/kpCjtIsL6MZIQBlK8gz/RSODrjFWgv0O
fao2XbmFIUdUT/l01TBWB3T4gh39+quJ6qqg0x5SAL/ZaVX+W80JL/DCkV0IitfW
ab4d3Lzr9536RTnigQUERsSUz9EH7qB87peMbtODRKCPgFn+0pgYSYWm87+Zi1Hz
XdCjN6Uj3r1HeLSPXorCKzTNlx5yrRQMJ5r9RwByBjpExgLpEZL1sFXhPuXppksQ
EtcfELwUMDOH8Zy1s5Q/SBhv8qQpD/YFdjI0s6qDmpF0cStksVNKX+iKX7Tpvnf+
knpz1kdiupGJj9dh4iwBF5ZAPetg0AVf5/ZFtYUMKF7XEfe30F3TqKN8yXpCOMzi
5kTJWj8JtzamKqD+2bcNI/xOjNw0Ua4EaxyH1svG7FNy032xy8HoIW15QkMXGChv
nZBbviQhN98I2Mc2rJNj6HPfvEQTAhav0bHrV8TIELidhJJClns=
=7+os
-----END PGP SIGNATURE-----

--K7NM6muRSuJO--
