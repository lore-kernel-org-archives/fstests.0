Return-Path: <SRS0=YSq7=4Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D622DC10DCE
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Mar 2020 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4FB20848
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Mar 2020 16:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIFjJSq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCHQFN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:05:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39329 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHQFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Mar 2020 12:05:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so3137439pfb.6
        for <fstests@vger.kernel.org>; Sun, 08 Mar 2020 09:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=vH5jTgo/LXrYiSMLk5+ikUcoIjup3FiEyty1QOPOO4c=;
        b=ZIFjJSq89+ur607Lj8In3gyOSHOG+jkcJNbuec4Kn0AcYkD+kTPPuYljd5rG1/Z31/
         HiWWQSK8O2pSunCa2LDmNFg1sfhI/Y8bDJVAwWR/w1CIp8B6nyjRlWvW3Q0lSX9gbLoW
         Tme2EruTsHMJG836WUt5eiq/Zc0FvKf46PRQKQ4hh7v4iHSiaQrn8Z1WcgJ08hF12TpH
         YvbjiLrVLTzuasA88D6mG0p5552DVmo6pFfy8XXWxx4NgMHAP9g0vAMpMHet6KYaggt8
         rs9nUctCL4WqsiyfCKfe6aL5USM+X/t1Wgvt9R/pFtTCkMLjKSNZq2jp2FMT/eVWSK0r
         5JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=vH5jTgo/LXrYiSMLk5+ikUcoIjup3FiEyty1QOPOO4c=;
        b=P/EaDqkpb3WoX8joJqH82sWivzkiRvIiwPRlBKZYklJeWeGhx7bAIgV5VAf7JK5AOd
         BHaCp5y5HDGWKy8HndFfDc7y5089O8rv10Hpd5EyzT/XeTWlZkiqPD07pOEYCRsChTpf
         s8F/PyoFkmBl8dwmoWd6hBoRRTRneO8IpvZRYd9elVOIO03FmCEWBCxL3EJ7lE6OEV37
         Zi8RF9LXUmjgOTMCro3YnKsfVcpPqFvwwZ0AvwvQnjVdGwA9pCMu4u6/+AKLS9KJKiJY
         4iXiiROrU6yWbuPkzvSzznBIRRSVa/oS5u+NrLz6Kn83PSaxNDlsC2g6l0Gw++7wuCUU
         u6MQ==
X-Gm-Message-State: ANhLgQ1k41FCF6i5DnM63V9ymZNFnWOa2fgtO+ONVtDHz9MzPVkVPwr/
        l9O0ZRkC0iE29yXNFE+TvLJDiwzO
X-Google-Smtp-Source: ADFU+vt5baFJO5Knc5SO3uqxzxgWVfHZidQygDHtfSNWfugtoYQSoskQ5yB2tSZopCY23HaBpTQXgw==
X-Received: by 2002:a62:6342:: with SMTP id x63mr13101692pfb.103.1583683510041;
        Sun, 08 Mar 2020 09:05:10 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y9sm15750713pjj.17.2020.03.08.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 09:05:09 -0700 (PDT)
Message-ID: <5e6517b5.1c69fb81.235d.9c80@mx.google.com>
Date:   Mon, 09 Mar 2020 00:04:53 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 915c740030aa
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zrswBJbcgv9p"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--zrswBJbcgv9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. This is a pretty big update, generic/484 got removed
(the proposed fix never hit upstream), and new tests have been added as usual.
There're also some fixes to improve tests on hosts with bigger page size (64K).

The three new ext4 tests (ext4/04[345]) are ported from LTP, and ext4/045
currently fails due to userspace bug[1]. The new btrfs/207 probably fails as
well, as the fix is not upstream yet. And xfs/51[45] fail as well, as there're
still some un-documented commands in xfs_db/xfs_quota.

Many thanks to the reviewers, especially Zorro Lang, who helped review most of
the xfs related patches!

Thanks,
Eryu

[1] https://www.spinics.net/lists/linux-ext4/msg69467.html

The new head of the master branch is commit:

915c740030aa xfs/513: fix allocsize on archs with pagesize larger than blocksize

New commits:

Anthony Iliopoulos (1):
      [915c740030aa] xfs/513: fix allocsize on archs with pagesize larger than blocksize

Christoph Hellwig (1):
      [fd2366c6cd3e] fstests: remove generic/484

Darrick J. Wong (3):
      [640c75ef96e2] generic/402: skip test if xfs_io can't parse the date value
      [2eff3870a7bf] xfs: refactor calls to xfs_admin
      [f10e08998747] xfs: make sure xfs_db/xfs_quota commands are documented

Eric Sandeen (1):
      [48045df9a851] fstests: fix up filters & expected output for latest xfs_repair

