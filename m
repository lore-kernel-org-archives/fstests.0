Return-Path: <SRS0=h6Hu=7Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9AFC433DF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D160206DC
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Jun 2020 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JRuTttFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgFKQPG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:15:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgFKQPF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jun 2020 12:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591892104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=UO81qcVjRL0d/jpEvhVFYmi6RxKRKj0E1xAmbfotjkY=;
        b=JRuTttFQ4fSOx2eEmwx9DDhpcDMvW+KES8OwJDMNBLwzgDqZSifs0OuidkTeydM0OkRBvV
        txy4gP7WaPmY/9FCzJtZfgNEkRO+nnDBnmNBoC0STfMCZK54UAOWY5N+4gvJv9ldykAMYE
        5x6gP/nE+0mmTaUhDCXr6LgieqgoE8k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-YD-6rCsqPTepzZrFCtDYTA-1; Thu, 11 Jun 2020 12:15:01 -0400
X-MC-Unique: YD-6rCsqPTepzZrFCtDYTA-1
Received: by mail-pg1-f199.google.com with SMTP id k16so4213971pgg.7
        for <fstests@vger.kernel.org>; Thu, 11 Jun 2020 09:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UO81qcVjRL0d/jpEvhVFYmi6RxKRKj0E1xAmbfotjkY=;
        b=lUQj1WgFmTKX1a3/gSgh/hMF3Hy2km3boLeaxyHpM29c14heIIrR6dxRP/WqSHnTmw
         UObVH568iwjtKRUMxYDRZxKpzVqv9nQ5w1jZjGMQoTDKCk7XGlIvC5uCsvDpFMXyvYw+
         lvRr9+mYXzSn6vosOVcXef0hJsskyHDq3mUtNr39PXcrAEjWmFOYbjqBpbFVn2rt423s
         /gL1V5MQCxkvmIRmXELwK2PP753Hfo78XHytFimEiruhzcAnPMZAyMd92vfKgKLPOXRP
         i1YCu6DN38tFEU0hFsguigwib0DOF5eeJbGQI8qGUDmfwR4iP8dCwyhLPzKAQnb/dgOY
         pjyw==
X-Gm-Message-State: AOAM531bbVW2evn6tRqXWloUMKQarbfCsvUkp90xDIlc0PxfM2AczLtm
        pXt6aRHAmiiUtqR0ab9399XgfQ3VeZCBeVxgwFW7cK+mDzW9rjBU7huC3Y/dRLp3AGcNGs8UHpF
        asQCAdRFVtBkDQaAYvA==
X-Received: by 2002:a62:d158:: with SMTP id t24mr7786153pfl.267.1591892099989;
        Thu, 11 Jun 2020 09:14:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdDHhrBsYtTT4rmcsBiowmogFTbTzTgS1BcY2c6jKW62XEJX1Sy3U7/NCw/YcWfKVRhYpJ3g==
X-Received: by 2002:a62:d158:: with SMTP id t24mr7786131pfl.267.1591892099687;
        Thu, 11 Jun 2020 09:14:59 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r24sm3009290pgm.25.2020.06.11.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 09:14:59 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] common/fuzzy: try to clear immutable flag first in _scratch_fuzz_modify
Date:   Fri, 12 Jun 2020 00:14:17 +0800
Message-Id: <20200611161417.14685-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When stressing xfs/083, I found it sometimes fails as the following:

+++ touch 50000 files
setfattr: /home/fsgqa/scratchmnt/INOBT/20627: Operation not permitted
./common/fuzzy: line 18: /home/fsgqa/scratchmnt/INOBT/20627: Operation not permitted
mv: cannot move '/home/fsgqa/scratchmnt/INOBT/20627' to '/home/fsgqa/scratchmnt/INOBT/20627.longer': Operation not permitted
...
xfs_repair did not fix everything

It's simply that INOBT/20627 was an immutable file generated from
fuzzing. Therefore, this patch tries to clear the flag first before
modification. Note that it clears dax flag as well since it prevents
immutable flag from clearing.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 common/fuzzy | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/fuzzy b/common/fuzzy
index 988203b1..3e4f750b 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -14,6 +14,8 @@ _scratch_fuzz_modify() {
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 0 ${blk_sz}" "/tmp/afile" > /dev/null
 	date="$(date)"
 	find "${SCRATCH_MNT}/" -type f 2> /dev/null | head -n "${nr}" | while read f; do
+		# try to remove immutable (and even dax) flag if exists
+		$XFS_IO_PROG -rc 'chattr -x -i' "$f" > /dev/null 2>&1
 		setfattr -n "user.date" -v "${date}" "$f"
 		cat "/tmp/afile" >> "$f"
 		mv "$f" "$f.longer"
-- 
2.18.1

