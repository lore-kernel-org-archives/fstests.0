Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C201DC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Apr 2022 16:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiDJQle (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Apr 2022 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiDJQld (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2022 12:41:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99B4B1DF
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 09:39:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so19644382wrg.12
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=Artn74FbI9pmoi2YIsV9jsBTJ3IqbMIcv5tJpwVQdr8=;
        b=WQAIkt70jzA/qGEU5LL50AuHPAnwaKgVScANSqVLcglgYYrQ6aMCgCKFWJB/1oTww8
         pvKSN/nIIoIdtEFh29hs98NfvrclaszUTkcz+fCLmTcgPmMv/gakREh0Uy4aV7c45Kvn
         BBQVofbFz9ADernXhwTd+FOl5Iz3gvyJ/+ev7rjvEsgh5a3GfF37e4rkobWV+tOdjGUB
         O6vucoOFOoK9PjIqClV1pBnTyW4RvDSlsRqJrWxAcuwLyR3q8B10GcheEudy8bKermN7
         UeXhzSDKGjovpsu0Ng0K8oBgjLDzsOVUP11T8GOnpzwLyiWNrwJ++R9Ze3VcBh6PEYcg
         vegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=Artn74FbI9pmoi2YIsV9jsBTJ3IqbMIcv5tJpwVQdr8=;
        b=38cmx9dxq2rzjEVgsb8Hdnmq/hgC2/F5fC4Rub4ENJFvVihm5MhZ14+mI4U8b7x3Fp
         EQFwPll8mZO24v5R1ojyNTLrS2svnU/43Zi/uSruzGAskqc6OB1M9SeNdAg+GqWtnQnE
         N0zwnk7OHs54AN8Y4KhCKOGD40iJg0LqhpLuvrBr7ePb1mi55KYizB1olbTZA2xGY3NF
         l6WZ4H/bKOwt6ClZYxSETFyyfNblttr3EtXPDou5oJvyN0IrzFT8xmyAkUDr+4r4ZNxW
         rByi3umJeZ/0PXIXg1UKP9daNpjeUmJ+Yx9PujyzxUhMQzXSXHcJUqgOFxBHsa8XmDE3
         M8aQ==
X-Gm-Message-State: AOAM533blfMJoRro5AjGtaSs00v7cXyNyaYRTsFt6lbTDiDKyebwgFY7
        aS93Zihg3pKrLRlwG9iGu6d2KFJjKkKoUQ==
X-Google-Smtp-Source: ABdhPJzo8XmxzP1cXKYBkw5tv6WFXZbJIIWoLp6iVvleZvRjcRYuBUUbpfby8e4nczbn75nDKGsbhA==
X-Received: by 2002:a05:6000:1547:b0:206:1b04:3152 with SMTP id 7-20020a056000154700b002061b043152mr21690537wry.367.1649608759713;
        Sun, 10 Apr 2022 09:39:19 -0700 (PDT)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm17901012wmp.13.2022.04.10.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:39:17 -0700 (PDT)
Message-ID: <62530835.1c69fb81.71917.dac0@mx.google.com>
Date:   Mon, 11 Apr 2022 00:39:14 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 4a7b35d7a76c
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8PrebMg8Cd0"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--a8PrebMg8Cd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It's a huge update as there're many patches accumulated
during the last a few weeks. And I think I've picked up all pathces that have
been reviewed. If your patches got no review comments nor picked up in this
update, please re-send, I may have missed them.

And regarding to the maintainership, Zorro is going to take over the
responsibility, and we'll discuss to see what's the best way to do the
transfer.

Thanks,
Eryu

The new head of the master branch is commit:

4a7b35d7a76c common: allow to run all tests on idmapped mounts

New commits:

Andrey Albershteyn (1):
      [6c2830764021] README: restructure & format building manual

Boyang Xue (1):
      [7c9de12773d9] generic/674: replace _require_scratch_reflink with _require_scratch_dedupe

Catherine Hoang (1):
      [7834a74058c2] xfs/019: extend protofile test

Christian Brauner (1):
      [4a7b35d7a76c] common: allow to run all tests on idmapped mounts

Dai Shili (1):
      [b5660918c982] generic/631: use trusted.* extended attributes to filter NFS filesystem

Darrick J. Wong (6):
      [e1b93b712f29] generic/459: ensure that the lvm devices have been created
      [58331382174e] common/xfs: fix broken code in _check_xfs_filesystem
      [bc593bd327e0] xfs/420: fix occasional test failures due to pagecache readahead
      [b3a59bb6dc16] generic/673: fix golden output to reflect vfs setgid behavior
      [4a21f002880a] xfs/076: only create files on the data device
      [407ef6b96cc8] xfs/17[013]: fix intermittent failures when filesystem metadata gets large

David Disseldorp (1):
      [424acebff4fa] btrfs: drop no-op count=$(( count-- ))

Eric Biggers (5):
      [cd81e731261d] fscrypt-crypt-util: use an explicit --direct-key option
      [02222a33a0e5] fscrypt-crypt-util: refactor get_key_and_iv()
      [28eae4d04d1e] fscrypt-crypt-util: add support for dumping key identifier
      [775e2763a392] common/encrypt: log full ciphertext verification params
      [1e516c860030] common/encrypt: verify the key identifiers

Filipe Manana (2):
      [cce62cbb35cd] generic: read multiple extents with io_uring
      [52fe88c9f545] generic: fallocate against a file range with a mix of holes and extents

Josef Bacik (3):
      [e030808c1774] generic/373: change test to validate cross-vfsmount reflink
      [9e8dac56ff30] generic/374: validate cross-vfsmount dedupe
      [866948e00073] btrfs/029: change the cross vfsmount reflink test

Luís Henriques (1):
      [09efb6c78d0f] common/encrypt: allow the use of 'fscrypt:' as key prefix

Masayoshi Mizuma (1):
      [4837b6aff4d3] xfs: test xfsdump with bind-mounted filesystem

Nitesh Shetty (1):
      [513338e6a743] generic/108: use blockdev utility to calculate physical and logical block size

Ojaswin Mujoo (2):
      [50490c851139] src/ext4_resize.c: Refactor code and ensure accurate errno is returned
      [034e1a796f4b] ext4: Test to ensure resize with sparse_super2 is handled correctly

Pankaj Raghav (1):
      [9577dac5d24f] btrfs/237: Use zone cap instead of zone size in fill_size and rest calculation

Qu Wenruo (2):
      [1133ecda69f9] common/btrfs: don't skip the test if BTRFS_PROFILE_CONFIGS contains unsupported profile
      [a7e2b797f865] btrfs/194: allow it to be run on systems with page size larger than 4K

Sun Ke (1):
      [d019cd411869] generic/066: attr1 is still there after log replay on f2fs

Zorro Lang (1):
      [24cf6fa01370] fsx: remove XFS_IOC_ALLOCSP operation entirely


Code Diffstat:

 .gitignore               |   1 +
 README                   | 376 ++++++++++++++++++++++++++++++-----------------
 README.overlay           |   6 +-
 common/btrfs             |   8 +-
 common/config            |   1 +
 common/encrypt           |  70 ++++++---
 common/filestreams       |   2 +-
 common/filter            |  13 ++
 common/overlay           |   2 +
 common/rc                |  50 +++++++
 common/xfs               |   6 +-
 ltp/fsx.c                | 111 +-------------
 src/Makefile             |   1 +
 src/ext4_resize.c        |  46 ++++--
 src/fscrypt-crypt-util.c | 193 ++++++++++++++++--------
 src/uring_read_fault.c   | 150 +++++++++++++++++++
 tests/btrfs/029          |  60 ++++----
 tests/btrfs/029.out      |   3 +-
 tests/btrfs/124          |   1 -
 tests/btrfs/125          |   1 -
 tests/btrfs/194          |   6 +-
 tests/btrfs/237          |  21 ++-
 tests/ext4/056           | 100 +++++++++++++
 tests/ext4/056.out       |   2 +
 tests/generic/066        |   8 +
 tests/generic/108        |   4 +-
 tests/generic/373        |   8 +-
 tests/generic/373.out    |   2 +-
 tests/generic/374        |   5 +-
 tests/generic/374.out    |   3 +-
 tests/generic/459        |   1 +
 tests/generic/631        |   2 +-
 tests/generic/673.out    |   4 +-
 tests/generic/674        |   2 +-
 tests/generic/678        |  40 +++++
 tests/generic/678.out    |   2 +
 tests/generic/679        |  63 ++++++++
 tests/generic/679.out    |  20 +++
 tests/xfs/019            |   6 +
 tests/xfs/019.out        |  12 +-
 tests/xfs/076            |  13 +-
 tests/xfs/170            |  16 +-
 tests/xfs/170.out        |   8 +-
 tests/xfs/171            |  16 +-
 tests/xfs/171.out        |   8 +-
 tests/xfs/173            |  16 +-
 tests/xfs/173.out        |   8 +-
 tests/xfs/420            |  33 +++--
 tests/xfs/544            |  47 ++++++
 tests/xfs/544.out        |   2 +
 50 files changed, 1138 insertions(+), 441 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--a8PrebMg8Cd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmJTCAUACgkQJlKqKVyP
52OjoxAAvhdLSJnNkI/FG4Zmv4d4lzUN9vlxi0he9nTDFtzlDPwxNpG7bqEZ1lP8
getDNz1oOOkLUMbuQ3iXxeWiib1e4GABWUP3e1rtY/z0euK/8Gv5gxnciVWjjb9S
nYEfezkoukZPjFhIC4UhUzHNcb8GyETe05FGjPXJZW6dqfJeC+Cn4h9Te+N4xAGw
bJkIM9vGX5amZ7/vHfsbiiEwfv/Cyk5RrVWBs2V4pVIypZAnqTomSVpEJ4LG5tAn
xfwRc0JIkyBq4q8/VyHc9j9ToECK6G7jH+Lmzj1qPFcna+EpQwQm3z93opD90u0l
GfsQ5yhmI4BIQYh6qlmeukYem8JOWZviAPHor+3rZ8K83kSZk2yO/ghS/UnLcIb/
RQqsRiu0T5azeAwTJM+QXom0++qLGh5InDxSQsOSLsNvcM7zsyCWcf4K8RAZA7l2
sekcczZJ5sVvotDcRlg9BksI5PkIMqPv3mg0yJ9iiMyo0MeEyCbS6qCO3GPBig3h
up6N9jQdvf0i5ZnFQfFzZxK1NtujYmIYvUYZaNoRycCIXnipbg0VtoZKxUMvEyeT
Isik/HTpy6IXeurGZhnm23OfbfnSk5I4+iaYCYRLHwfwDLFRtX8j5fW7CWoS0rin
zltGSh7L/LWPfafwUU1hxHwS/hyBj0NdLPQsDDopVkCG/yGFO+s=
=ia0g
-----END PGP SIGNATURE-----

--a8PrebMg8Cd0--
