Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165AC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 23:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiDNXot (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347758AbiDNXor (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 19:44:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2123BB6D05
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so11663800lfb.3
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 16:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDfLCLSKLFJzPQ7d79rqYBoh90FPjHBHPlMZOxWb900=;
        b=ffucnIukk4HY8lLvNaXpi5+V2GtDibJy+DEI/1i+7V3tdu5C9Ukqx0/dMda5bVhDZ6
         fsZF7PTk1NrZuY5Gwp/BBsvGzeBXLU6QXaqn1e9mewJEEBfnLhDHjUzQg54YYsHXbn95
         PbVIyxSu88toowQuonGxsaLSQQwIuWgX7RGM+qMoG0riu5E14q2Ug1DgdcaNHstlsDr6
         YzKT9rA4ahkNwsDHcDhxDlmO4A9pfaWitm7Fqn+KaCRrhUfSpjtv4Ad7vC9u86JhYuk+
         +/nrDVPlYeOiwaGWXaszbvQ0HkrNpw0x7CYMmgIMVzk8AQ1dfeYMSqRqu5bCp5guzbFT
         GOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDfLCLSKLFJzPQ7d79rqYBoh90FPjHBHPlMZOxWb900=;
        b=vP+Q10hIIu31n1kq4ITnnUc3s6+BrjSPu6o57igWb1uFQD7+lQ0LfxFzfyK/d6y0ZY
         lhsvSEtndEuDfFQS48PdCLBsPG61fND0sCn5JqinBAHNqc5FyLO4nCejF3ZFl04MTUtz
         iP44ImAV2kLKDWVHqR/Vpdl0c4f1hAlb7ZKSmd5hYFVknGZglx+L4b9gfmFo35M3sJSt
         cF82G7/eYkVlt3/dLcvD2VOp0e4VvgyAoKOdmqynq00M3k8L3RqD3JlT+TiXCMWyctQo
         sVibxy6rV9IkjkRFfxsvO7ba6FA/rlWi4KEuOso9cGDjuHpZ8PT5u1F+GPBYfqiQnYUg
         w8aw==
X-Gm-Message-State: AOAM533QbDIO7IWF8pJYMrnM1dwGjJaN+0ZgEDLwPjjj6KHMjCUUY2iI
        /HfPq+LplABkKTqMnHBz2zc=
X-Google-Smtp-Source: ABdhPJzje8mg12lB6watnkwoJPSK1rTwuRkfCIYTR5D8bRNx/vXfEwOJj4B9mEUzFb0uX/+viAwiFw==
X-Received: by 2002:a19:ee1a:0:b0:46e:e403:82ee with SMTP id g26-20020a19ee1a000000b0046ee40382eemr475514lfb.345.1649979739261;
        Thu, 14 Apr 2022 16:42:19 -0700 (PDT)
Received: from 5950x.telewell.oy (dxw3k4yf2tnxwyp6sg02y-3.rev.dnainternet.fi. [2001:14ba:9cae:8c00:9682:e720:334f:2fac])
        by smtp.gmail.com with ESMTPSA id q17-20020a2e8751000000b00244beaacef1sm127548ljj.18.2022.04.14.16.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 16:42:18 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
X-Google-Original-From: Kari Argillander <kari.argillander@fidelix.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        fstests@vger.kernel.org
Subject: [xfstests-bld PATCH 1/2] test-appliance: Add exclude file for ntfs3
Date:   Fri, 15 Apr 2022 02:42:19 +0300
Message-Id: <20220414234220.627320-2-kari.argillander@fidelix.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414234220.627320-1-kari.argillander@fidelix.com>
References: <20220414234220.627320-1-kari.argillander@fidelix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Kari Argillander <kari.argillander@gmail.com>

There is some hangs which will affect full run. Exclude these for now so
that ntfs3 is easier to run.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude
new file mode 100644
index 0000000..27160d3
--- /dev/null
+++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude
@@ -0,0 +1,8 @@
+# These ones hang so badly at the moment that we just ignore them for
+# now.
+generic/014
+generic/129
+
+# This hangs sometimes so for now let's ignore it so that it will not
+# affect full run.
+generic/476
-- 
2.35.1

