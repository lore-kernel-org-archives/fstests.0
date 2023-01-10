Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048B5C46467
	for <linux-fstests@archiver.kernel.org>; Tue, 10 Jan 2023 22:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjAJWvA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 Jan 2023 17:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjAJWt7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Jan 2023 17:49:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1926D32EB5
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:13 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a30so10030320pfr.6
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx72QwF6cg/7thZ1yaywDGiRxV5C6xJMmfXnQKTufAU=;
        b=Of1t6szKqmpprN8W0WA0OBH3NUa3wKy4YzIaRxr753y8bCh2q35Y7QmB2AZ2+0IHv4
         jfJMaxitRm0OJcFGYW4YffVIyjGnPqPYm+MiY8+Dr6cTD5s0ryXtMyLNiKu+O0dMViGT
         pqHzy1gmO3TFZyB7jcUXudDHKZU0HXBeiTVCGlBzmUNEcr3qoS9K0uICe8gnSvQzHrs3
         /Qi3ouw3k9fwWY3BsxIKxD3JvnMulgeDT+hKvyYJxRliiJBo5HFnegfpeSww6DliVIdj
         HvPUoB2PE8BpgaORSw4oGIlvP52qGb+xLTDtBKjN86TCfDXLX1O1ASM1r01nhixphPhE
         3TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx72QwF6cg/7thZ1yaywDGiRxV5C6xJMmfXnQKTufAU=;
        b=7RtVa6AO1sUssHXvrIlIYoqAReC+8jH2XPLBHkzZr/2ENYphe21DLHGEfKI7AJ2azx
         ShT98WIQVLsO+csf9I2xWiZoulww2L/Eh6gW95LGXBepaqgYiuwKp0vLij0pf2+7BfR5
         y8QcrcpkBXph7ZoqOiKPS5DUldh1kGljiLWNz/fwMJ89bAINFS/TANHk3uwf25NTiDHW
         uIfdfz2KAbPDexc97bdhr4raEEd6kXmBOk123PkJuud8w8ezYEHt4daV79iqd4uaK064
         V2RQ/WRAkRHv+yZcB7/5WukkXdOxi9RIyvdIT3qZ4Y5r9XVPyifTCTUVpmRCk1uJa7j5
         d6vQ==
X-Gm-Message-State: AFqh2kp5PWh+Pxo6VgFvqSkGnmi5sAVr+Shg+Z1EU5I9ZJ0I27Xth2mM
        qwjwh8aKo+XImGbUaRBH6q/c5gZEnZ6kb6Cc
X-Google-Smtp-Source: AMrXdXvTNqMnz9GlmPCmlNJM1rDjVFa4VEB0ybHw7lknkpFl7Nqz2MRgXXMIvBj8VOcS2C97uxeWTA==
X-Received: by 2002:a05:6a00:4486:b0:589:85ed:4119 with SMTP id cu6-20020a056a00448600b0058985ed4119mr115041pfb.32.1673390952613;
        Tue, 10 Jan 2023 14:49:12 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b00581a156b920sm8567225pfr.132.2023.01.10.14.49.11
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 14:49:11 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pFNQa-001Yl8-CS
        for fstests@vger.kernel.org; Wed, 11 Jan 2023 09:49:08 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pFNQa-004unP-1C
        for fstests@vger.kernel.org;
        Wed, 11 Jan 2023 09:49:08 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/3] populate: ensure btree directories are created reliably
Date:   Wed, 11 Jan 2023 09:49:05 +1100
Message-Id: <20230110224906.1171483-3-david@fromorbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230110224906.1171483-1-david@fromorbit.com>
References: <20230110224906.1171483-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

The population function creates an XFS btree format directory by
polling the extent count of the inode and creating new dirents until
the extent count goes over the limit that pushes it into btree
format.

It then removes every second dirent to create empty space in the
directory data to ensure that operations like metadump with
obfuscation can check that they don't leak stale data from deleted
dirents.

Whilst this does not result in directory data blocks being freed, it
does not take into account the fact that the dabtree index has half
the entries removed from it and that can result in btree nodes
merging and extents being freed. This causes the extent count to go
down, and the inode is converted back into extent form. The
population checks then fail because it should be in btree form.

Fix this by counting the number of directory data extents rather than
the total number of extents in the data fork. We can do this simply
by using xfs_bmap and counting the number of extents returned as it
does not report extents beyond EOF (which is where the dabtree is
located). As the number of data blocks does not change with the
dirent removal algorithm used, this will ensure that the inode data
fork remains in btree format.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/populate | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/common/populate b/common/populate
index 9b60fa5c1..7b5b16fb8 100644
--- a/common/populate
+++ b/common/populate
@@ -80,8 +80,11 @@ __populate_create_nfiles() {
 			continue
 		fi
 
-		local nextents="$(_xfs_get_fsxattr nextents $name)"
-		if [ "${nextents}" -gt "${max_nextents}" ]; then
+		# Extent count checks use data blocks only to avoid the removal
+		# step from removing dabtree index blocks and reducing the
+		# number of extents below the required threshold.
+		local nextents="$(xfs_bmap ${name} |grep -v hole | wc -l)"
+		if [ "$((nextents - 1))" -gt "${max_nextents}" ]; then
 			echo ${d}
 			break
 		fi
-- 
2.38.1

