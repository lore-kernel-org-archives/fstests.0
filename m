Return-Path: <SRS0=YaBu=ZK=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B2C432C0
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Nov 2019 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3BC2186D
	for <linux-fstests@archiver.kernel.org>; Mon, 18 Nov 2019 17:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPIO81FO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRRlZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:41:25 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34995 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbfKRRlZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Nov 2019 12:41:25 -0500
Received: by mail-qv1-f66.google.com with SMTP id y18so6901382qve.2
        for <fstests@vger.kernel.org>; Mon, 18 Nov 2019 09:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9kihoHmI1QsTVMJS2aIPNdr4NDjbxH9mKnkcDL0U+7U=;
        b=UPIO81FO8wJkMcjbt6lVkJ/rSyAoCRM5og8crlDNRB6kVvVcb/r1JtFxJ8BGnxhq6f
         Ohdv4AFcrdeAHi5GjOUx+9/naKHXblntcr2H5Ne2Mf1I1eHVOd4NnVHr/kiFHNJ8jj+C
         iYALoN8WZ1tF926MQzKvMjK0nv5e4NrLN96w1U+iWt1FvRKOx+/01XDJr1MA95iCOe1T
         GC5l4RSXa2dsdhxVVJkKiPyP3s6fsGCMujdDobeOelOuvcEcjHEqrD/9WE/qjOF8wrky
         mj1gqJwJOxXjfonILdu/2PKuUg67Gx74y07UDbKdBdYsFebmXEh+1rkRO7IJUW9Unxjd
         yrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kihoHmI1QsTVMJS2aIPNdr4NDjbxH9mKnkcDL0U+7U=;
        b=jLuyI4tDUlQt6g14EJF2GL0jJRNQRHahsTGVvovIRxQaauedKJgMzDPnDWOZw56592
         DJeOTXF3FFMvbcE99udFkQKlnhOzJn0fcPqQoOvQ30uuL34IBcTQL5cdMr2nvwoR7x4D
         BKnx5Ba1dlaG/WUATQcK9/DJD005c79fhnllCWLDnimd2h8hwcHPWxnCJrO+dWIU+gTQ
         TeFQeeRzQOzqaM8EWyPEGdsjCSRSS9mA26UfY/+Jdrb7h0yc0k6CAfSiD3abnrTtYW5b
         plPV4F3bFQuZ4BxyLr4PhrQatT9E0eP7xhSKxZo+FscDKGPlla0GRzoEiePhAbuQufm0
         fpKg==
X-Gm-Message-State: APjAAAWJEY8xr4LcvnpUKe+KQklm49bYlw53a55V4y0La0rq8lnzjgjP
        5dI5aRqYYZ29VsTICnsKh6dy7ao=
X-Google-Smtp-Source: APXvYqwUSBzGNzrJ5IOu8XfjsGSn2mYtny/lKxKCE9EV4zhIJ2inrhZVIRisgiBBSV8tO0fuYct4Lg==
X-Received: by 2002:a05:6214:852:: with SMTP id dg18mr6489265qvb.8.1574098883970;
        Mon, 18 Nov 2019 09:41:23 -0800 (PST)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q8sm11051438qta.31.2019.11.18.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:41:23 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH] generic/551: Adjust the size argument for aio-dio-write-verify
Date:   Mon, 18 Nov 2019 12:40:37 -0500
Message-Id: <20191118174037.363-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

generic/551 sometimes fails because it's killed by OOM killer.
That is because aio-dio-write-verify, which is called by
generic/551, tries to allocate memory even though the total
allocation size exceeds the available memory.

aio-dio-write-verify allocates memory according to the 'size'
argument, and generic/551 passes the argument.

Stop adding the argument when the total size is exceeds
the available memory.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 common/rc         | 11 +++++++++++
 tests/generic/551 |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/common/rc b/common/rc
index b988e912..3494426e 100644
--- a/common/rc
+++ b/common/rc
@@ -910,6 +910,17 @@ _free_memory_bytes()
     free -b | grep ^Mem | awk '{print $4}'
 }
 
+_available_memory_bytes()
+{
+    nf=`free -b | grep ^Mem | awk '{print NF}'`
+    if [[ nf -lt 7 ]]; then
+        # Doesn't have available field. Fallback.
+        _free_memory_bytes
+    else
+        free -b | grep ^Mem | awk '{print $7}'
+    fi
+}
+
 # Create fs of certain size on scratch device
 # _scratch_mkfs_sized <size in bytes> [optional blocksize]
 _scratch_mkfs_sized()
diff --git a/tests/generic/551 b/tests/generic/551
index a2a5b51d..a0dc9cd7 100755
--- a/tests/generic/551
+++ b/tests/generic/551
@@ -55,12 +55,18 @@ do_test()
 	local size
 	local off
 	local truncsize
+	local total_size=0
+	local avail_mem=`_available_memory_bytes`
 
 	# the number of AIO write operation
 	num_oper=$((RANDOM % 64 + 1))
 
 	for ((i=0; i<num_oper; i++)); do
 		size=$(((RANDOM % max_io_size_b + 1) * diosize))
+		total_size=$((total_size + size*2))
+		if [[ $total_size -ge $avail_mem ]]; then
+			break
+		fi
 		off=$((RANDOM % max_io_size_b * diosize))
 		oper_list="$oper_list -a size=$size,off=$off"
 	done
-- 
2.18.1

