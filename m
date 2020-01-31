Return-Path: <SRS0=v13d=3U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E7BC2D0DB
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 21:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7255A20707
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 21:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgAaVES (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:04:18 -0500
Received: from trent.utfs.org ([94.185.90.103]:43452 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaVER (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 31 Jan 2020 16:04:17 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 16:04:17 EST
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 40D695FCBC
        for <fstests@vger.kernel.org>; Fri, 31 Jan 2020 21:55:47 +0100 (CET)
Date:   Fri, 31 Jan 2020 12:55:47 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     fstests@vger.kernel.org
Subject: shared/032: add options for reiser4
Message-ID: <alpine.DEB.2.22.395.2001311244100.2831@trent.utfs.org>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Last night I had xfstests running and after a while it hung at shared/032 
because I had reiser4progs installed and it was waiting for input:

-----------------------------------------------------------------
mkfs -t reiser4 /dev/ram0
mkfs.reiser4 1.2.1
Format release: 4.0.2
Copyright (C) 2001-2005 by Hans Reiser, licensing governed by 
reiser4progs/COPYING. 

Block size 4096 will be used.                                                                                                                                                                         
Linux 5.5.0-rc5-amd64 is detected.                                                                                                                                                                    
Uuid 2006a590-832a-49f5-9317-cf91bf866dd7 will be used.                                                                                                                                               
Reiser4 is going to be created on /dev/ram0.                                                                                                                                                          
(Yes/No): 
-----------------------------------------------------------------

The patch below adds an option (cf. reiserfs the line above) so that the 
test continues.

Curiously enough the test still "succeeds" for reiser{fs,4} (and jfs too) 
because the userspace tools don't appear to have a routine to check for 
"contains an existing filesystem", but that could be addressed in a 
different patch.

Signed-off-by: Christian Kujau <lists@nerdbynature.de>

--- tests/shared/032.orig	2020-01-12 08:43:34.000000000 -0800
+++ tests/shared/032	2020-01-31 12:30:27.158763104 -0800
@@ -49,6 +49,7 @@
 	[ $fs = gfs ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
 	[ $fs = gfs2 ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
 	[ $fs = reiserfs ] && preop="echo y |" && preargs="-f"
+	[ $fs = reiser4 ] && preop="echo y |" && preargs="-f"
 	# cramfs mkfs requires a directory argument
 	[ $fs = cramfs ] && preargs=/proc/fs
 	[ $fs = ext2 ] && preargs="-F"

-- 
BOFH excuse #164:

root rot
