Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA4C47082
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 21:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC0E60720
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Jun 2021 21:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFGVie (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Jun 2021 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGVie (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Jun 2021 17:38:34 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7DFC061574
        for <fstests@vger.kernel.org>; Mon,  7 Jun 2021 14:36:42 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id z13so5594423uai.12
        for <fstests@vger.kernel.org>; Mon, 07 Jun 2021 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJIj7uFu8kJv28ecCU2cRtYeZ3b52p1KV2TXq5NuG6g=;
        b=cBzsQKEmCspbP0O53O+y8VBS+rSh3v5NZVUAsby4A9cOJHVobz9WxH/ZySFSFpTWNV
         5Jaku0g7QTYXNlJy8rW0NOC0xCABdOlTtnKbVp9x/V5jt7EtFMYkbGlW9AqVEKKXbvZd
         LBdPwjKJwBQURKs3nO71eetFlt4mC6yx/LY3TfjLoIy+/jOrC/hwtf2qA57p+rhlEget
         cptDAqvogjOng2R+UOjNZqyLuSWRi1NxhmSQAyahNvI1RWvlaB+nMBwaF0q2mHnynGGo
         C+SdXYP1i03U12Wd/YY5+ADO4KiDegwyjXMTEBEAO5+6y8otKHRwh6aBvjnBQSceimdZ
         7rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aJIj7uFu8kJv28ecCU2cRtYeZ3b52p1KV2TXq5NuG6g=;
        b=DgAEL8RH3IPFv5pFwPk79ExvqyXnXJ9+kjf7RK3VyqzL6cbrvpuHpMtOwI9QwrfSlA
         n3U4k6bUaQkrXjAyWueaKAOgOaw8xHx8pImim6uYfgMxDSIAmyATrNdSAbN4F3etVSW+
         jeBPDCtsXhG/peraaQPNbDs3nf6hBwWnGxk93mhbQ+Nwj1r6r/C8cPK2boTzsFZg6AZg
         hYi7i7fOBpKxwNr6f6aS9Z74mLhQFIXFeLbff+TDi4AmpDjet3wpZ+6wvaXLIQ4BSTB1
         qmZu+8lWj8Ccwnswwy/IeVa0PGoMtmqDv/n3+HBur4j0vUpolwdjaaK2hnn3SbSo/ec5
         46Bw==
X-Gm-Message-State: AOAM532gNLwrG2qli0ieNTGKtYeyuoocfwgxLGBnc+siZ+31Cfj6U2BF
        9/xSr26wFswWkkp8cFhUL3olk7Oj631LvA==
X-Google-Smtp-Source: ABdhPJwEW+pyGqhzn8RqnT3oN4Pumczonm5WRr7Ll5bwEkrG1onEm68qm+5MxhG43h8aBsh/3G7VfQ==
X-Received: by 2002:ab0:3905:: with SMTP id b5mr10918365uaw.26.1623101800989;
        Mon, 07 Jun 2021 14:36:40 -0700 (PDT)
Received: from leah-cloudtop2.c.googlers.com.com (241.36.196.104.bc.googleusercontent.com. [104.196.36.241])
        by smtp.googlemail.com with ESMTPSA id u6sm2582333vku.0.2021.06.07.14.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 14:36:40 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     guaneryu@gmail.com, xuyang2018.jy@fujitsu.com,
        Leah Rumancik <lrumancik@google.com>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] ext4/048: add check for od endian flag
Date:   Mon,  7 Jun 2021 21:36:38 +0000
Message-Id: <20210607213638.3431530-1-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Leah Rumancik <lrumancik@google.com>

od --endian=little is used to read bytes in little endian when on a
big endian machine. Update test ext4/048 to require od endian flag
support on big endian machines, otherwise, skip test.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 common/rc      |  6 ++++++
 tests/ext4/048 | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a0aa7300..70aa7176 100644
--- a/common/rc
+++ b/common/rc
@@ -4582,6 +4582,12 @@ _getcap()
 	return ${PIPESTATUS[0]}
 }
 
+_require_od_endian_flag()
+{
+	od --endian=little < /dev/null > /dev/null 2>&1 || \
+		_notrun "od does not support endian flag"
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/ext4/048 b/tests/ext4/048
index 35d3ece8..51189618 100755
--- a/tests/ext4/048
+++ b/tests/ext4/048
@@ -26,6 +26,11 @@ _supported_fs ext4
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
+big_endian=$(echo -ne '\x11' | od -tx2 | head -1 | cut -f2 -d' ' | cut -c1)
+if (( big_endian )); then
+	_require_od_endian_flag
+fi
+
 testdir="${SCRATCH_MNT}/testdir"
 
 # get block number filename's dir ent
@@ -44,7 +49,13 @@ get_offset() {
 # argument 1: block
 # argument 2: offset
 get_reclen() {
-	echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An  --endian=little | tr -d ' \t\n\r')
+	if (( big_endian )); then
+		echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An  --endian=little | \
+			tr -d ' \t\n\r')
+	else
+		echo $(od $SCRATCH_DEV --skip-bytes=$(($1 * $blocksize + $2 + 4)) --read-bytes=2  -d -An | \
+			tr -d ' \t\n\r')
+	fi
 }
 
 # reads portion of dirent that should be zero'd out (starting at offset of name_len = 6)
-- 
2.32.0.rc1.229.g3e70b5a671-goog

