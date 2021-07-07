Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E3DC07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 05:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFBB61C99
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 05:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGGFE0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 01:04:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44190 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhGGFEZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 01:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625634106; x=1657170106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WbnlAEs5PBwtXZZCvIv+HdhPrCQgX4hIFA0kQ/K0xJw=;
  b=QSk6kj+qSwJEoAYIJuEKMCBJse2Ub0Gs3MX+WsN8dq4KhTLFKUF0WLOO
   22Ge0MaR/arw0Fw1xRj9CVb8JHMJcn78hyr7uDQU64EnnO5XaeAWvY18Z
   Xd5no+x5ComKtzNIoezO9yKCqd/MljU/RGG8Zo2d61LwXQa7tRMdp8H0Z
   TSaRYx/wWexpb5x1TyBEV8Xd725JGwjed/+TLQpeXKGUxilKEwdluF0TX
   /e/0gnKft/rTqtAAJWQT0BBxgoA/OA0h8Smlib1DV42va3wvhj3foHOZt
   aDcAyFJbJ5936wjp2IYjfFSYaX1W3cfqC92IGWPDXFNJGVLj5wARV668r
   A==;
IronPort-SDR: LcYhS6dZwzwGvrkFcycqiMlFGBin6OokDkvDArBrq6o1Z+hNFzNn9jb8vyPHeYNknjX1vLRfer
 y73AwL5d/Wj+XuysQjOuD3YqJPsfmuw46YGrwrYySqVFeATEUviylpl6UQMp44y3E2XhmxCSW8
 CdwDdNpazTSkCya5edn3Gtmhs7GEKORrhwYxDrTP+pwA4TZ1foZe1CSTOD7GyEyTyhazbtitMg
 eykAj/lirAs9pf6nrx5hRqKzzwXIJmn/arD+goHk1qowDbVv7av0Pog9lNygpbyCwNSaFk5YZ3
 K3k=
X-IronPort-AV: E=Sophos;i="5.83,330,1616428800"; 
   d="scan'208";a="173140197"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 13:01:46 +0800
IronPort-SDR: 1uTSRLfTI5K2CVBFkPS4BVIYlT+1YBkudYyAKaxOVGPAJK+fUfcjil+coD58olMa+Ll2vI1krU
 Hhe2LTKRxJCgg3ITVnSeuoQAUhFhTOtlU8JiyeI1ERkJljie/EYQ41IdYEJKbwZy2ajLEA9eg1
 7+mK+zETnNfBrZ56UUOkFKGMdRBBC+JUffhBG1RCaQVaeqtYYTvc3uoNwdBx2cQMYIaCgne3Gg
 M8Xz9CUAyPVXGqMVO20XlSjrUL+fSOfr6IK2VL1tI/XOyy+FSyJutdYdo9jXWhzxeHLzrb1MV5
 sume4N7QL0NQ5/CwnDlxiRIl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 21:38:46 -0700
IronPort-SDR: mglFyowNDwu62i1ELQy+azoHq2VdsKMkYzLdM4lGIZffi8cYf2GGh6oEgusaAsEY9k5dp5I92d
 Q5/RZTWVp0rYN9uInsv8gFMt8teXVdOlRk9mKR+yh3nzb7mvv4RYJFjpq4L5vvg0v+MGkNFSeN
 +AWlJR8NajHLY5V8xA3VyW1zcmpaUes7OPt+5fzz8DgXn4WBSvaDIGIgKJsd0UzyjXLicZ+FDU
 e/qN6KnnqhQUIMbMnOPN+2SoGINopli30JWFtG+GfTRQAkgSOXf+gd++/FP+Feon1rnWLWo8VW
 PT4=
WDCIronportException: Internal
Received: from usa005022.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.75])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2021 22:01:45 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] fstests: install btrfs_crc32c_forged_name.py
Date:   Wed,  7 Jul 2021 14:01:41 +0900
Message-Id: <20210707050141.1817531-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs/154 uses btrfs_crc32c_forged_name.py but the file is not installed in
the PKG_LIB_DIR. Also consolidate install target files into EXTRA_EXECS.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 src/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 5c76aa93db5c..884bd86a03f2 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -33,6 +33,9 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation
 
+EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
+	      btrfs_crc32c_forged_name.py
+
 SUBDIRS = log-writes perf
 
 LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt
@@ -100,7 +103,7 @@ LINKTEST = $(LTLINK) $@.c -o $@ $(CFLAGS) $(LDFLAGS)
 install: default $(addsuffix -install,$(SUBDIRS))
 	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src
 	$(LTINSTALL) -m 755 $(LDIRT) $(PKG_LIB_DIR)/src
-	$(LTINSTALL) -m 755 dmerror fill2attr fill2fs fill2fs_check scaleread.sh $(PKG_LIB_DIR)/src
+	$(LTINSTALL) -m 755 $(EXTRA_EXECS) $(PKG_LIB_DIR)/src
 	$(LTINSTALL) -m 644 dumpfile $(PKG_LIB_DIR)/src
 
 %-install:
-- 
2.32.0

