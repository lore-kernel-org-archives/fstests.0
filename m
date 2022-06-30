Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05062C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiF3Oqt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiF3Oqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900D1C90D
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkeUA005678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600402; bh=z9Fw7MNJriX6yITdhWlqeExe4BF1WfQkL4Fa/IoV6tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JbhBwqVyyIiv5M61SIUMbGqj5EcqjIVE8DSCFnCq2SU9AtsKXHNPWIEAUZZmHgOFU
         /cGK4he5RPD6GDjK12mcTu3z+ZZWLJUL0vCkwOE+THqhniZyVlFnnci6Qio2X48TpG
         87YZe4nNlAkNW0mrtNjKMvVFZXxJnDVvrjtjxLq6QTehJy1mdm+REbKjI2iw6jZU4Y
         S+3k8tJ5VvPoUXkR1ZuM5vQvNoe/HV8oeOEIizWhP+xDGrIkBDvl+Lk90mHdlozUAo
         vs7s4i3tEeTcXP40vSoZ4SMDf7k6v1VDHPT4QiUqeAFh/MddDjhKKX1jruksmPM2SZ
         RWt7A11JhPhvw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4ED0015C4331; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 6/7] ext4/035: skip this test if the scratch device does not support 1k block sizes
Date:   Thu, 30 Jun 2022 10:46:36 -0400
Message-Id: <20220630144637.478568-7-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tests/ext4/035 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/ext4/035 b/tests/ext4/035
index cad3595b..1f26e766 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -26,6 +26,9 @@ _exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
 
 $MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+    _notrun "Can't make file system with a block size of 1024"
+fi
 _scratch_mount
 
 echo "Resizing to 262145 blocks"
-- 
2.31.0

