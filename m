Return-Path: <SRS0=hj9c=5W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E48C2BA19
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Apr 2020 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D6B23370
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Apr 2020 13:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIs5Yuka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgDFNnf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:43:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40640 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgDFNne (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Apr 2020 09:43:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id c5so1733677pgi.7
        for <fstests@vger.kernel.org>; Mon, 06 Apr 2020 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=KrVbzU3fBIbeSMPeK0/X8Ap9IPORmK9eT3mPzi73tAY=;
        b=pIs5Yuka9U469zabfvIUG9Y8Mo2uzps7DQRg0E6h/vhd9VcyTAFD9ZqJogwTB9RUEP
         bzhFzy7rtI2xfH9KXMmo9ylHOpFPDp+1/nSTt4GC+ll5vN1f0/glKWXcNs0OiBi+ZivJ
         voMwU6TfET5mj6UwyNeffdwjL+wCVfQ5e0dwYW3UE0wJUxIowTiOFJzZhitU4INqHw/y
         Xsf4WCL4wpKyFFfTkFyx+ZWXOde41jKOOYH7zJoQ0OdeF1xGlFvSuEo96Dqr383jtD8t
         bbhEwlYlWl4obIr+HJQfymwcuxVteKy8z/xwOIYJLRgGCfIBTNpj4yMWypWjQWeV+Dkj
         lPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=KrVbzU3fBIbeSMPeK0/X8Ap9IPORmK9eT3mPzi73tAY=;
        b=k0AIMn1TP/xWp7eklzrKmjFn/osbFpuN2AI3k62PkJ59hqFBGboXsW/Fvg8zIKnXFk
         tJMFyPQmkb0AEpLrQ9NTlnaIpOt3J20xwXVfeVTANq2wjuA+pgOBmaxHXsxt0FO+DqJL
         MjzMzOyPjNZuYHtEd/v9vazUZ7LbBLe+Q2sqs5pIC2PaFdMeN9i87a/gA4JQ3bZSHOHD
         V4E2yhtWqrjWHU+rdQFgPpbR+bYRu/PcTKbr871HH1QuhgnkVqS1XoTmK3gxuucgXtNs
         MwsZm2tuNYjHMVvpXxBi27VV1tZj327s7M2yt8Q94T3Ywm1H1zT0Gh6fvO/MIu0IpG+G
         YXHw==
X-Gm-Message-State: AGi0PubB81mdK/S4oB+HM4AllJ1I2XQi13iUrz4J+zidlhlj230KRqon
        n0igFw/xsVaQfavHvhrHGndTf7WJ
X-Google-Smtp-Source: APiQypJ5urfp4FMRsrXP79tcw53gFO0Cgmj89fzDY1c/XzYHbanKoCZZZbf/bxe/FqD5UCvfVFmvhA==
X-Received: by 2002:aa7:94a5:: with SMTP id a5mr21888808pfl.67.1586180613443;
        Mon, 06 Apr 2020 06:43:33 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id i24sm10885283pgb.57.2020.04.06.06.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 06:43:32 -0700 (PDT)
Message-ID: <5e8b3204.1c69fb81.f9a0a.215b@mx.google.com>
Date:   Mon, 06 Apr 2020 21:44:11 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 46adeb1600bf
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r7hZmO62o5YK"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--r7hZmO62o5YK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're 3 new generic tests added in this update.
generic/594 currently fails due to a bug in repquota command, and generic/596
fails with v5.6 kernel (but the fix is in latest Linus tree already).

Other updates are various bug fixes, notably, the long standing failure in
xfs/191-input-validation has been fixed by Yang Xu, many thanks to Xu!

Kudos to Christoph Hellwig and Zorro Lang as well, thanks for helping review
patches!

Thanks,
Eryu

The new head of the master branch is commit:

46adeb1600bf generic: test PF_MEMALLOC interfering with accounting file write

New commits:

Eric Biggers (2):
      [0afa39e89123] generic: test fscrypt key eviction racing with inode dirtying
      [46adeb1600bf] generic: test PF_MEMALLOC interfering with accounting file write

Luis Henriques (1):
      [b2d552fbca6c] generic/258: check filesystem support for negative timestamps

Scott Mayhew (1):
      [e31cbea25efa] generic/571: skip test on filesystems that don't support F_SETLEASE fcntl

Yang Xu (1):
      [7d149350dbb2] xfs/191: update mkfs.xfs input results

Yongcheng Yang (1):
      [b6093d0eed59] generic/565: change to use filter _filter_testdir_and_scratch

Zorro Lang (1):
      [5b70d62ccc55] generic: per-type quota timers set/get test


Code Diffstat:

 common/config                  |   1 +
 common/rc                      |  28 ++++++++++
 src/locktest.c                 |  14 ++++-
 tests/generic/258              |   1 +
 tests/generic/565              |   2 +-
 tests/generic/571              |   1 +
 tests/generic/594              | 108 ++++++++++++++++++++++++++++++++++++++
 tests/generic/594.out          |  50 ++++++++++++++++++
 tests/generic/595              | 115 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/595.out          |  10 ++++
 tests/generic/596              |  60 +++++++++++++++++++++
 tests/generic/596.out          |   2 +
 tests/generic/group            |   3 ++
 tests/xfs/191-input-validation |  47 +++++++++++------
 14 files changed, 424 insertions(+), 18 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--r7hZmO62o5YK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl6LMcEACgkQJlKqKVyP
52Pe4xAAvCKqxWpFRWsbf7+N/fNcjrzAi1uOuGS0Xe0OPu2yA9uhorQvLq9v7omW
1y9iiXwu68u0Z3JXYp5tSuhV+rC/rANQNlFOu0iPgkVjRQAPGCJDt5Gv1eOagdre
/siHBVn+nLt+BxRPagsbbwIVmp5aMjbZKfX2GCWeVHJ5gAjU+G/vORb/j2n3t2Oh
5FTu+/k8j3N7vZ73WiiyYKC5ibHNcVKLnohS8BGDxD/uHfbYXVprlzlItQXpWXk0
u6BbtYgJmLLWPO9RCH/ZNh+GIJdu/MJtVDe4JxjuSj9QKj7wgFB6gxASGBwCLxLE
HzoVNSXZmh4cnI8sporUL6R950SkrOZiMLBlTCgb0uSCcA9WfYVYqIxN+xWpiUsI
nDrmt/rmkTVm+Hh8YXIkOjaBzdf4awYMEYVXALP2cDHwNlLWtNkPVbJg3xjX0hkZ
cYr8FI6JX9l+cxUfeJeZgyn1Ti8IyuE1EKjnuf6aHR2TV+y7oTh8bTAdH7gQJOZt
D3J5/7VO3l0DeZhqJJqQ5GzShMxSsyHYWhSXrFIfedR0v5ilzO8tC4ZJT/FvSTP4
PcAZL2WflhNwItbs7g+BCqAFBukO6Do2yuzB4ch16LQMvKerLkInNEYv5pIjDg8a
UGr0fXux2v6gzi1H9jScWdfzLoysl6nv+FzW5D2roVENOot1EGQ=
=1AtA
-----END PGP SIGNATURE-----

--r7hZmO62o5YK--
