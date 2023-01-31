Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A536BC38142
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 12:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAaMjb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAaMja (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 07:39:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9C3AA9
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 04:39:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49E7F22738;
        Tue, 31 Jan 2023 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675168768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=887p3gbFqLZwGvFZkGudwUph/fUdLIcI/5pIao2ravc=;
        b=mIOMkp4Sp+A/R+A9b/WtZOTltMT5rIoyMmDsUx7WIf16yr845D4qKRHptK+jmNWTkV17Um
        ol+Uz5GA9gsM3mL90TfWu/iP4dVCiN7bZuwQgRfNWXwR57e2HMl1X04TF1hwKIT/cSQzFu
        qeJs7czSwR8WGNfQOkykMplVpHzMaO8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2902C13585;
        Tue, 31 Jan 2023 12:39:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iBd2CAAM2WPxEAAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 31 Jan 2023 12:39:28 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 1/2] README: Add section to install required packages on (open)SUSE
Date:   Tue, 31 Jan 2023 13:38:38 +0100
Message-Id: <20230131123839.16084-2-gniebler@suse.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230131123839.16084-1-gniebler@suse.com>
References: <20230131123839.16084-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The README already lists how to install the required packages on other popular
distributions. Since a lot of filesystem development happens on SUSE systems and
both the commands as well as the list of packages are slightly different,
it only makes sense to include these as well.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/README b/README
index 4c4f22f8..008d3875 100644
--- a/README
+++ b/README
@@ -77,6 +77,26 @@ RHEL or CentOS
     For OverlayFS build and install:
      - see https://github.com/hisilicon/overlayfs-progs
 
+SUSE Linux Enterprise or openSUSE
+---------------------------------
+
+1. Install all necessary packages from standard repositories:
+
+   $ sudo zypper install acct automake bc dbench duperemove dump fio gcc git \
+        indent libacl-devel libaio-devel libattr-devel libcap libcap-devel \
+        libtool liburing-devel libuuid-devel lvm2 make quota sqlite3 xfsprogs
+
+2. Install packages for the filesystem(s) being tested:
+
+    For btrfs install:
+     $ sudo zypper install btrfsprogs libbtrfs-devel
+
+    For XFS install:
+     $ sudo zypper install xfsdump xfsprogs-devel
+
+    For OverlayFS build and install:
+     - see https://github.com/hisilicon/overlayfs-progs
+
 Build and install test, libs and utils
 --------------------------------------
 
-- 
2.39.1

