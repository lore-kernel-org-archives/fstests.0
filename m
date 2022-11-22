Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C7C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Nov 2022 14:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiKVOMb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Nov 2022 09:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiKVOM3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Nov 2022 09:12:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA1E14
        for <fstests@vger.kernel.org>; Tue, 22 Nov 2022 06:12:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 383A2220C6;
        Tue, 22 Nov 2022 14:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669126346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XZCpPIrugmBfY4CQ09tu/Vb10bpYWjWyexshb4ilYBs=;
        b=jvzEImfXp1r+baa401YOTvDFxa+BRExDbzgWy2lMydUa+iVKE5hbKTpPdmsifJH0rO1zxX
        epUbxd2N825Zd0qDXjmg0kbkRo/3NWayU60uR1jHpOYtC80MpFQ4CAecJ3QumAhzG8RJ5g
        nZVwgA+8yy7vd6lGyUoxgjJRRx8pvgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669126346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XZCpPIrugmBfY4CQ09tu/Vb10bpYWjWyexshb4ilYBs=;
        b=pTS3ugJuYexuy1wxmwVDfe7o+XEI35TjosQzXs3oobg7JYS2TdeLLw7MmTTf1q9yiCcU0U
        Suaf0DJbb8k1cwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29BA713AA1;
        Tue, 22 Nov 2022 14:12:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 74InCsrYfGMaaQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 22 Nov 2022 14:12:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E201A070E; Tue, 22 Nov 2022 15:12:25 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Filipe Manana <fdmanana@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] generic/614: Run test only for filesystems supporting delalloc
Date:   Tue, 22 Nov 2022 15:12:19 +0100
Message-Id: <20221122141219.20325-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Simple filesystems such as ext2 or udf do not support delayed
allocation. Thus they allocate data blocks for mmap writes only during
writeback. This makes test generic/614 fail because it checks exactly
whether the blocks for the write are reserved before writeback happens.
Make the test depend on delayed allocation support.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/614 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/614 b/tests/generic/614
index 06630f2249c7..3e2a587c8f90 100755
--- a/tests/generic/614
+++ b/tests/generic/614
@@ -16,6 +16,7 @@ _begin_fstest auto quick rw
 # real QA test starts here
 _supported_fs generic
 _require_scratch
+_require_scratch_delalloc
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-- 
2.35.3

