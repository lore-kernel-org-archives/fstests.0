Return-Path: <SRS0=fsOW=DS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF74C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603AA207F7
	for <linux-fstests@archiver.kernel.org>; Sun, 11 Oct 2020 11:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5FNzmoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgJKLRO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 11 Oct 2020 07:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKLRM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Oct 2020 07:17:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1BCC0613CE
        for <fstests@vger.kernel.org>; Sun, 11 Oct 2020 04:17:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w21so10841800pfc.7
        for <fstests@vger.kernel.org>; Sun, 11 Oct 2020 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=QFpLTVjBPnFKyARp+02Oci1lQfstDVDjHyHnGQ6q1hc=;
        b=L5FNzmoXwwnYAI9Gk94YnQ3gi7/cfOT1X7h7bCzChe1qMMehoWdnOKncJtKgW7g9L6
         xKNjtYnMvazP7cbxnoPfeGDw1+u5iqnRWauqaa1cqZlcAhk8Xy4mHd5J9sTIN8eS7BvD
         vbMpc0m+dpNFkklvTmn1NnneacVeExgGzLqA+H8bbPTkjgjwc9XBg0zaeLjVpDjTlekV
         sqn+zc2pjUJD3TvHyHjlrIqe4LQvFDDq4dXd7Gyj6kRnj07nWbl4t3aMmQkYjZVTrKBU
         U8xi+EgZAiiS0oGU2dxj84stD8l5qoZTxGkD5M+HFOMh+pc+kUm0AHT6wIdLsAnfbELZ
         culw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=QFpLTVjBPnFKyARp+02Oci1lQfstDVDjHyHnGQ6q1hc=;
        b=X1JdyfiRmtgcM95FNbI638p171JlqoEiJKuS6yw4GKACpdaVUFmhY6zQhoy82jJFEz
         h+9hcPhKYA1dTu9me1ZYlprYhkR++X8nptqhfbOChio8u5lDEy/P1z8PmGXUF1S18D27
         eEGeg3KvRbgL7yxJA+HKf+fn6+q0pj3TdKfHjtritN2TbKtAW4YJ9lDH5+bXD7qUKQkQ
         Yq2On5k9Apkutm3qkN1DuVks6SHMMxDbFxecDQeLxm0shhUOnKyO5J1UWXwyPR0+Ensp
         jBKYvhI09RBtdajw9XTZ4G1ez1EnLql9xwuqc4qHbBrGdUiVuEDXPqyPdIg6ebAmrNPr
         HGAQ==
X-Gm-Message-State: AOAM531eBMDhss6Vr+YbxnnCyWq9yXtIs2Y2VbCG79tqPfqIA2lCrkKZ
        ZloE9ZEU3RF1NlOPSw7I0AnkubziRdM=
X-Google-Smtp-Source: ABdhPJwC5DV04tyElIWqYIZwqu+A8o6d7hhCDAoj6nKJkT6ObyCZMqgSBWxusPkTCDSnOgdi+DbVPQ==
X-Received: by 2002:a63:d80e:: with SMTP id b14mr9751061pgh.114.1602415030331;
        Sun, 11 Oct 2020 04:17:10 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id s14sm18947474pjr.39.2020.10.11.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 04:17:09 -0700 (PDT)
Message-ID: <5f82e9b5.1c69fb81.8c00a.3b4e@mx.google.com>
Date:   Sun, 11 Oct 2020 19:17:06 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to ab3df57e8659
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4ToMXE3nmZt7"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--4ToMXE3nmZt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update pulls in the f2fs compression+encryption
test from Eric Biggers. There're also two new tests, one generic test and one
xfs test. Note that the new xfs/521 may crash your kernel when XFS_DEBUG is on.

Thanks,
Eryu

The new head of the master branch is commit:

ab3df57e8659 generic/611: Use _getfattr instead of GETFATTR_PROG

New commits:

Anand Jain (1):
      [65a20890998e] btrfs/064: add a comment to the test case header

