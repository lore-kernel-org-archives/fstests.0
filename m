Return-Path: <SRS0=HfNX=A6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A50FC433E1
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jul 2020 18:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9622176B
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jul 2020 18:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3A/bTHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgGSSgt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSgt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jul 2020 14:36:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49059C0619D2
        for <fstests@vger.kernel.org>; Sun, 19 Jul 2020 11:36:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q17so7946112pfu.8
        for <fstests@vger.kernel.org>; Sun, 19 Jul 2020 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition;
        bh=M07jisr+2WThM2lEo+GvT+QHY+RhMzbZBDUM9gDFQVc=;
        b=d3A/bTHNJlLzRydv0GXjO6l3u1fERipZ2E/89BryhaFAMVSFn/QfgW0ALmmgbfF73f
         fBy4E1IJ/3d8q6beXpzEuA0rqReaWHY0QBxLA/1KJP51kWzsRcI6yeJtOrG7w6iwcOxh
         r7HFAOiVxHF23RvZ5Un9+QkoQ22bXY8gJuQy+n1MpEE2y3kZpMunslTbrD5K/feQ+dq+
         2Uf8qH6+HZoAW2ooeZE0Qxh7hcdeGaKRITinugRDm7iSzx0Bf2xroSZB2IhHipst9Rbt
         pSZSk+soPaPd0KHclutzFcuhvJgOkgSm995wWAyKAR6jMmpWbqoty5SDOpSQqQyhnDyw
         a1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition;
        bh=M07jisr+2WThM2lEo+GvT+QHY+RhMzbZBDUM9gDFQVc=;
        b=IDVyvvd+Hl1ndNov4s0R3tfEBj7usqygVRczt2svjxU1NhesYhN1rchie4Dh2hGAXj
         fsy9wG10DZgJNsG7J70vk5b4p547q5SEpiS2ZHZvjuKCiCdmZyqjdKLlNlGH3hog0faK
         yqFDIURIeiEO634n2VxQWoz+TTzGxQQnk6JOkI/7pu9W+ZgYIQreWM5GDW4UirYySOjt
         OevUfh4+dcxxQ0zewmsbddQOjiup05LYTckAf0zcRobyDPpW4sIYSht0brLof2eBGsoj
         knz3bNC5tGpNzh7J7PcKOrdTeqBOEQOvVzVSYh/GPhEK5tBCeGcpdWKg7WKVBStaJA+Z
         +rfQ==
X-Gm-Message-State: AOAM533mTuktL5QBvBxZ9Bdi6KDAAE6rKq48buoBp8jqpxj3l3THpkh9
        wanKllP/bYpvS8GfhHr6oWD4iqEj
X-Google-Smtp-Source: ABdhPJyrIiElPcdFildSieXWRaaNfh9P28g0QuoLxesNDFUoEpjedXKMMb6ymVcm9yjgWa8TDfEmXQ==
X-Received: by 2002:aa7:8d8b:: with SMTP id i11mr15405836pfr.263.1595183808482;
        Sun, 19 Jul 2020 11:36:48 -0700 (PDT)
Received: from localhost ([47.89.231.86])
        by smtp.gmail.com with ESMTPSA id z62sm13899271pfb.47.2020.07.19.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 11:36:47 -0700 (PDT)
Message-ID: <5f1492bf.1c69fb81.e6090.d5f8@mx.google.com>
Date:   Mon, 20 Jul 2020 02:36:44 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     fstests@vger.kernel.org
Subject: [ANNOUNCE] fstests: master branch updated to 04416cee2198
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bUc2P1NZ74ww"
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


--bUc2P1NZ74ww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

The master branch of the xfstests repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

have just been updated. It's been a month since last update, I'm really sorry
for the long delay. I'm trying my best keep the weekly update schedule
afterwards.

As usual, this update contains various new tests and fixes & improvements.

- Dave Chinner adds '-i' option to 'check' to repeat test N times
- Lukas Czerner clears WARN_ONCE before each test, so it will be triggered
  multiple times
- Vladimir Zapolskiy assigns tests with correct groups to summarize them
  properly

There're still some patches pending in the list, notably the DAX related
patchsets from Xiao Yang (though most of the patches have been reviewed by
Darrick and Ira, thanks!). Hopefully I can take them in next update.

Thanks,
Eryu

