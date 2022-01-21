Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410DC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Jan 2022 13:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350803AbiAUN6P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:58:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350790AbiAUN6O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Jan 2022 08:58:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B3563212C3
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642773493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RN+14cLaEn3mOWqb7y/ohXTfi+WI3Yww7NgsIXxDJxc=;
        b=tK560GkZ+JCiAkDhiRCzppjB0oEFcOHk93O+pCTcluwQVqMDtPoNv/bdXou8DhR4P7U797
        Ld/xQ4+tgv/rPh4KE83+XntFsGK7vUkV+18uQGvKL3Th1qW8UIjyG0wvWyR5n/QBiOUuPb
        AtOTpGQfOzF02gIi7Rwmot3mHS+BIcA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A867413941
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aN/VKPW76mFRWAAAMHmgww
        (envelope-from <ailiop@suse.com>)
        for <fstests@vger.kernel.org>; Fri, 21 Jan 2022 13:58:13 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/dump: add explicit requirement for specific users and groups
Date:   Fri, 21 Jan 2022 14:58:02 +0100
Message-Id: <20220121135802.9251-2-ailiop@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make the requirement for daemon:sys and bin:bin explicit, so that the
xfs tests that source common/dump and rely on _do_create_dumpdir_fill
and _create_dumpdir_symlinks do not fail on chown when those
users/groups are missing.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 common/dump | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/dump b/common/dump
index 3c4029ff1f37..ea16d442cb4f 100644
--- a/common/dump
+++ b/common/dump
@@ -27,6 +27,11 @@ fi
 [ "$XFSRESTORE_PROG" = "" ] && _notrun "xfsrestore not found"
 [ "$XFSINVUTIL_PROG" = "" ] && _notrun "xfsinvutil not found"
 
+_require_user_exists daemon
+_require_user_exists bin
+_require_group bin
+_require_group sys
+
 # status returned for not run tests
 NOTRUNSTS=2
 
-- 
2.34.1

