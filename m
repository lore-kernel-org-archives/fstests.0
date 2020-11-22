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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB5C64E7B
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A722084C
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Nov 2020 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVrBHiyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgKVPj2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Nov 2020 10:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgKVPj2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Nov 2020 10:39:28 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05EBC0613CF
        for <fstests@vger.kernel.org>; Sun, 22 Nov 2020 07:39:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b63so12498042pfg.12
        for <fstests@vger.kernel.org>; Sun, 22 Nov 2020 07:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=MpplByWthoD2RvlmNMLjT6nt5lF116Gfe2dmU91Xlfc=;
        b=qVrBHiyBoMozFn9AmFx1wjysoKuHd7HYPJjRt9BupGpcclDGpQ6ZSGXGLzVzzbPRxq
         oAsnn6jpoiJ5msXlpxz6ajnBtpdovhIWQc2NDzVXfKgk976VBi0uc3HdRJqoCD6dX04s
         IzYW9hGEcDltj3X6+QTDssgJ0jBBOHvWtGwILgt8sxSMB9A/17mVjr7jzlgEOyaofjyc
         AgPDKz/2w2hNR4yoUuiZ6SkbklA5h3KErMOkQ+6Ib5WvO/5pv6+1cUV72m8dGlGlSwud
         +9GYyruJGCQVzICXBnN53mALIbSzrlt6GxGMHoFUIPWwP8q1Jps6Wq9zCso5vss74vMh
         lWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=MpplByWthoD2RvlmNMLjT6nt5lF116Gfe2dmU91Xlfc=;
        b=M1+XHY0kI5/QpGroN/+0klHlVTzjzJ9iKJDCVqtktwYwVL7+aSVoGW6Mr37T58C0KT
         fCl1BdTVn/HekaiX3VlhKArMRJRUWLTvwns/SM+GY5bulrE/X/A+6kCm50AfVhiYk4JV
         ssHhODs4g1xeCtQv3DqqFoUXawfpHrItC8slnNctm1zS/kMZQd9E2XSSmhvhBMFw4oEo
         hunQ199mM/5f4Z3RIJPfGjagJB++grWQsFZP4VxhpCBrXqEE/RrM2oYdxi7FID3OoPqm
         1NRuB85Dx5qUBerG4Gqw9jOuzco6dlNl8UHgg5/e7bdf5i+GG6MChdRG6kkC2xsy3P9j
         f+3A==
X-Gm-Message-State: AOAM532pbB1yafxO/XwySZz+U22hcWsyFpBAcJwKTEbIV260Oe9i+wFg
        XrPKeXWEnS2/gkh9k8Y5TJiuc/xLCgA=
X-Google-Smtp-Source: ABdhPJzSpqHMFKgCC4EPAaCBFyeFUSjIEGoflKsDxiLXAIrlIpv4qrPqI4lUeGgve9PLxsoPN4oNeQ==
X-Received: by 2002:a17:90a:de0c:: with SMTP id m12mr20598843pjv.224.1606059565929;
        Sun, 22 Nov 2020 07:39:25 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id ge21sm10730430pjb.5.2020.11.22.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 07:39:24 -0800 (PST)
Message-ID: <5fba862c.1c69fb81.fa930.68ec@mx.google.com>
Date:   Sun, 22 Nov 2020 23:39:19 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 37d4f926b525
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f7bcaE7Uz1vz"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--f7bcaE7Uz1vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the random fixes from Darrick J.
Wong. One notable change is that test is now run under systemd scope for
mandatory test cleanup, if your host has systemd enabled. Please see the commit
log for details.

Thanks,
Eryu

The new head of the master branch is commit:

37d4f926b525 xfs/033: use _scratch_xfs_db wrapper

New commits:

Darrick J. Wong (6):
      [f02ccfb24b9e] common: extract rt extent size for _get_file_block_size
      [c0be121e126f] check: run tests in a systemd scope for mandatory test cleanup
      [85bf3af7c205] common/populate: make sure _scratch_xfs_populate puts its files on the data device
      [f220ab921e1d] misc: fix $MKFS_PROG.$FSTYP usage treewide
      [0d444a9a29e3] misc: fix _get_file_block_size usage
      [37d4f926b525] xfs/033: use _scratch_xfs_db wrapper


Code Diffstat:

 check             | 26 +++++++++++++++++++++++++-
 common/populate   | 11 +++++++++++
 common/rc         | 29 ++++++++++++++++++-----------
 common/xfs        | 20 ++++++++++++++++++++
 tests/ext4/032    |  2 +-
 tests/generic/157 |  2 +-
 tests/generic/175 |  2 +-
 tests/shared/032  |  2 +-
 tests/xfs/033     |  2 +-
 tests/xfs/129     |  2 +-
 tests/xfs/169     |  2 +-
 tests/xfs/208     |  2 +-
 tests/xfs/336     |  2 +-
 tests/xfs/344     |  2 +-
 tests/xfs/345     |  2 +-
 15 files changed, 85 insertions(+), 23 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--f7bcaE7Uz1vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+6hc8ACgkQJlKqKVyP
52Ppnw/9FofcdOECfJpHW62o54rGvHUoU9iOWmHNETwrVEQNN6gO2A0iWq2bOSt4
EIFgCcp0KE+2bY6nDq+1h1SpBAPE5Ud1fAuIagMawlcmhhKYw0yAp/nhl7tyPqfR
U7+6r7LGXWuWNrdQt68E//IEn+Qba1sELZfS6k6Nr560TRjALGOlfBgJalJqwm2n
avpef3N4RzWK4z1uh/QkpNmJvlSqbk1Y7weFVDxdAhlSblSdYL+n3rfFvUaXCWps
1fHU7mCAXDSZEbOyYchSLBsaw7wIzxYhECxhOkJFa6wEKGLqDbu82xgxQDy06Y89
qa39CGaOWwKfytiF/FCgKl5El4aZEb4jKTkoFyR2AY1kzMrgXuShRXFUSPbp2O7u
f8DNGU7yxLoAFZbuVlGBMTVKKn4+wF7cjP/RaIrDHMGxW+8XoO3DGnEkuyX2VaKg
lEfdVm6Dy3CaPnnmHkPiJtUtEZM2hCjAQ2qQVgRjIeQM7gjlkcFYFRCVKKeG4lQC
DRUJoWfwq0xOpBLUxxBPBhSnlBxh/iXyhat1+nmORz3FDMn5dhx+PRP15AvJc3Yu
F1brg4NqNJhYE0snBBh7con0fjMEC0MEj4ds4oEyZz9hH6dW7qBtouY/ZBmkPSXA
GuGyVj8V0Ysa8zPCP3OsQYR16G07Fn6pP6RXkyudeuvXWwVu4U8=
=U5nx
-----END PGP SIGNATURE-----

--f7bcaE7Uz1vz--
