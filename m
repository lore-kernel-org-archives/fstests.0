Return-Path: <SRS0=jPGN=Z7=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE27C04E30
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Dec 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81C2080D
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Dec 2019 17:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIRO4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:14:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbfLIRO4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Dec 2019 12:14:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB446ABF4;
        Mon,  9 Dec 2019 17:14:54 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Eryu Guan <guaneryu@gmail.com>, Omar Sandoval <osandov@osandov.com>
Cc:     fstests@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] generic/590: add _require_xfs_io_command "falloc"
Date:   Mon,  9 Dec 2019 17:14:52 +0000
Message-Id: <20191209171452.16170-1-lhenriques@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Without this check the test will fail with message:

  fallocate: Operation not supported

Instead, with this _require_xfs_io_command, the test will be skipped
instead if falloc isn't supported.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 tests/generic/590 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/590 b/tests/generic/590
index 80a665c6b001..2670fe99d21f 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -34,6 +34,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch_nocheck
+_require_xfs_io_command "falloc"
 
 maxextlen=$((0x1fffff))
 bs=4096
