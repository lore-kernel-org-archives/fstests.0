Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD91C388F2
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362D4206F4
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH4FxDVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgKHKK2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 05:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKHKK2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 05:10:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B1DC0613CF
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 02:10:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q5so2347200pfk.6
        for <fstests@vger.kernel.org>; Sun, 08 Nov 2020 02:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=4MiUKveCgywmPI7YvWjefpzaH38mIZ2g1vLmA7vrF1I=;
        b=MH4FxDVfBgp7BqvvBefOZIptQ0GoOF+HVo47UVQBkQAUeUS6RBbmHJFTmzpXASU65l
         cz3Bj3DMPNvmuBIVbzWlYxGgsoU2W3YyHKSqVvkdpvuxj8vDhW9ltg9CLnjw+VTAFLl8
         pQtXcPeY7tjzTs8Z17huI7mQNHBGrLfZu85/a1EfOFMOkw6jACq2ZXSAC1VJUuw8Gp0A
         xiaknnxjcr38JDZTb9X8Ne6IPUAkO0QVVrA4ucrgg8M+SjhDNJZVcfDjJOqtsGSf4PTZ
         ZtnKFvLdhD/Vo23HmAT4DNAL+Lzjb1ZKanWbZdN56nOhiioyEvW2vTOYx4KM7eh9Wlfl
         hNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=4MiUKveCgywmPI7YvWjefpzaH38mIZ2g1vLmA7vrF1I=;
        b=jeJMiOl6RupiKA/cgUIyZJZ8dcRbTJeNQwS0x8a1ZU0Y3CxOVA1ZwHFvPZN5OuPiUV
         5zfQ6W+sEVTHVaitKgRtKzl/8hC+4+J1XNxiogHJtl2ttvT5Njxvkx3AEcILWnTC5WfV
         pmKMdsVNYirhtpJlYJt2EJuVa4gJPDGd6iQw4P+W7cIV2HZJCxsSmvue6zmUylGvcTXi
         s4JtjlU2MQH/W0FR/PZ/a7jTJLB+SRO8t2TxMZ719Q2NeET6Cqc2Cf9cn/RGv83UuD+k
         9Zdp6sn6Mlbk95TqTSt6emDxMUw0qTyNg66V9qU33p7tWLQ4MXvSOO/yqRkWQ06VcfMy
         VPEg==
X-Gm-Message-State: AOAM530Li0C6PP6l3GhW35zvjosTDIz9j4uGzLEcjarz4p1pRbJKtAj1
        QFQyZIfeSilkdAcnyOVu7IFIRseGOyI=
X-Google-Smtp-Source: ABdhPJw6pxatQHvuQWdBiwUX3BA5WbaZcy1gO77dzHrW+RHTiZXu/dZy0jgATqa6sCe2xW2pQb46lA==
X-Received: by 2002:a63:1f53:: with SMTP id q19mr8906850pgm.286.1604830227087;
        Sun, 08 Nov 2020 02:10:27 -0800 (PST)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id z7sm8069590pjc.41.2020.11.08.02.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 02:10:26 -0800 (PST)
Message-ID: <5fa7c412.1c69fb81.7495b.02d9@mx.google.com>
Date:   Sun, 08 Nov 2020 18:10:23 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 60d9b58605fd
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KuFDgxUTG16Z"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--KuFDgxUTG16Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This update contains various random bug fixes, most of
them are from Darrick J. Wong. The patch from Eric Biggers that adds Makefile
for ceph tests indicates I need to improve my release testing, adding
"make install" test.

Also, there's one new test that checks st_blocks after writing into a hole by
mmap write, and it currently fails with btrfs.

Thanks,
Eryu

The new head of the master branch is commit:

60d9b58605fd xfs/030: hide the btree levels check errors

New commits:

Darrick J. Wong (6):
      [9062902a5981] xfs/520: disable external devices
      [826016f2261e] xfs/341: fix test when rextsize > 1
      [b951bb5cef51] various: replace _get_block_size with _get_file_block_size when needed
      [f3d639b1cc72] xfs/327: fix inode reflink flag checking
      [e97f96e55f2d] xfs/27[26]: force realtime on or off as needed
      [60d9b58605fd] xfs/030: hide the btree levels check errors

Eric Biggers (1):
      [1de2b58b8e29] tests/ceph: add Makefile

Filipe Manana (1):
      [043e5bb164a6] generic: test number of blocks used by a file after mwrite into a hole

Jeff Layton (1):
      [e71ecb8f1c1e] src/append_reader.c: print more info when it reads bad data

Josef Bacik (1):
      [a0bcdb6cbf42] btrfs/220: fix how we tests for mount options


Code Diffstat:

 common/repair         |   1 +
 src/append_reader.c   |   2 +-
 tests/btrfs/220       | 124 +++++++++++++++++++++++++++++++-------------------
 tests/ceph/Makefile   |  18 ++++++++
 tests/generic/614     |  50 ++++++++++++++++++++
 tests/generic/614.out |   2 +
 tests/generic/group   |   1 +
 tests/xfs/030         |   1 +
 tests/xfs/272         |   3 ++
 tests/xfs/276         |   8 +++-
 tests/xfs/327         |  18 +++++++-
 tests/xfs/327.out     |  13 +++---
 tests/xfs/328         |   2 +-
 tests/xfs/341         |   8 ++--
 tests/xfs/520         |   3 ++
 15 files changed, 193 insertions(+), 61 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--KuFDgxUTG16Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl+nw8oACgkQJlKqKVyP
52NVZQ//eaui6LMeyzJRxYCqlwT/68FaEyyTCoQOseCMQzSfdnPReI30k28j0X7M
GAi3ay9HY/hMk9duO8K4ixFLDKDHJr8IDgUjwnoaWL/9ztQIeFBgM/Z5moWzgBKi
/iNHdyfQE2RCM8jchxaCOtpVmco8S5na4o81WDvSbt15lsGHfJ40TE+IKQq3Wqfc
rIA9/pVdd87KCCSIB9wXsYMPgHq5/EET+ZejEub7xhLlhEzG/hEwsIc1KK2JIEX7
X6s0E5ddEuddjr+kW/x+0v98IVz74EGLoy82gxAJKb896wCJ0a3mQ8QUxjwyoaj3
yPEDaGdko0ZnVQiFq+0XWvoe8oP1tiuEUE/P35S5y8OEKyZtx1E4yg40y6hzxdZT
QWPmphDzinRMXVBmCZ3m15PcFw9PKNlPvXmGRfXMGvOMeGJ79RkKGImJcHgf3NRR
GFs2vC1tTPI712wymL/RzeNleGgvsCC1is+PhGp9Z1davpe6LThjT/COrFhMVd3W
OkYlmAZSKpeKGL6GNEx7S3lGxoeqpgigBxIPfO3wGfktuFKRZnUqwAfsCrYjvmSL
bo0w7bI4n3BvEa3U46WkZEG9zv9rZFHuWn2sOvn5D7YbP7zMzuXCswtFn3WIiO5J
Tj510Wk7wsXK+ZoZ6k7eTDlajif5v0kLYYVxPN0wb5wBRa72sWQ=
=ZgeF
-----END PGP SIGNATURE-----

--KuFDgxUTG16Z--
