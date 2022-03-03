Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA74C433F5
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 13:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiCCN3e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCCN3e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 08:29:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069CE02DF
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 05:28:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C859C218D6;
        Thu,  3 Mar 2022 13:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646314126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVK6xaA/sQMCtITVqdjobGoSXukW26GtWNWRpoZRMqo=;
        b=LWOJcZ71yQdNC4Fzx3wRe0TWV9oFJeqnW5y/lxdG+l5hv+z6ICRpbdJtW3eJQqn5jL4+/H
        i/0ybZBWJkbEx6Cn5XuYf93GoAq6e7b9kHMVPiLL6IAVdvOvpJ0c+cgp+V+/NaWtKlYGUv
        j7xQFF7wlNvfpjdmtmO5bIpMbJSmyI8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A38DB13C23;
        Thu,  3 Mar 2022 13:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YDpdJo7CIGKHWwAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 03 Mar 2022 13:28:46 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 1/4] README: Fix environment setup quick start
Date:   Thu,  3 Mar 2022 14:28:01 +0100
Message-Id: <20220303132804.4151-2-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303132804.4151-1-gniebler@suse.com>
References: <20220303132804.4151-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Following the old quick start information would not get a new user to run
tests with their configuration, because it was not accurate to how the check
script actually works.

By default, the script looks for *.config files in HOST_CONFIG_DIR, which
defaults to '.config' if unset. The README now reflects that.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 9f01aa10..7e36905e 100644
--- a/README
+++ b/README
@@ -61,8 +61,10 @@ Preparing system for tests:
 
     - setup your environment
 	Quick start:
-	- copy local.config.example to local.config and edit as needed
-	Or:
+        - set HOST_CONFIG_DIR to a path of your choice (ideally outside the git tree)
+        - copy configs/localhost.config there and edit as needed
+        - also consult local.config.example for inspiration
+	These are the most important environment variables you may want to set there:
         - setenv TEST_DEV "device containing TEST PARTITION"
         - setenv TEST_DIR "mount point of TEST PARTITION"
 	- optionally:
-- 
2.35.1

