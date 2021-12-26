Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B7C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 26 Dec 2021 15:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhLZPMx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 26 Dec 2021 10:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhLZPMx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Dec 2021 10:12:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715AC06173E
        for <fstests@vger.kernel.org>; Sun, 26 Dec 2021 07:12:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g132so8162820wmg.2
        for <fstests@vger.kernel.org>; Sun, 26 Dec 2021 07:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=afH6pG/wj15/iX7CWhcwEhggZ4kIGYfyBJ59odzxjDs=;
        b=MIRn7HhTldrPWKe4XC0BV29bn+B8sMn0C9NasqD/cuC+WNldhhrzMMfLUB6c70AdFY
         DWlHPVjb8A+4rrIxxjfFwXbIDxWSuTpkWokdDAB1JC9gJHKKVtQ4v/6+b2jLbDDezbiV
         0qOidGhwuL24u5VLiCrAGZJw8+g2B/B5BvjkCuTCyPG7esw+4n9yoplL2VzhwKowtyrZ
         BpXl1kUNypruCDxlyTTe+aS4Qrtm73efU+zFh6+qdmT2N8AFulfsENl9qjlhViddql4u
         w2fNaWFfl0C8evYszO+wcvQJnu7CV58FvZ3RPs1Vuu5RdkZ5uHEKoJbLXuGZrZBoZhZE
         9BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=afH6pG/wj15/iX7CWhcwEhggZ4kIGYfyBJ59odzxjDs=;
        b=RdOCPWjvybWnwslFtij9M28ZmT0nc/zCdhzWwOScCh7bspAEN+q3cAXHV+yjWP55l6
         6LDrMsG9dgW9UCZw7PxkdXiaGmXyORTK9K1tc4eGdOf4OxLsGYDzuDnthvaGzftxgYbb
         eCYDB+oGJU4EUZLE5UaxiC+eC29dypDhH2LER09IfuTxleoYcbGk09X4ST31vtzfTZXr
         GZzQRe3+9r+GieU71glNyCEFHd71dvplD10G4/QpiVOGr7jJOCuB+1w/BF1OU3Ec3wEW
         P8Q3GK1f5CdUl7+GXYtZu8OuMTYECL5OP4xnS2YJ/cijfNy6nFNQK5IIw4IoXa/urhBi
         h6HQ==
X-Gm-Message-State: AOAM532zSzYt6XmCZ1wM141MDWTkRV3GE+oIEgs7A4frkNv6eUFjWToA
        D5CpOpdChvtA0KoWlY9INwaLnjbWMj0=
X-Google-Smtp-Source: ABdhPJx960d8Z9LjWJiS2BgeSKZeHIoD71zFqlE7jV9E5UOWljErs2IkzmR957W3g7gWhKlBODH9aA==
X-Received: by 2002:a05:600c:ac4:: with SMTP id c4mr10297797wmr.81.1640531571021;
        Sun, 26 Dec 2021 07:12:51 -0800 (PST)
Received: from localhost ([8.208.10.148])
        by smtp.gmail.com with ESMTPSA id b19sm17762713wmb.38.2021.12.26.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 07:12:50 -0800 (PST)
Message-ID: <61c88672.1c69fb81.e4f24.004a@mx.google.com>
Date:   Sun, 26 Dec 2021 23:12:45 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 770f462e17e5
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k5JTNTX9T9Uj"
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--k5JTNTX9T9Uj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. The mmap v.s. reflink tests from Shiyang Ruan have been
merged in this update, many thanks to Shiyang, also many thanks to Darrick J.
Wong who has helped reviewed this big patchset!

Other patches are normal bug fixes, and one new test for btrfs, which currently
fails with latest v5.16-rc6 kernel.

Happy Holidays! :)

Thanks,
Eryu

The new head of the master branch is commit:

770f462e17e5 btrfs: test cleaning up of the stale device

New commits:

Anand Jain (1):
      [770f462e17e5] btrfs: test cleaning up of the stale device

Eric Wong (2):
      [f375cedff940] generic/647: add _require_odirect
      [53628c36629b] generic/228: set vars for early _cleanup

Shiyang Ruan (17):
      [924922639321] generic: add mmap CoW test for ranges of two shared files
      [b94d2fa60e1a] generic: add mmap CoW test for regular&destination extents
      [84b9ed88b6d3] generic: add mmap CoW test for unwritten&destination extents
      [0405a0a3941c] generic: add mmap CoW test for holes&destination extents
      [ac3fcc16d298] common/rc: introduce _require_scratch_delalloc()
      [ef91f0027bd0] generic: add mmap CoW test for delalloc&destination extents
      [4599d1700f93] generic: add mmap CoW test for mixed&destination extents
      [0d9bd77550bd] generic: add mmap CoW test for regular&source extents
      [eb4a503060f7] generic: add mmap CoW test for unwritten&source extents
      [117fe7fe5039] generic: add mmap CoW test for holes&source extents
      [61de38736b41] generic: add mmap CoW test for delalloc&source extents
      [74b782c61aa4] generic: add buffered-io CoW test for mixed&source extents
      [644e6bca6734] generic: add direct-io CoW test for mixed&source extents
      [3472f99857df] generic: add mmap CoW test for mixed&source extents
      [a2ba26e1ac18] generic: add race test between reflink and mmap read
      [6a809094d232] generic: add race test that mmap write to source of reflink
      [2daa91f1b599] generic: add race test that mmap write to target of reflink

