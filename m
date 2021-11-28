Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3414DC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 28 Nov 2021 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358639AbhK1RNz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 28 Nov 2021 12:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbhK1RLy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Nov 2021 12:11:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B481C061746
        for <fstests@vger.kernel.org>; Sun, 28 Nov 2021 09:08:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so31380439wrr.8
        for <fstests@vger.kernel.org>; Sun, 28 Nov 2021 09:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=D3/jeQopQ+u9ivN6V6NA2GGj8me+f9K6z344k85YrKs=;
        b=mW4d8PngaFd5Ft/EDjK+DKU2Q0nlf7UGCFQVc1+1DbOaUYJMs9mGnwENlQE5RlntNz
         wxwEo8WeIzp07MVGoG19Itmx3JmMyubAiJyuXndTfwXTW0WELT0iwzANhDCWiI6M1OGQ
         SpH750OfTrw8ptC2ye3znhL0Wcl+dPAvTBwwsvjKPzDQqir17//27DM4gZSk4xuquIS0
         QiQkcThUGT115yg6vfeFm0Az0oLmK89p0/yRnrQUrW9jw0/YoXcLcG3U9EJBwzlu5uM/
         gOrWUNgxcByPYZH33uMa1mSicTbPquscrjlX/26rYmcwhCGuzF/MbAUMzm1DnvNp6YVt
         HfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=D3/jeQopQ+u9ivN6V6NA2GGj8me+f9K6z344k85YrKs=;
        b=dm8XlhfIfJakyuUo5S03XXXckHFF+LF1pgXa/LLBmuhgk1u3z7UCEZFq7JYgVB0Tbk
         yTidHuzfIWL9QMDb/wq1y731DB3CnvMY6tT0lV2hUFW/BMo43QIJhkpFpnGlPYw6QGVL
         1ajnS4M4FvQjQmhqpHdCTowqGzCCOU5/eibwbRW2ydK5OSwMHPdhasDeSsEAGypVNGXq
         0R/kGnMobjHB4nQlJhM52pZ8rcMVVgQ9zoxIP5xjRvl1AoJRz9TaVyV2IvusfCrZgleL
         jDaRiUD7Ne3rr2ZxhTOikDsELQzMS0JO6/66dXaxgLJtwezjqy0RxcYr6r3QeA3KoTCs
         HUVg==
X-Gm-Message-State: AOAM532Sd6PB0XUSvMj0C6yBPqsRnU+K7nZ3pjURmJV2d03Ye5V5zoKu
        DpQi1z7fWMCXeTbXK0nW+fZo0iEnQ5vbxA==
X-Google-Smtp-Source: ABdhPJyh3oMyUyCcqk/NsBCFCCFNRsnDp7C1N/KmA7KBeKnrG4JDJolXHYj844TN0z5wNHJG5q6NfQ==
X-Received: by 2002:adf:82d3:: with SMTP id 77mr28236843wrc.377.1638119316460;
        Sun, 28 Nov 2021 09:08:36 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id b15sm8110757wri.62.2021.11.28.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:08:35 -0800 (PST)
Message-ID: <61a3b793.1c69fb81.8d2ef.e0be@mx.google.com>
Date:   Mon, 29 Nov 2021 01:08:32 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 2050356437e3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="b9dTGd1bDvVq"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--b9dTGd1bDvVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Again, this is a normal new tests & bug fixes update,
which contains two new btrfs tests and some random bug fixes (mostly for btrfs),
some of the bugs were introduced by last one or two updates.

The new btrfs/049 test currently fails with latest v5.16-rc2 kernel, while
btrfs/251 passes.

Thanks,
Eryu

The new head of the master branch is commit:

2050356437e3 btrfs: add regression test for compress-force mount options

New commits:

Darrick J. Wong (1):
      [f2976706bb84] xfs/122: update for 5.16 typedef removal

Josef Bacik (4):
      [e4746f0dcd1e] btrfs/099: use the qgroupid for qgroup limit
      [6085f8144c24] btrfs/176: redirect _format_swapfile to null
      [efffdefa4a13] btrfs: redirect device replace output to $seqres.full
      [6fc65e386724] generic/274: require no compress

Nikolay Borisov (1):
      [b310fc20be26] btrfs: Test proper interaction between skip_balance and paused balance

Qu Wenruo (1):
      [2050356437e3] btrfs: add regression test for compress-force mount options


Code Diffstat:

 tests/btrfs/049     | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  1 +
 tests/btrfs/099     |  2 +-
 tests/btrfs/176     |  8 +++--
 tests/btrfs/223     |  2 +-
 tests/btrfs/251     | 60 +++++++++++++++++++++++++++++++++++
 tests/btrfs/251.out |  7 +++++
 tests/generic/274   |  4 +++
 tests/xfs/122.out   |  3 ++
 9 files changed, 172 insertions(+), 5 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--b9dTGd1bDvVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmGjt2MACgkQJlKqKVyP
52NxIw/8DARo6iQoJqKaKmxgo4rZm8haFwu4jS8BNWthrEUwPeGuw1W3ycpWTe/q
SvWGnE0s98KyDOT6i0K9UxILcCTW1ci6EN54dpwoPfnzrpelYqoaPxQ/Ga6EddVn
uDBz86a9S97vMapww9eaviqi6pj4piBslRFLBPDjIzfWZYrDLEcehmKL+oyeNL1+
oAyDNjHE2x01vP81FjPlqcR+Ulu6nwc0f63iE398+XHckmwBFF1o99VB96yPtoVt
aBDl6DC6aVqm1tpkXNDgVsgoIJmFxtIFxOIsQA6O851rgcpqBlVmqB/UNbrA4FmU
ranWHtQYsrBoykjrsprKIguB27YfhqXc3wM52eW0GbeRKOQcPNZoMFSUQ/bJeBo4
JhgZh7haMD4TFWG6rFtaNmEAOfFaJn6eNXSr2qu6fChsGWl14cIB7tqD24brHAJa
YWPbgg4nRsKkrdcTz1YRd2R0eGE55Swu4OPA3gE8LuziyRaiUBOsTus4pxXjynJ/
8Jhlk8xXfA46MSMUjC9vdgSgX8JlREBbQHRuRSPrjbyIit6TUSlYEVqnwoa4+CUq
7+kQEzn7+5AsJPVydCKjH1lUnNmaRuB1cva3yuYSmdINM3vacpwRWb7TdVvWFjxk
5zkuktILhQYpr0h0M5iy69nv1zkdFSsnt8acF2ZO6HtlxthJS38=
=Idzc
-----END PGP SIGNATURE-----

--b9dTGd1bDvVq--
