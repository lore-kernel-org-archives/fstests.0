Return-Path: <SRS0=1u3g=ZX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06F7C43141
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CFA215E5
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Dec 2019 16:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxZZexGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfLAQhZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:37:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43289 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfLAQhY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Dec 2019 11:37:24 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so2974155pjs.10
        for <fstests@vger.kernel.org>; Sun, 01 Dec 2019 08:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=xvXzKGZSEzr9yBwYJYyyX5M/ySuFmWDdCIjqIKT2+yc=;
        b=sxZZexGHb9SXEI905NaLsU+7Un735dfpNhGPMnBteSpxZPQRD7liVfk29QlDKXdCPj
         4heQd4ZUzACLNwEToAJq+R9HSZerQsth7zYHKcwsepQ9c/XVgEjzpyoRZDZsI8I/6jSU
         x7FiwN0VCCMR6Mglw3Z66PdG0WfuojqJgjye+5MwYSVgZCvw4zo4cX4XMqnk+RSYidEO
         /TdZCnIoaN41WjKG9upM+Smox+8BguNJ6hQQmwCSx5KzpckIcw4Bd32I78eJTyh4lBmH
         Pmysl9dMO7LcQqTJT4qb3Sqp9hrNAxtyShVZ5K1itEenG0zu9yEQ5JahQVgdP8X7a5Kj
         +G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=xvXzKGZSEzr9yBwYJYyyX5M/ySuFmWDdCIjqIKT2+yc=;
        b=mZ2PvzzhU0zJVXIeXGDOsZ+o3VIt3EiWTa/JrDfr1YUNUEvGCK6y2vwl2h9WtC4Gya
         4yPRfHeK+N7lE5J5+Nsdl/9PQR0z9HiLlZGIoHYqtxTau/t7pVBEriRKugiPE7UrXnZ1
         XOIDbZMX3/Yjnka4cltXULz85ZCR0Cdz0QtYFJV7sKkoRa1dRWK0M/HqUPO1wSoUIhfI
         QEhTULO1sTSZ/m4WmWG2I79TMzzWP1ND47FphnmQRLt/lJ15N0t0tLHV8ZPKKmkWDM6C
         BUwYEgjdVq8P1rOy3vB8g/1r2I8/oPL+jBbLDedRlOikt7oFsnpAjY2DFq5cWf33/nCC
         vklQ==
X-Gm-Message-State: APjAAAWetewjAmLQVJ0bCfyPjYrdMvdCJJuuZ3eM4cH0OIj4U/Gi34k2
        qCKymYbQoffafqKfL+Ls8wQc1d83qCs=
X-Google-Smtp-Source: APXvYqxYAIK5E1AOBqrwjRfY8HWnZxeKBymZgq0igVHUuvmS/SZV7Fj3H3a3MSVLeAkmAXgdTcmWGQ==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr23475489plz.256.1575218243972;
        Sun, 01 Dec 2019 08:37:23 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id b11sm30366425pfd.83.2019.12.01.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 08:37:23 -0800 (PST)
Message-ID: <5de3ec43.1c69fb81.43537.cc96@mx.google.com>
Date:   Mon, 02 Dec 2019 00:37:18 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 5652a4880c54
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T3rIuGPfJrkF"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--T3rIuGPfJrkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a normal update that contains 3 new tests and
some random bug-fixes. Currently generic/586 and 587 both fail on XFS with v5.4
kernel, and generic/588 fails on btrfs.

Note that there're still some patches pending in my to-review list, hopefully I
can get them done by next week.

Thanks,
Eryu

The new head of the master branch is commit:

5652a4880c54 generic: test journal/log replay when a file with cloned extents was fsync'ed

New commits:

Baihua Lu (1):
      [95246f53edd0] xfs/191-input-validation:Fix issue that the test takes too long

Darrick J. Wong (4):
      [0732ce287771] generic/558: require scratch device
      [bdb2c8cc5f44] generic/050: fix xfsquota configuration failures
      [d38fc1527d0e] generic: test race between appending AIO DIO and fallocate
      [6b04ed05456f] generic: test unwritten extent conversion extent mapping quota accounting

Filipe Manana (1):
      [5652a4880c54] generic: test journal/log replay when a file with cloned extents was fsync'ed

Masayoshi Mizuma (1):
      [9a09e4ec7284] generic/551: Adjust the size argument for aio-dio-write-verify

Qu Wenruo (1):
      [5e6b248c6668] fstests: Allow user to keep $seqres.dmesg for all tests


Code Diffstat:

 .gitignore                                         |   1 +
 README                                             |   1 +
 common/config                                      |   3 +
 common/rc                                          |  15 +-
 .../aio-dio-append-write-fallocate-race.c          | 212 +++++++++++++++++++++
 tests/generic/050                                  |  12 +-
 tests/generic/050.out.xfsquota                     |   5 +-
 tests/generic/551                                  |   6 +
 tests/generic/558                                  |   1 +
 tests/generic/586                                  |  44 +++++
 tests/generic/586.out                              |   2 +
 tests/generic/587                                  | 121 ++++++++++++
 tests/generic/587.out                              |   2 +
 tests/generic/588                                  |  77 ++++++++
 tests/generic/588.out                              |  13 ++
 tests/generic/group                                |   3 +
 tests/xfs/191-input-validation                     |   2 +-
 17 files changed, 510 insertions(+), 10 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--T3rIuGPfJrkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl3j6psACgkQJlKqKVyP
52MtPxAAxYk94sbT4+EAOGPonw8wPJ+9R6g01roC0unhVupBbOoR4+r7G7P6HHTN
Bm1DkqxrqQGFVP8Y4L1Zsii9Fzu+L4eIA81YvGgdaIXTb85Bz+sf8NsF5dDveKOh
MBa4teTsi+l0kyU5xaa+6EpreAEpDHR1+Hq6J9RgMLO6x6AMDMBN4Y6s7O0/e32Z
qGVHlOS2dyemAsfoVvJHBVFN2DMyxah6ssfIv7witrnB2XgxV5BmuSpp2HLf9M6F
hzsSiKgvbIGIboiOfd+hQ5hBZUAfEhDQ5jnlOO/BvdesjV8dQiMzbUVoMlYAMSYG
mt0Xsx7CwadWBeZHgls9zLTqhVEUHGH7cCAO1f+sE36ZMFGX+78S386/6r9fm6P6
NfnA8JO9Xwp4m1GdA18Row+d1g+pgC89sH0Y64xTI94Y67HVXJvhqgWNBXgLYrew
/VwSFHUaDATu1Ve2zqsicaDVC+kM+OvTW4kQReGKbzdxAtGrkFcuMMlZagPGMlzl
zlUHj6FSR66/ZTOO5aBYMNeg2QkgKqIDVUmui5x9e7447H63nVAHrvtWAB67a1g3
9w9HNI0a6IQuk33136+7A6m+k6bHdU2E5GiaUsD+u14QeCcKOwbXbEHtV5PgjZ9x
g9lCBX5J6qaRURoIFtF9TQFsRE0L5OlFJ+ncbp1vTmbSVqXk3ok=
=hZuX
-----END PGP SIGNATURE-----

--T3rIuGPfJrkF--
