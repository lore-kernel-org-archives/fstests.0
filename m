Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C2C1747C
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313E221D7C
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbfKENn1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:43:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:35924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388615AbfKENn1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Nov 2019 08:43:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BA4CB2DC
        for <fstests@vger.kernel.org>; Tue,  5 Nov 2019 13:43:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02A621E47E5; Tue,  5 Nov 2019 14:43:25 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH] common/quota: Fix _qmount_options
Date:   Tue,  5 Nov 2019 14:43:20 +0100
Message-Id: <20191105134320.26026-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

_qmount_options didn't properly substitute usrjquota and grpjquota
options. Fix the regular expression.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/quota | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/quota b/common/quota
index 6d1948bf357e..4e07fef15697 100644
--- a/common/quota
+++ b/common/quota
@@ -229,10 +229,10 @@ _qmount_option()
 	export MOUNT_OPTIONS=`echo $MOUNT_OPTIONS \
 	| sed   -e 's/uquota/QUOTA/g'      \
 		-e 's/usrquota/QUOTA/g'    \
-		-e 's/usrjquota=[^, ]/QUOTA/g' \
+		-e 's/usrjquota=[^, ]*/QUOTA/g' \
 		-e 's/gquota/QUOTA/g'      \
 		-e 's/grpquota/QUOTA/g'    \
-		-e 's/grpjquota=[^, ]/QUOTA/g' \
+		-e 's/grpjquota=[^, ]*/QUOTA/g' \
 		-e 's/\bpquota/QUOTA/g'    \
 		-e 's/prjquota/QUOTA/g'    \
 		-e 's/quota/QUOTA/g'       \
-- 
2.16.4

