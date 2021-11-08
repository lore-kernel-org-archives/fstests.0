Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC3C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE50661360
	for <linux-fstests@archiver.kernel.org>; Mon,  8 Nov 2021 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbhKHOwI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 09:52:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240636AbhKHOv6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 09:51:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 387BC21B09;
        Mon,  8 Nov 2021 14:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636382948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4nNd18yl8naLVwzgnRVAYekH8A4vA0NXERSLlBDV9Nc=;
        b=L+tWuzyfPBl9lBtgyAD0hV6SPf9F0vik8PH2qnev7P8a0IRz88pMWQWm8uw6uGwJsnG0Q8
        5RAlKhDsihakZUYcNi4fJpU1r1DJ0HH3Uqa1Gy+4NToBOUitEmXY9Cp/Si/v5BM6YgNoyR
        LG5Y0XwAOZcu0kkF37QqkeyLOvueMQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636382948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4nNd18yl8naLVwzgnRVAYekH8A4vA0NXERSLlBDV9Nc=;
        b=VqUCBrjEGJUTtvnkzu7Wa5eetxDhNCdDG39lkof2azWvpRBqk2eXjVA5NsmYo6Rrt2/Qd2
        LbUEjjv2RVlQ/FBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E350F13BA0;
        Mon,  8 Nov 2021 14:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ivi9NOM4iWFQMgAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 08 Nov 2021 14:49:07 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 62754ccf;
        Mon, 8 Nov 2021 14:49:07 +0000 (UTC)
From:   =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@suse.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        =?UTF-8?q?Lu=C3=ADs=20Henriques?= <lhenriques@suse.de>
Subject: [PATCH] generic/528: take fs timestamps granularity into account in tolerance interval
Date:   Mon,  8 Nov 2021 14:49:05 +0000
Message-Id: <20211108144905.11515-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Filesystems timestamps granularity can cause spurious test failures:

  QA output created by 528
  btime has value of 1635818936
  btime is NOT in range 1635818937 .. 1635818942

This test output makes it looks like $testfile was created *before* the
'date' command was executed.  What really happen was that btime was
truncated according to the granularity defined by filesystem (I've seen
this with both ext4 and xfs, but I guess others are also affected).

Since granularity can't be worse than a second, simply adjust the test
tolerance interval by 1 second.

Signed-off-by: Luís Henriques <lhenriques@suse.de>
---
 tests/generic/528 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/528 b/tests/generic/528
index 24d1ee0e5ec7..a63827b1139b 100755
--- a/tests/generic/528
+++ b/tests/generic/528
@@ -41,7 +41,7 @@ btime=$(date +%s -d "$($XFS_IO_PROG -c "statx -v -m $STATX_BTIME" $testfile | \
 	grep 'stat.btime =' | cut -d '=' -f 2)")
 test -n "$btime" || echo "error: did not see btime in output??"
 
-_within_tolerance "btime" "$btime" "$now" 0 5 -v
+_within_tolerance "btime" "$btime" "$now" 1 5 -v
 
 status=0
 exit