The new head of the master branch is commit:

04416cee2198 generic/587: associate the test with quota test group

New commits:

Darrick J. Wong (2):
      [3c7fd09bc794] generic/361: disable xfs metadata io error retries
      [81a3c7dc6274] xfs/518: require scratch device

Dave Chinner (1):
      [ffa3e99f2294] check: add CLI option to repeat tests

Gao Xiang (1):
      [7db17edfbac9] xfs: add test for CVE-2020-12655

Jan Kara (1):
      [d9f86e74171d] generic/530: Require metadata journaling

Lukas Czerner (1):
      [c67ea2347454] check: clear WARN_ONCE state before each test

Nikolay Borisov (1):
      [5231c9fa1613] btrfs: test that corruption counter is incremented correctly

Vladimir Zapolskiy (7):
      [1895ea4b4249] common/rc: fix false positives due to leaked mkfs output to stderr
      [98c3ec60484a] generic: reorder output to stderr and stdout from _scratch_mkfs
      [dc4c442e531a] generic: assign a number of tests to attr group
      [8dd4425f53e8] generic/079: remove assignment of the test to acl and attr groups
      [c5e88064eb80] generic/038: assign the test to trim group of tests
      [8d31f184d614] generic: fix insert test group associations
      [04416cee2198] generic/587: associate the test with quota test group

Yang Xu (1):
      [5e169fbd349c] xfs/516: Use scratch_xfs_get/set_sb_field api

Zorro Lang (1):
      [3423e3326ebe] generic: test per-type quota softlimit enforcement timeout


Code Diffstat:

 check                 |  26 ++++++-
 common/quota          |   4 +
 common/rc             |   2 +-
 tests/btrfs/215       |  92 +++++++++++++++++++++++
 tests/btrfs/215.out   |   2 +
 tests/btrfs/group     |   1 +
 tests/generic/361     |   5 ++
 tests/generic/530     |   1 +
 tests/generic/554     |   2 +-
 tests/generic/565     |   2 +-
 tests/generic/603     | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/603.out |  41 ++++++++++
 tests/generic/group   |  21 +++---
 tests/xfs/516         |  14 +++-
 tests/xfs/518         |   1 +
 tests/xfs/520         |  86 +++++++++++++++++++++
 tests/xfs/520.out     |   2 +
 tests/xfs/group       |   1 +
 18 files changed, 484 insertions(+), 21 deletions(-)
--
Eryu Guan
guaneryu@gmail.com

--bUc2P1NZ74ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3C8dh2kiaUCZ3TsTJlKqKVyP52MFAl8UklgACgkQJlKqKVyP
52McJxAAn2aYjD5grYRDFUaNHyugIogSxmSdy9kDtndFkzX8XTA7J+yQmpJGPXnU
AiEgWhWfTOtWROf3KCqcNoz3uzZfZlojoTn0LvVkZAlX02ZZN95DbhRS8eCL5aCq
srsqtgsU5ktvfgwVzi7YLYu1C37RYuYPfv8FKEEBjc+hktlWOzT0PMF52TqAQ2uX
mUz/wSLLd/31xGqr/qndD+0RSXhV9boNK5N4QPZJ8cDtVQTQI19oMbUkrpO8vUUV
ZQPU9lbwNof1KK3ro7fogOHTp9es3nLU6wehmTALW4lZyQJJcj0v4sWg4ayLhzVC
VtjEOF+ubF/7XyTSHF/2QETty7QrPKUtSb0RCc9sWZVVpQYN3I7ZAGiLqhRLonn5
cmmG3KO5gvCce0PqIGU349jIT1iQo80SvjK7zIO40Qapm1u4nFh1iTweznSbCm/K
20A47DYM0925A4ApMzyGqL2B/djU9pgVawmnX7/3VeaOUjkzcEbj2vRsnxiuc5qR
QA8cuVw745ufVzKLaJkjcH26ZjhOt5zDe0In/oQ6xxQiloisSWDOfDNfsrAONfYI
4CCr/Grc52E5ibOCMgSqs4ZLebH1UGunch6zFRVmdW42I5WpAa5D3kLM5fQB1Jqj
KZX6IsTniaoF0iHeKboOicmJPpRNA+QYtu2oWNQp5JBIVydu63s=
=3wfO
-----END PGP SIGNATURE-----

--bUc2P1NZ74ww--