Filipe Manana (1):
      [075c5fde2bca] fsx: fix bug where zero range operations never use the keep size flag

Jeff Moyer (3):
      [fc7b3903894a] dax/dm: disable testing on devices that don't support dax
      [121d8fd17e36] src/t_mmap_collision: fix hard-coded page size
      [83e2828dcfe8] xfs/300: modify test to work on any fs block size

Omar Sandoval (1):
      [a0b98ada02fc] btrfs: add test for large direct I/O w/ RAID

Yong Sun (1):
      [54c62ab0d0fd] fstests: transport two ext4 tests from LTP

zhangyi (F) (1):
      [6a5e629bfb54] ext4/021: make sure the fdatasync subprocess exits


Code Diffstat:

 .gitignore                |   4 +-
 common/config             |   1 +
 common/dmdelay            |   5 --
 common/dmerror            |   5 --
 common/dmflakey           |   5 --
 common/dmthin             |   5 --
 common/rc                 |  11 ++++
 common/repair             |  10 +++-
 common/xfs                |   8 +++
 ltp/fsx.c                 |   3 +
 src/Makefile              |   3 +-
 src/t_create_long_dirs.c  | 139 +++++++++++++++++++++++++++++++++++++++++++++
 src/t_create_short_dirs.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 src/t_get_file_time.c     |  53 +++++++++++++++++
 src/t_locks_execve.c      |  89 -----------------------------
 src/t_mmap_collision.c    |  40 ++++++-------
 tests/btrfs/207           |  62 ++++++++++++++++++++
 tests/btrfs/207.out       |   2 +
 tests/btrfs/group         |   3 +-
 tests/ext4/021            |   5 ++
 tests/ext4/043            |  56 ++++++++++++++++++
 tests/ext4/043.out        |   2 +
 tests/ext4/044            |  88 ++++++++++++++++++++++++++++
 tests/ext4/044.out        |   2 +
 tests/ext4/045            | 111 ++++++++++++++++++++++++++++++++++++
 tests/ext4/045.out        |   2 +
 tests/ext4/group          |   3 +
 tests/generic/402         |  20 ++++++-
 tests/generic/484         |  51 -----------------
 tests/generic/484.out     |   2 -
 tests/generic/group       |   1 -
 tests/xfs/030.out         |  12 ++--
 tests/xfs/178.out         |  12 ++--
 tests/xfs/287             |   2 +-
 tests/xfs/300             |   3 +-
 tests/xfs/513             |  14 +++--
 tests/xfs/513.out         |   2 +-
 tests/xfs/514             |  57 +++++++++++++++++++
 tests/xfs/514.out         |   2 +
 tests/xfs/515             |  53 +++++++++++++++++
 tests/xfs/515.out         |   2 +
 tests/xfs/group           |   2 +
 42 files changed, 887 insertions(+), 207 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--zrswBJbcgv9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl5lFywACgkQJlKqKVyP
52O0dA//Xn03Ys1rg0x2CJsIzjf+I+2e3/uOgNsOvgTN+hn+ywXQ/+FeqbfyBpq7
al07Pd5i+BXZWiWIaNKDXYGFGIfJ9Y3V1tJMjGNOLCxmSC4FARF5DkiFPoBdZVoU
tbUbZciX26m0vFLydzQRqAfvQAElRx3AS4CEGOvE/4fRr6fNFVQO1Zezc1dwxAIM
Ly/MRXtdbC6bMSmV+V72OjYLp1ajE59EVxic+4afpjzohF1HFq0QNpwbx98YJb+c
paAvFTEa7k2sV7AXYy1b7vZfbM3uzlzuHisGK/nN8MLkwT1OXwAaS4683xLlgtkz
eEAeo4rLplKmIbwMMzEo/YpEjjU+p0tB9tKfr8zLwsO5qeIGdd1r1lYv+ymf0ZYO
Sf7fNFgruIHd9JlniNmnZD6L6WwZMItU7BiGZI4wollQYOihiDPvbtKrGhgUdslS
3O7NI9d/16nKvyOJ7Fyt2sRHR8DZLBzUei4oY+mglPrkXcVwTKNtXcoCxQP7BS3n
lUOaFRSIBshAOK5PmldG3/GaJUyyDFNxQ3eOXEof9Vh8d4lwRdiqrb/3C+9t2OsF
9OjHWR7ciBs4mgdoM6oiW/ct7S9bYsVRuihPnTNvkAq0/I405mHngvL6bnFFw0dF
3eTssm8+U28gD9vpTy/j1r1fEjdQQ06dySHbYilwdzGvPGzac5A=
=S20/
-----END PGP SIGNATURE-----

--zrswBJbcgv9p--