Darrick J. Wong (2):
      [5f35d3df8a14] xfs/194: actually check if we got the desired block size before proceeding
      [6df280a68476] xfs: test running growfs on the realtime volume

Eric Biggers (5):
      [fa650493ef9f] fscrypt-crypt-util: clean up parsing --block-size and --inode-number
      [65cd8e8a8e81] fscrypt-crypt-util: fix IV incrementing for --iv-ino-lblk-32
      [300cd3558f43] fscrypt-crypt-util: add --block-number option
      [4057f495d572] common/f2fs: add _require_scratch_f2fs_compression()
      [8b28dae4ac8c] f2fs: verify ciphertext of compressed+encrypted file

Eric Sandeen (1):
      [b3170bfe8da1] generic: test reflinked file corruption after short COW

Vladimir Zapolskiy (1):
      [fce0f68a946f] generic/120: add the test to atime test group

Xiao Yang (2):
      [4616ec0a9df2] overlay/071: Fix undefined OVL_BASE_SCRATCH_DIR
      [72a84addd227] overlay/071: Don't compare inode numbers in lower overlay and nested overlay

Yang Xu (1):
      [ab3df57e8659] generic/611: Use _getfattr instead of GETFATTR_PROG


Code Diffstat:

 common/config            |   1 +
 common/f2fs              |  27 ++++++
 src/fscrypt-crypt-util.c |  98 ++++++++++++++-------
 tests/btrfs/064          |  10 ++-
 tests/f2fs/002           | 217 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/002.out       |  21 +++++
 tests/f2fs/group         |   1 +
 tests/generic/611        |   2 +-
 tests/generic/611.out    |   2 +-
 tests/generic/612        |  85 +++++++++++++++++++
 tests/generic/612.out    |  18 ++++
 tests/generic/group      |   3 +-
 tests/overlay/071        |  12 +--
 tests/xfs/194            |   3 +
 tests/xfs/521            |  82 ++++++++++++++++++
 tests/xfs/521.out        |  10 +++
 tests/xfs/group          |   1 +
 17 files changed, 548 insertions(+), 45 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--4ToMXE3nmZt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+C6JoACgkQJlKqKVyP
52MimA/+Mwwyzx/OQ1gqX/gRbVoYMZEyTpVs480h9iVK4iVqK12pud/7I/EOKos/
GWYW48hRAQ+9fAwk1k8GfRldDvDJuOS1yEROUgGd2RcaAUK5TgZt217SvTQ+Rsaj
ZlNsFAPWbiUBjaQiPbbWZSRreKOWV0dx83xa23DkbhTtLmPTAlCRYLv/dHcg19Tt
UyY7n3I73n6QJd8VtLeoZ57lHFqgu4dhWdlzRj/LXp19abJz5fUyvSsJeOdb4g2u
x25hjRgyNt9iKvS4a6CB95NtyOKKOsPcybLdFHYMAPgbqfchGbEs7Yic8W6uRtPW
f9yerZnLTyubUFz8eu4zfdyMMSa9LJwX7IXcxfSZ7iBwM4dUUzZ2UtUv8MRsRjg9
202m87MapTihXK1JcUsdnes6mmShEAjihXbl1767Zk++hDkwVfTyDqCAYlQR4th1
NC2UZihg29U+vyxY+nORXpwIf7rUVjGpUhrCtnIHwAgS3g8+YEvBizqHQot88reN
IWzCdk1h4VDZb2tMqyjbF6K43xYZfEloNHcWEvTGYAocjNakvZmobQxd1tzU6B1C
6ucUXJn63GnFsEXi8ylByadCyUmxcJgCGIPSnSL812JSzMmGttmQzl5uZN7tewpp
eadJ3w1hPZ480lB7Ph0nimN//u2ri8234uJ3gwP92r+YNlny04w=
=xj4k
-----END PGP SIGNATURE-----

--4ToMXE3nmZt7--
