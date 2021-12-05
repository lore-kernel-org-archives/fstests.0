Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA3C433F5
	for <linux-fstests@archiver.kernel.org>; Sun,  5 Dec 2021 15:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbhLEPdx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 5 Dec 2021 10:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhLEPdx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 5 Dec 2021 10:33:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76138C061714
        for <fstests@vger.kernel.org>; Sun,  5 Dec 2021 07:30:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l16so16977264wrp.11
        for <fstests@vger.kernel.org>; Sun, 05 Dec 2021 07:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=JwzRbbiKWMIc0BdGYsxI9xD5P0PGdpyQkAx3QIIG87k=;
        b=KP/tQOAqx4HZm7L+OuBmdJJDgb0+pV1F9V4kLfjnTbxwJJ8NZ88WNi6vXfa/TaFOh5
         WR5vPtVv2697BLgd6W5pWQoT3YLE/MDkqkFB3Se3XLkN8sCQA3AhhCLVlxS+ie0Hd8Bw
         oVjvIGB5pEG+To7eVyzrz9dUGbdLSE73IBVxxrqKN5fLBteTaux2K/TFZJgjPNXUvQ3Z
         7VTY/GaV6ta8bqdlGH+BCJB/LYwiDHnInbEEmpqxaS5OO13OrRWzjp8wZPvd/BokLxqU
         9WNnFROJyrf4vlHweCHSLYUkNDwWzfbr3quUm/Ne8EZfRmsCehySIXtUXE5ks4dTIFhx
         7W2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=JwzRbbiKWMIc0BdGYsxI9xD5P0PGdpyQkAx3QIIG87k=;
        b=4j5IVKq8LM1X2BLsbUeugZjs23pnWpmZcBeyWnj0FFBBOwWF6z2v3DmYn5QJuB3h39
         5CL1vTF9Qao9twFVWEIdj7332gNmamnjrRClB06qQ4oto0MG4PujXN95P4RDZjjd8USW
         WKPFFMkSGOTQFzq2DhWc7IUKWL8Ke20u2GaOJR4FemiK7D5PPTGqPyhy3VAEDE8IXouT
         hspyYZnx0Y56mYIREvMwqFMkfoP/1KbQ2Vn5fnDWbITvxAqGMF6yigbxcw27wPwCWUgn
         Ytl9ISXA3/4DnDKCcU3qHWt5iS+fm/KY1kCVIwp9NjVwimig48EEr1I3D+igb+aerCEh
         HTHA==
X-Gm-Message-State: AOAM530cIvmuK0+NCz8BW/VGT0kbDCBxlgQSIovDy/MT+jwwCJZzuI8c
        /eHZF0yFEl5JrGwlNY4bTuGI+A1zqgaBaQ==
X-Google-Smtp-Source: ABdhPJzA+7MLgwkpS/0YECYm5r99DYsloRaIqJjOS+gYZXQFQVeWunD7I8DCtmUWzBLXuB4SceTS6w==
X-Received: by 2002:adf:fb06:: with SMTP id c6mr37760536wrr.625.1638718223692;
        Sun, 05 Dec 2021 07:30:23 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id c6sm14082572wmq.46.2021.12.05.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:30:22 -0800 (PST)
Message-ID: <61acdb0e.1c69fb81.3cbf4.f912@mx.google.com>
Date:   Sun, 05 Dec 2021 23:30:19 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to d489644a5ad8
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NT1Aqdpq5ZU3"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--NT1Aqdpq5ZU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. Again, this update is mainly focusing on btrfs new
tests and fixes, and the new test btrfs/252 currently fails with latest
v5.16-rc3 kernel.

Thanks,
Eryu

The new head of the master branch is commit:

d489644a5ad8 btrfs: Add new test for setting the chunk size.

New commits:

Filipe Manana (1):
      [25cc5bac2f97] btrfs: test balance and send running in parallel

Josef Bacik (2):
      [462886a9012c] btrfs/156: require no compress
      [e9ee0888388e] generic/260: don't fail for certain fstrim ops on btrfs

Stefan Roesch (1):
      [d489644a5ad8] btrfs: Add new test for setting the chunk size.

chenlong (1):
      [50cd778c0a3d] ext4: verify ext4 when the starting block of index and leaf are inconsistent

suy.fnst@fujitsu.com (1):
      [23255e2c0842] generic/571: skip test if locktest -t on NFS returns EAGAIN


Code Diffstat:

 common/rc           |  32 ++++++-
 tests/btrfs/156     |   7 ++
 tests/btrfs/252     | 190 ++++++++++++++++++++++++++++++++++++
 tests/btrfs/252.out |   2 +
 tests/btrfs/253     | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/253.out |  10 ++
 tests/ext4/054      |  85 ++++++++++++++++
 tests/ext4/054.out  |   2 +
 tests/generic/260   |   7 ++
 9 files changed, 602 insertions(+), 4 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--NT1Aqdpq5ZU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmGs2pYACgkQJlKqKVyP
52O8QA//cqywNgytxOpvKMMMm9RsfdZ6bXWUTyin++4t34G3HOEsn7raeXyCme23
9Tyh1mawTnEn1Uyg7H65ZIGxk7UVfqAaPIehl3bzB+9inKDMcvTmoPDmjMVOUq2q
1dUVW9WnuqagT6KJHYdAjtQDidD4dFcO+jsAcd+80KnCa/FP0KqsQ8h6NKl6dUKH
ixM0thA1UGe+mC2PfwbIvZzJYFLmMObNncGl1NtipOrv0qedkHF/ua9uaFSZzvfN
Q7eJf47c5HPjA3QlDvDpwEZOgusKFHbMQ9gsBW5xSgKY996Ona2BmJZGsLp7KYwP
sUYy7ZFZqESt6vk1xuCrIUzdxlSqRnL6jooJ8rt1EMJEk3bMWAgK/gcEfINj/nuN
/vZIsXFOrLZCA2GUAvXy7lxfgNlpR3uD+/6enqmpBFgZuwAIy989IyWoEJioOBu0
DvvXh4jPk4hBaBWpWuyvtnyCuqEehCG01SD/+uyWHRLZjK1JiAmm9lazqeldZzQc
t72oxIHaMI/50IphGfaror1DuYK0iBYhvZNrnX8DzFBC1DXTNVWX3h8MxCQ+KYNU
BMStV9ic9lLgq/KAEgvSIW1mQHJfJhseawffYGN3P7kHW3G+QamXPBMGsCJFM8qA
asCjRO0qyEou/l69rD6rb3RNGvBa7hMBtdmTmQsFmaNlVffPbP8=
=opd1
-----END PGP SIGNATURE-----

--NT1Aqdpq5ZU3--
