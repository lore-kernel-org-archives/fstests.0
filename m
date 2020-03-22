Return-Path: <SRS0=NM89=5H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C72DC4332E
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Mar 2020 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD1320714
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Mar 2020 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOKjus46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVP3X (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:29:23 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39736 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVP3X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Mar 2020 11:29:23 -0400
Received: by mail-pj1-f67.google.com with SMTP id ck23so4851554pjb.4
        for <fstests@vger.kernel.org>; Sun, 22 Mar 2020 08:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=68/XjZprJvnWg0HqGq1/30vYuumwYieOpQxVxLFKUy0=;
        b=eOKjus46vyX6J1I8e8OQ7SXA26jT+S1/MN0Kds0hXMlVz7iWKYiTX+8K23H6H7OJ1l
         Kwpqbqs7IKtCKe25X3TfQURdG6KJ/ruvaThEkrBZgxGVfn/M+jhYgkY2LIB+xQw2zD5h
         BSaM4lJFTozlXAatXo7keHIwyYwff+BbfggZF/qcZwbljNBP9fvwUBw9Zx6j2rAJVygk
         i5sS8Ys/v0wCURW+HouOH5J/QhQNQo7PQ2p3yI9I45O5oT/oq/L5CW7Tecu92hpJZ5rX
         btb93gXRhBY3B9+jhncNceryMcoVmu240uKoCmd+D9EDUO0y5uV3fBGNFm7peh32XpU7
         s7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=68/XjZprJvnWg0HqGq1/30vYuumwYieOpQxVxLFKUy0=;
        b=RqpABYT8/k8FUJIysFt6LbvLU/xeqhk4Oy0dRfzUxyO8hxq/4m9esM37NI1BCS8pgq
         UvaqabTxqRYSQxiwwCPTwPeyw+BLdxDEitCZP59SZ/H8NwNxlZtiLUjAzXNiemUAlLWY
         wW2fNfsh49Zxv8hGHgekb21Rd8Y700JRAo+vUhEt3YokZqD/1bNDUn5DVWW8EjiIKll0
         CW7eCMMrPCmhDFKWMSR7MdE6nHTPLl1XeEpDOCzpMCsEbLj6+qXn4Kein9QLE7z3aUgV
         s6c8ld/kTou7W8xIr3AtaiWYk6cduWGNjFWjifd5o6jaLNk9gS2NVBfwx5gy9IHToyW1
         70lg==
X-Gm-Message-State: ANhLgQ0CA5J+4FxKZeFA57KS8ZtiAsY1PDtCbOjW8jJVMBc3PpyBCUDS
        8TU2cXwIMVDmCCi1EdmkURlnDyvt
X-Google-Smtp-Source: ADFU+vun2etBkA0rX2fTZYHzyFzYwivIgKVd1nRiewKvaj5Kh/XMp09b6+bE/IeWT1jOuVWQurQSCA==
X-Received: by 2002:a17:90a:1acf:: with SMTP id p73mr2971231pjp.53.1584890962621;
        Sun, 22 Mar 2020 08:29:22 -0700 (PDT)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id 67sm10814475pfe.168.2020.03.22.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:29:21 -0700 (PDT)
Message-ID: <5e778451.1c69fb81.8c6a6.816b@mx.google.com>
Date:   Sun, 22 Mar 2020 23:29:28 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to b2faf2047019
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YS2Mja4JYfS7"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--YS2Mja4JYfS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. There're two new btrfs tests added in this update, and
one of them (btrfs/209) currently fails with latest v5.6-rc6 kernel. The other
commits, as usual, are fixing various bugs.

And I finally got my 'review' mail box done, if your patches don't get any
review nor merged, please resend.

Thanks,
Eryu

The new head of the master branch is commit:

b2faf2047019 generic/587: fix rounding error in quota/stat block comparison

New commits:

Amir Goldstein (1):
      [4df36dac1833] overlay/07[01]: use existing char/block devices

Anand Jain (2):
      [1944efc947ce] btrfs/177: check for minsize of the scratch device
      [da8012e69dde] btrfs/177: fix for nodesize 64K and type single

Darrick J. Wong (1):
      [b2faf2047019] generic/587: fix rounding error in quota/stat block comparison

Filipe Manana (1):
      [74278dc29355] btrfs: test power fail after a ranged fsync when not using the no-holes feature

Marcos Paulo de Souza (1):
      [d116fe3774b9] btrfs: Test subvolume delete --subvolid feature

Paulo Alcantara (SUSE) (1):
      [a75b83544454] generic/310: slightly improve check for dmesg error


Code Diffstat:

 tests/btrfs/177     | 36 +++++++++++++++-------
 tests/btrfs/177.out |  6 ++--
 tests/btrfs/208     | 68 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/208.out | 17 +++++++++++
 tests/btrfs/209     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/209.out |  7 +++++
 tests/btrfs/group   |  2 ++
 tests/generic/310   |  4 +--
 tests/generic/587   | 12 +++++---
 tests/overlay/070   | 10 ++++--
 tests/overlay/071   | 10 ++++--
 11 files changed, 234 insertions(+), 25 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--YS2Mja4JYfS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl53g0IACgkQJlKqKVyP
52Ov0BAAhoVWtKnnwh7D0/+tFb1PkIIMqJqzIJPgC0Dkq/Q9yu7z2dYsrJlBg+OB
3JB15vih3qc0s+GiLRn525CeAEV74l3M/ExxjoVY3lTMqhIMtuCj1LYkvpEUBJsM
Nggr9nAp8h1YEQjXFYwoLSBd3ffP3zEciyzgz6OLHT9pSxnIoSs9GPcFYhzT7tnm
OzbQp19qD1JALOpz7vZcBYtlfFZXQCcDBhv8Xu6xZDSP6/dc3dW+cWqlPq2CPFTB
jyuHLhQz2lCTjH5NrIDGLlSxYVRecQVm53r7ngaQN7OTzSqORsDUhuQRITGdcUqK
860KS2i36um5h7A7vLn0NJqiixizze0m5MwfRP4L5VK5/fvBS2YoKj/Dmretyl8g
TEvHm11sPoIm6N48fcERaSIFVg+rk2SCN5PgdUzaGQURSsl+LLusGi9skE1/mJMS
MuIK8rQ0VSwSIjNl+qAfasKHZeyCWTEqR00m8XdVIupr/eYRDf5S9IOuqMAnLI6O
LQpzrwxOjACJvTz1+wqA96Bc40kHuGaASfRvNmdhshonXNzew8xGnxZb4ghMSO9V
VdqnMCdn/vPSXE+igAPzVHVGBQJ80CLL9a3Jb2sxZ60NA/B+13F/VkW3cjLcYWem
jg22AFYqr/p0F/DejH65NhFGzKE2c7t79s8XpmiXGQpPJtX3wfA=
=pV6L
-----END PGP SIGNATURE-----

--YS2Mja4JYfS7--