Theodore Ts'o (1):
      [92b9c0dedace] ext4/033: test EXT4_IOC_RESIZE_FS by calling the ioctl directly


Code Diffstat:

 .gitignore            |   1 +
 common/rc             |  13 ++++++
 common/reflink        |  62 +++++++++++++++++++++++++++
 src/Makefile          |   2 +-
 src/ext4_resize.c     |  50 ++++++++++++++++++++++
 tests/btrfs/254       | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/254.out   |   6 +++
 tests/ext4/033        |  16 ++++---
 tests/generic/194     |   1 +
 tests/generic/195     |   1 +
 tests/generic/199     |   1 +
 tests/generic/200     |   1 +
 tests/generic/228     |   4 +-
 tests/generic/293     |   1 +
 tests/generic/295     |   1 +
 tests/generic/540     |   1 +
 tests/generic/541     |   1 +
 tests/generic/542     |   1 +
 tests/generic/543     |   1 +
 tests/generic/647     |   1 +
 tests/generic/657     |  69 ++++++++++++++++++++++++++++++
 tests/generic/657.out |  14 +++++++
 tests/generic/658     |  59 ++++++++++++++++++++++++++
 tests/generic/658.out |  12 ++++++
 tests/generic/659     |  59 ++++++++++++++++++++++++++
 tests/generic/659.out |  12 ++++++
 tests/generic/660     |  59 ++++++++++++++++++++++++++
 tests/generic/660.out |  12 ++++++
 tests/generic/661     |  62 +++++++++++++++++++++++++++
 tests/generic/661.out |  12 ++++++
 tests/generic/662     |  67 ++++++++++++++++++++++++++++++
 tests/generic/662.out |  12 ++++++
 tests/generic/663     |  60 +++++++++++++++++++++++++++
 tests/generic/663.out |  12 ++++++
 tests/generic/664     |  62 +++++++++++++++++++++++++++
 tests/generic/664.out |  12 ++++++
 tests/generic/665     |  62 +++++++++++++++++++++++++++
 tests/generic/665.out |  12 ++++++
 tests/generic/666     |  65 +++++++++++++++++++++++++++++
 tests/generic/666.out |  12 ++++++
 tests/generic/667     |  65 +++++++++++++++++++++++++++++
 tests/generic/667.out |  12 ++++++
 tests/generic/668     |  66 +++++++++++++++++++++++++++++
 tests/generic/668.out |  12 ++++++
 tests/generic/669     |  66 +++++++++++++++++++++++++++++
 tests/generic/669.out |  12 ++++++
 tests/generic/670     |  72 ++++++++++++++++++++++++++++++++
 tests/generic/670.out |   5 +++
 tests/generic/671     |  64 ++++++++++++++++++++++++++++
 tests/generic/671.out |   4 ++
 tests/generic/672     |  64 ++++++++++++++++++++++++++++
 tests/generic/672.out |   4 ++
 tests/xfs/172         |  12 +-----
 tests/xfs/223         |   1 +
 tests/xfs/224         |   1 +
 tests/xfs/228         |   1 +
 tests/xfs/230         |   1 +
 tests/xfs/257         |   1 +
 tests/xfs/258         |   1 +
 59 files changed, 1469 insertions(+), 19 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--k5JTNTX9T9Uj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAmHIhicACgkQJlKqKVyP
52MTOhAA1xePcC0CLvh2guFrgqY01dSOGKYIhgfYaqJiTKqbNOVecv35EdLHGL4B
9r8Srpt3Jp7NCRQTOIy68KguOZa+pAmoCpR0PkMOCfRnC0eC+FC60zNPoPJribSr
0N4R9hEkUpLIqBn8Qu5r1JAoQ563g0r/KjReeOGmLHfCQtjbXgk3SvE6XV+c11Qv
CRI2rpsroCm9+vuolwVB/Vyxli4DYVbvPPdLmfHiC5GkBxC17Vi6mUrfo+sSrEMi
XQszdvyfLP4Syr953wsTw6DM8g6OxqCGpcIpbAUlCGgxm1veonBnz2yjrpDDDLYY
K5OlOmv3Md/BV0bLfRDXHQTzpMrS38NG34rJj3SycFzGVhKqRR//Yp6k0ELbaeGe
VlucmkTE8P5VGWwVmBN0XbNf/loKCvn95HH6WJ3pP9ZiSHrNVp788PWDg1UJjNhJ
r8VIXMeCKEq8h/x3fdyPa7cG1JFxYuVtW5TdErNKyLQK4+8j2/bwI/L+5/UJ0k/A
1v8S/5rNuH6gBK/zWs3d/GKmD4GgY/UQXUDj76j9fIBp3LudApHstE6XIiks9scz
DD/33k4bJPo1zRsKXZ34t2I1aBOOvMVERkin8x4awIjG2QgXiuo2n2VYvEFsT/I1
XFjzQK96HAAibu4wBN40lgHu6VDNYFNhFxJAybEtrxqL5AvlImc=
=WcxU
-----END PGP SIGNATURE-----

--k5JTNTX9T9Uj--
