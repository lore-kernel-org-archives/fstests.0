Return-Path: <SRS0=NbcK=7Z=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574FCC433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 01:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235AE20884
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Jun 2020 01:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnr1GDLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLBlp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Jun 2020 21:41:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51810 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgFLBlp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Jun 2020 21:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591926103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=wUDNIjGO9qWGExeJVH38W/Mtq/Jp1JwPfSSqiRHf2Ks=;
        b=dnr1GDLDchtkpCK5Bl0nxxwkGk2+4ql7M0eCOmbWZSgUaps4MRDYnXUkacneug9gc3KLYp
        rIRHS5lnMBFGY9XkMIy55gutao3cMsSRC5ktKHTdg1z/rgzh4dQhOm8G5G7tAIIOa46ez8
        u1WaINUEAy2ZyIVdx5993XITonHWhrk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-XcAeiZn0Paybr8TTN0a19Q-1; Thu, 11 Jun 2020 21:41:39 -0400
X-MC-Unique: XcAeiZn0Paybr8TTN0a19Q-1
Received: by mail-pl1-f199.google.com with SMTP id o1so5080706plk.22
        for <fstests@vger.kernel.org>; Thu, 11 Jun 2020 18:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wUDNIjGO9qWGExeJVH38W/Mtq/Jp1JwPfSSqiRHf2Ks=;
        b=t0IBZvm09fcfe9YBJA4mg5d5icPTr5Ev+RrpR0fkAqk57fBPFItphY01FGkWDRtOHe
         6R+kGrX4VJsOHjbXQOz1bSWgRqkYDysyIxivBRhiejHkdhq8yLlXvjJb+yaHdd0XIJt5
         UqPYyQtVWtjgRC8jQipwJB9HLtqX85pnTSsFjhjiax9CJMCaxpO8OyOWRWofCAzdBMgt
         TJlJybkQnVG5nPO7FCrOUY9KLDeaJi8B86gQBHA0FJcox8XN8feQBfBOR3Z4CtGqMn2d
         B1eGN9vkMXWVGGutWRE2skqb5iRljRaPAdUHfBtcQG4p7xw7LGfENC6ZhxhAUPsS7Tik
         kZaw==
X-Gm-Message-State: AOAM530zxtlq0qKXYkQDTHHLesLK0xyXqzm6qjg0kLCaCEGSc54bSWO5
        a0A5bW89smdaGnbEGBcjhad0mKIlIHmTcy+kMMYIL15lA6byMfTNWhvGDxKwH3d5MvZKdLbQd/w
        CZHOpyXEPMC/GLBmxwA==
X-Received: by 2002:a62:25c5:: with SMTP id l188mr9687196pfl.178.1591926098548;
        Thu, 11 Jun 2020 18:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN84VeRVTi0AvqYcB0iB8eZzJpZnaxhQ2JZz6z9zSfQzSug5ef03UQZp/EF7+l3glgU8HOfQ==
X-Received: by 2002:a62:25c5:: with SMTP id l188mr9687182pfl.178.1591926098164;
        Thu, 11 Jun 2020 18:41:38 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l3sm3724950pju.43.2020.06.11.18.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 18:41:37 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2] common/fuzzy: try to clear blocking flags first in _scratch_fuzz_modify
Date:   Fri, 12 Jun 2020 09:40:18 +0800
Message-Id: <20200612014018.13807-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200611161417.14685-1-hsiangkao@redhat.com>
References: <20200611161417.14685-1-hsiangkao@redhat.com>
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
fuzzing. Therefore, this patch tries to clear append, immutable flag
first before modification. Note that it clears dax flag as well
since it prevents immutable flag from clearing.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v1:
 - also clear append-only flag (I think that's better than just
   skip since maybe some potential errors exist on these files.)

 common/fuzzy | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/fuzzy b/common/fuzzy
index 988203b1..bd08af1c 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -14,6 +14,8 @@ _scratch_fuzz_modify() {
 	$XFS_IO_PROG -f -c "pwrite -S 0x63 0 ${blk_sz}" "/tmp/afile" > /dev/null
 	date="$(date)"
 	find "${SCRATCH_MNT}/" -type f 2> /dev/null | head -n "${nr}" | while read f; do
+		# try to remove append, immutable (and even dax) flag if exists
+		$XFS_IO_PROG -rc 'chattr -x -i -a' "$f" > /dev/null 2>&1
 		setfattr -n "user.date" -v "${date}" "$f"
 		cat "/tmp/afile" >> "$f"
 		mv "$f" "$f.longer"
-- 
2.18.1

