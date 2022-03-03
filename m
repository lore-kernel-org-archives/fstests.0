Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE07C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Mar 2022 13:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiCCN3l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCCN3l (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Mar 2022 08:29:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD1E2354
        for <fstests@vger.kernel.org>; Thu,  3 Mar 2022 05:28:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2D581F381;
        Thu,  3 Mar 2022 13:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646314134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlvQb7f2nsLEwBZX5OKqJLtYO2PA3OU5FinDnfz7s80=;
        b=HmFH8oa875W93fOuWvQtwlrCvghukuF+M9qQPWMpQafgQkGQE29AI+gLNokNifZkAnEaVU
        WJdQW4e5CwuEM7Ay4Bdl3XoZB5hVypbgirM+fKsViHdYniTT5vMZKP5CpESjpYP0sGkkyW
        EkPZ83AGshmwQWYcC8pbylkAA4Ola7c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C5C613C23;
        Thu,  3 Mar 2022 13:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YE2BHJbCIGKHWwAAMHmgww
        (envelope-from <gniebler@suse.com>); Thu, 03 Mar 2022 13:28:54 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     fstests@vger.kernel.org
Cc:     Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH 3/4] README: Add command to install required packages on SUSE
Date:   Thu,  3 Mar 2022 14:28:03 +0100
Message-Id: <20220303132804.4151-4-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303132804.4151-1-gniebler@suse.com>
References: <20220303132804.4151-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The README already listed how to install the required packages on other popular
distributions. Since a lot of filesystem development happens on SUSE systems and
both the command as well as the list of packages are slightly different, it only
made sense to include these.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 README | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/README b/README
index 65e7ed7b..657fb2f6 100644
--- a/README
+++ b/README
@@ -18,6 +18,11 @@ _______________________
 	libcap-devel
 	(Older distributions may require xfsprogs-qa-devel as well.)
 	(Note that for RHEL and CentOS, you may need the EPEL repo.)
+  For openSUSE or SUSE Linux Enterprise:
+	sudo zypper install acct automake bc dbench duperemove dump fio \
+	gcc indent libacl-devel libaio-devel libattr-devel libbtrfs-devel \
+	libcap libcap-devel libtool liburing-devel libuuid-devel lvm2 make \
+	quota sqlite3 xfsdump xfsprogs xfsprogs-devel
 - run make
 - run make install
 - create fsgqa test user ("sudo useradd -m fsgqa")
-- 
2.35.1

