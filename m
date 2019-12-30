Return-Path: <SRS0=M3Lt=2U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE133C2D0C2
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 14:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F36C20718
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Dec 2019 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPqVhYXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfL3OOd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:14:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55707 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfL3OOc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Dec 2019 09:14:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so12455841wmj.5;
        Mon, 30 Dec 2019 06:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bv+a+5jR3vABptONRzhKBD3zAVTtf29+DHfuUkha26U=;
        b=OPqVhYXN+U5xA/M18s8lRNE7pNoWeck/KAHhD7YU/BB2fj3KI55cD60aQsj4k7PiWQ
         siolh27lKwGxcrWBXdSPQL0U4V7ElwKoNyj2wbAGr3LMPrgc7vn+ybe79fFwEsDgmYGR
         P3WaI2k4eacQb6l1fhoF+pL2oxZrQvRrvCLDdD6SmMMQB/OFHH0qxeMuvZsm0IZ/tw/K
         qS0LJ4RZ5fxlF5ZGCGfviPB5X+3uqU5ps8sI7fMarZSf5jX31kwIsQeu1CNIQUjbo/Ma
         cbnFPVffF/fB0xTHjt/Yl2M12JVrwBHyMS3LVnDiYYw3I6ObBU2a3XETGlKse49SZxr0
         8cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bv+a+5jR3vABptONRzhKBD3zAVTtf29+DHfuUkha26U=;
        b=TMPE9FJW3QzXYS00CvQCWVHukrYth1zfP1VH1ZfgUTV84P8bfnn5kCZOtEtNec+9+2
         gHmZwuLCj5dKBqz6iyTkzR9t+8Al7ythlsNS2ZBXmtJWim8Bp9wbNi2/VdA+92XpiZ6K
         myH9vO77MuT3KIzi4TgG4lNiIXkv2BqiLxpL8ksqw9GrOIVc602hVceizUMe6eO/j9QZ
         YE3Iiz5MRocp5J1jsErDFsuqqpN3LcbMz+mOX9Ytx3+q27NdvBF7ezKE5FeuJSEDJ5TO
         SCnKGaC5m/q8pSeaL1au8t5ogD52UXI+gnrksHiMYZ+ZEmv8KVgMXFdsPgFsMYqbgPK/
         FHqA==
X-Gm-Message-State: APjAAAXH+HOcsv60+Qg8uCbjhpZTVk+FQVjxiHqdZ81k1799mJC2nfoL
        eF3RBkNy3h/ynhN+qnlpBigjb5vb
X-Google-Smtp-Source: APXvYqyavGc2iAtXSwKz/O72tGKIFmdClNd2vEn5xmfvGU2N5j3RxGFnjz33gPWC+ojWqd5JLcs8OQ==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr32907660wmb.118.1577715270381;
        Mon, 30 Dec 2019 06:14:30 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t8sm44532651wrp.69.2019.12.30.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 06:14:29 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2 0/5] Nested overlay tests
Date:   Mon, 30 Dec 2019 16:14:18 +0200
Message-Id: <20191230141423.31695-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu,

This v2 post includes two more nested overlay tests.

As described in previous post [1] the purpose of these tests
is not so much to validate the setup of nested overlayfs, which
is a less common setup, but to provide test coverage for some
overlayfs fixes that were merge in v5.5-rc2 as well as some fixes
that have been posted since.

Specifically, test overlay/071 exercises a "nested xino setup".
This setup results in "xino bit overlflow", a corner case that did
not have test coverage until now. This test fails on current upstream
because of an overlayfs bug [2].

On top of that, both overlay/070 and overlay/071 fail on current
upstream, because of a /proc/locks format bug [3].

Thanks,
Amir.

[1] https://lore.kernel.org/fstests/20191221185149.17509-1-amir73il@gmail.com/
[2] https://marc.info/?l=linux-unionfs&m=157708323410613&w=2
[3] https://lore.kernel.org/linux-fsdevel/e5d1c0a5e5e92083d8ce0bc1e48194a6d70fb918.camel@kernel.org/

Amir Goldstein (5):
  overlay: create the overlay/nested test group
  overlay: test file handles with nested overlay over samefs lower
  overlay: test file handles with nested overlay over non-samefs lower
  overlay: test constant ino with nested overlay over samefs lower
  overlay: test constant ino with nested overlay over non-samefs lower

 tests/overlay/068     | 304 ++++++++++++++++++++++++++++++++++++++++
 tests/overlay/068.out |  50 +++++++
 tests/overlay/069     | 313 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/069.out |  50 +++++++
 tests/overlay/070     | 222 ++++++++++++++++++++++++++++++
 tests/overlay/070.out |   2 +
 tests/overlay/071     | 236 +++++++++++++++++++++++++++++++
 tests/overlay/071.out |   2 +
 tests/overlay/group   |   8 +-
 9 files changed, 1185 insertions(+), 2 deletions(-)
 create mode 100755 tests/overlay/068
 create mode 100644 tests/overlay/068.out
 create mode 100755 tests/overlay/069
 create mode 100644 tests/overlay/069.out
 create mode 100755 tests/overlay/070
 create mode 100644 tests/overlay/070.out
 create mode 100755 tests/overlay/071
 create mode 100644 tests/overlay/071.out

-- 
2.17.1

