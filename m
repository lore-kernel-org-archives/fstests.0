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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DAC433DB
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Jan 2021 15:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A0B230FB
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Jan 2021 15:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhAXPYA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Jan 2021 10:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbhAXPX6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Jan 2021 10:23:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F80C061573
        for <fstests@vger.kernel.org>; Sun, 24 Jan 2021 07:23:17 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id a20so3807187pjs.1
        for <fstests@vger.kernel.org>; Sun, 24 Jan 2021 07:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=3ebmfNfwg3pcP8A7CovDgAdWyrBDpy58dNTnqJ8fZ8U=;
        b=Km9xP+xUeENkdq5e/zyUxLAC9Fe4KqfDxsF57yM/gwnrDoN/bqZmJ5CppZNqbqldR9
         FfSxlPOU1TPPaEVVVSBKBExe0tRK9Je7s0q6zFI290RvfM0jiS1n3s4SlshhwBuQjJxR
         ljcQbJiPQnHmIscYode1Tf8e7F7UM0jzMVw2jv42eR3cqmxPFyIwBRTxZKcc7NOisE/2
         JToEY4Q8YEl7tQmdsAnwq4ESzMBhm+dc4H3fiiUpRvDlpmTaHpWhujAKy6YtMpjRoiI9
         fk1RdMEKJXKY/qA+8QhJCDpVlVbMETpdXD6o8/E9+R64l8C3Qjo0TI5rxHmiO8l3iP05
         QFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=3ebmfNfwg3pcP8A7CovDgAdWyrBDpy58dNTnqJ8fZ8U=;
        b=LDs7EKFAW1AnefsYwvk17N+8DjMeA65zi6DxenEH43uW1xHEbmNj2aeH9fsknn8UfS
         W4NqbqrSmykJf4wnC4FV+UzjAqlTZ7JTYM8GIIrRFtLslD9PRzVRxdZ5fm7HuMZK5Ctt
         4huZWgKTWhr/fjEpETPy+1j7ZetdxIjY6cWss55lnpayKyRg38XOy7RRYF4bvcGv+QGQ
         Owj//N721cguKIfK1dRyXb/O6OJLJ8EH+dCHtUUHxo+MBk1YR++LA7y1ao032o8F9MlW
         AUScjbUpGgG/LmGivKsDwcbJtAfDBfpCBkqhBLvcwJ6/7ItLmskGbdysm+QnttPiNXdI
         mUlw==
X-Gm-Message-State: AOAM533mQb5n7scgBcz8VBgSq82bvO+0X3h/FXfRlu69LfttvFL0a2IL
        Z3dwBQxJv3eJNSRv99mSlFnpmxKv8R0=
X-Google-Smtp-Source: ABdhPJxWjakwBgkGR7b9KCEeYoLGgpcg1x7WOKhTHy7XwKpW1BNzBaqzF3zRkI3Is/Me/1P7r5BF3Q==
X-Received: by 2002:a17:90a:7e88:: with SMTP id j8mr4674892pjl.217.1611501797061;
        Sun, 24 Jan 2021 07:23:17 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id p64sm13865150pfb.201.2021.01.24.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 07:23:16 -0800 (PST)
Message-ID: <600d90e4.1c69fb81.3e04.13ca@mx.google.com>
Date:   Sun, 24 Jan 2021 23:23:11 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 44a1fbf786a8
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ayfPBDf0PT1O"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--ayfPBDf0PT1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update mainly pulls in the mkfs.xfs config file
tests, and they all should pass with latest xfsprogs. There's another new
regression test for persisting [acm]time when lazytime is enabled, and it
currently fails with latest v5.11-rc4 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

44a1fbf786a8 generic: test for lazytime timestamp updates

New commits:

Darrick J. Wong (1):
      [3ba859629de1] xfs: test mkfs.xfs config files

Eric Biggers (1):
      [44a1fbf786a8] generic: test for lazytime timestamp updates

Yang Xu (1):
      [e2072f840804] ext4/046: skip test when ext4 doesn't support bs < ps with dioread_nolock


Code Diffstat:

 common/xfs            |  10 +++
 tests/ext4/046        |  11 ++-
 tests/generic/622     | 239 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/622.out |  37 ++++++++
 tests/generic/group   |   1 +
 tests/xfs/522         | 219 +++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/522.out     |  16 ++++
 tests/xfs/523         | 195 ++++++++++++++++++++++++++++++++++++++++
 tests/xfs/523.out     |  13 +++
 tests/xfs/524         |  65 ++++++++++++++
 tests/xfs/524.out     |   2 +
 tests/xfs/525         |  62 +++++++++++++
 tests/xfs/525.out     |   2 +
 tests/xfs/526         |  64 ++++++++++++++
 tests/xfs/526.out     |   3 +
 tests/xfs/group       |   5 ++
 16 files changed, 943 insertions(+), 1 deletion(-)
--
Eryu Guan
guaneryu@gmail.com

--ayfPBDf0PT1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmANkIUACgkQJlKqKVyP
52P38BAA3cBUFV4hV3e9113R3clgKiXZtamKG+ZBuMLPZKU8rcjCCiQ6ca3uIb2x
4rQUDh7M5XGIOSRjIXsHmEaSajPh7wNT24MfxJ+7Rr9N6AMJHLu2pL1WXwo1w2Up
OuEI8I60HcDhEbnBgHuBXpyIgvvb0fsin/VgkFIXwmkyP9PG4v9vpnGW3lvdZa0R
DxgoVtE0AWcsUe3ubXLEblSz52ZmH/P8IM00JVnjZRzJd9I3BlIqxLJaVoJVUAVc
Cb4dXEAhsY3cUm8qeRDcRh6UTq5l3YECH5ParLk7TA6Tp/MtF1LII6hlJS5EAdmM
/pL+E2K5nBYAWDzR9Y/DU3ACzlm8z+AYq2ifdlcxITfRKa/1dz+G9MYfT4q00B0U
ds+GmwdzBPZJ6HfIIx3WueYrT92e3oo0Sh5XIRACuTXKtwH9oGE/CQsQvIsN/MWx
TT3p+we4ENEKv7MeCacNAerv9iuY01FV/BU+BldyNcwl20Hfb2S46a5tNYwvQ076
hyW9a9t0Ua9ioMXgODqEzfwB0EnJWcVTRLuU7j2FmT/eUeAdvlBmy+k0uA0Mk2fr
pF3jxWAkxFF/4rTs80/lj+5b1syno/evHbloQYTIXo6I0ghyDWta31nps6NkpSlX
ak7inQQveQpzAq3CpVfAVnuyn/DNSA6CJidP3a4pygavTN3jC80=
=Z+ci
-----END PGP SIGNATURE-----

--ayfPBDf0PT1O--
