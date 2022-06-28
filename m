Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B16C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiF1SZ6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiF1SZz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:25:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30352125C
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:25:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SIPoD6025938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440752; bh=NDZVyZ5gvfyrcqKY2Brg3MnGgp5+uwqYZsM4M2WU+xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Qo2k4YgALuqs21bZkVDwrxU4zdRD9JpwVxLJ1gZdiPHKW7eWEudhtvn3lr1TDbQa4
         NLW1Fc3ph52JNJm3GgUl/G/u5fLU871EyIyKo2b2QCVozuWbSUoHARJdRdmlmKdMS0
         N8+fTygd7ev5wH60LF3U+ZAP4fpTND1BlP7xOyNg4UqITqU6a9hssnlHawJX/2yEzd
         vk9b2FIhgoJK5x0mRU2//Y1QutAmIwA0VhLH8FndxjXuKkw+/ZsiAUtsE0Q10puL/w
         5MarnuksjltMooDxbuk910sz4vhDn2MFg81lZKVoutoZP3dgwvIDRQZPIRVqVZhdCn
         ekb68Tg08Nihw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8380C15C4318; Tue, 28 Jun 2022 14:25:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 5/6] ext4/055: skip test if dax mount option is used
Date:   Tue, 28 Jun 2022 14:25:44 -0400
Message-Id: <20220628182545.1834145-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220628182545.1834145-1-tytso@mit.edu>
References: <20220628182545.1834145-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test creates a 1k block file system with the quota feature
enabled.   As such, it is incompatible with DAX.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/055 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/055 b/tests/ext4/055
index 8f466f1b..aa15cfe9 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -26,6 +26,7 @@ _require_command "$DEBUGFS_PROG" debugfs
 echo "Silence is golden"
 
 # The 1K blocksize is designed for debugfs.
+_exclude_scratch_mount_option dax
 _scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
 
 # Start from 0, fill block 1 with 6，replace the original 2.
-- 
2.31.0

