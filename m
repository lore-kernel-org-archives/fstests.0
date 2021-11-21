Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA05C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 21 Nov 2021 15:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbhKUPZ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 21 Nov 2021 10:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbhKUPZ2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 21 Nov 2021 10:25:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC2C061574
        for <fstests@vger.kernel.org>; Sun, 21 Nov 2021 07:22:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so27869167wra.0
        for <fstests@vger.kernel.org>; Sun, 21 Nov 2021 07:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=ccmSKZCtbCkPXXOVzOf7a1VQaDfzuSKpAC84wwDW32w=;
        b=Y2ccp9rQQ/na6q0iSXL8gR8AH33Mb5yuqjMS3LbBAd3xilIh0/YyqFapTrFR2Qx7h9
         tdJP9M/rVWRDtakIBjfueDtbeFVmZVMsQXezRhKj4G9bIh8+q/OpHoOzC89GkZVMybY6
         X97QG0+EoXCZ0tyarngVkhMvmw+DoUKGoRLGVEzm+p/rjAY+pPC6688mL12bif2m8EI9
         eb5t6jIKeYMKnzxrghYVlXLQJEaRT4KuhauACW0q3RhaziY4vw9uTnmEjhrKrdqsGWm6
         FMJemwF6J7a3RIKzZ5BHhFV4Z270vPb1FEI0Xhc6v0JRSPqc2hvYv4n951UKtWxjzEIE
         NEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=ccmSKZCtbCkPXXOVzOf7a1VQaDfzuSKpAC84wwDW32w=;
        b=SmWZ9GrH4X11jWUbkQWsYNPdp+eEgk7KqcAvNG7J7XXf4VuJiKMvhNuqfrfNqsULZy
         X7nMXFj99U7HmoMOtMMKFtVvB/mBvRcoJsJXWhWjGT8rcAfv3UdEYghcrTYbE3ERrtL/
         1V1okZ/foIrJ9BH7jK0s0BJa5CY7A7oi5d9TBSFCJHyNT0zEQrRp22YpShh7iGEuHhrP
         BATj81mSqx3yIZrAoHa3pSuowG3xZNe+up65vaPvD8NBBZCjgmzMYklyqzEDGLPXOnMM
         pTpw1HB7LiLPcoU620anSaIJ/D0PuQrq0KoaqqzUaJ6AvCfjybT87S8qEIeCjLpqHqXi
         ykug==
X-Gm-Message-State: AOAM531aVQ2M5oUqhRXoepeAuz5/N7XUwGQQzvs0eWxiooG9SaZAkxzg
        omKbD1R/+yJ3nP+XiWsFewBAQbxLk8Y=
X-Google-Smtp-Source: ABdhPJzWTUt6wPM5c9IZynT93Qx++xe/PxtnBtAafIVpABWJCJZ+znBNYpaLXJQthgMjAFXUkxo22w==
X-Received: by 2002:adf:e882:: with SMTP id d2mr28998157wrm.389.1637508141996;
        Sun, 21 Nov 2021 07:22:21 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id l5sm6081367wml.20.2021.11.21.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 07:22:21 -0800 (PST)
Message-ID: <619a642d.1c69fb81.52ba9.d045@mx.google.com>
Date:   Sun, 21 Nov 2021 23:22:17 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to d17a88e90956
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j78CYcm4TgKO"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--j78CYcm4TgKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There's one new regression test, which is targeted to
circular mappings in idmapped mount, added in this update. And other fixes are
mainly fixing new failures caused by new version of btrfsprogs, and failures
when using compress option.

The new test currently fails with v5.16-rc1 kernel, and the fix has laneded in
latest Linus tree.

Thanks,
Eryu

The new head of the master branch is commit:

d17a88e90956 generic: test idmapped mount circular mappings

New commits:

Christian Brauner (1):
      [d17a88e90956] generic: test idmapped mount circular mappings

Josef Bacik (2):
      [78c4d738fe36] btrfs: redirect 'btrfs device add' output to seqres.full
      [2d5e3202bb93] fstests: detect btrfs compression and disable certain tests

Kent Overstreet (1):
      [79d84cdcd474] generic/544: fix inode number ordering code

Yang Xu (1):
      [5fea9672e599] ext4/051: Add another kernel commit


Code Diffstat:

 common/btrfs                          |   7 +
 common/rc                             |  11 +
 src/idmapped-mounts/idmapped-mounts.c | 482 ++++++++++++++++++++++++++++++++--
 src/idmapped-mounts/utils.c           |  43 ++-
 tests/btrfs/126                       |   4 +
 tests/btrfs/139                       |   4 +
 tests/btrfs/161                       |   3 +-
 tests/btrfs/162                       |   6 +-
 tests/btrfs/163                       |   3 +-
 tests/btrfs/164                       |   3 +-
 tests/btrfs/175                       |   2 +-
 tests/btrfs/176                       |   6 +-
 tests/btrfs/194                       |   4 +-
 tests/btrfs/197                       |   3 +-
 tests/btrfs/216                       |   2 +-
 tests/btrfs/218                       |   2 +-
 tests/btrfs/225                       |   2 +-
 tests/btrfs/230                       |   4 +
 tests/btrfs/232                       |   4 +
 tests/btrfs/237                       |   4 +
 tests/btrfs/238                       |   2 +-
 tests/ext4/051                        |   1 +
 tests/generic/275                     |   4 +
 tests/generic/427                     |   4 +
 tests/generic/544                     |   8 +-
 tests/generic/656                     |  33 +++
 tests/generic/656.out                 |   2 +
 27 files changed, 609 insertions(+), 44 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--j78CYcm4TgKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmGaY8sACgkQJlKqKVyP
52OcYw/+JDhBGqh9vDqSQxKgzhE/HT4EQUHNgrAq4Qv8396RelLGW8afqbihyNYY
e1QArAHvHLoilrNuhkKL9wgQMEjYbf9pdigmhCMktQwXaakwpE/cm1ubu61eNK0u
Y3lgM3IuzkA2JKV1FRfP4WPau6sfIMtkErtNBEhMobVQ7hBZHYzd9Bpd0Py+S2TY
UpDahAKdPsOdPTAINEs5AQt3iLLYOKDWHmw678Z1mxrUAolXz0Fr7AOCRw6UoK/h
d2dXyz0folY+zOw/VZ5uywKhQBJ+EYbpdfH12GMmHkINE3+2+PyAWJ9L4Logj7kM
EO5ifR8Iej6bjErXgB8zYkFjTHTngP0XVRzXITeVcUG0Yjii0jfzVWWnLjq9QPEw
v5c8oYxrbETclGE04iX8zWFvztHv7j18Hfr01L1JMb5OSFRBkUD1mDzFT0r0QlEB
n53RuQaSdyNde+bNS5QRURtN/+2T8lrFrAGf5tzECXz1+vHogZ5SGyKLYewrVhu4
+BpuvBtnVntFNOhoOCIJhRfZAP24lxs1KeXeTd/DQrwXHbYjjKS6WGbOuuRZevBD
9PTPwjSnQn36bMXlmxJg9VzK4/KEBo1eOTuCz8mUlY/GVqHv5fYyfKH/td1PpDlt
me0lg5ryvTqoMzldtBEtrtfzLSOJPmA31gtWeT5l5NJqrM8L+o4=
=ezf3
-----END PGP SIGNATURE-----

--j78CYcm4TgKO--
