Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C1CCA47F
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 15:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiGSP1x (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiGSP1i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 11:27:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093F50062
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:27:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f14so11483412qkm.0
        for <fstests@vger.kernel.org>; Tue, 19 Jul 2022 08:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZV9gJdU7xP5V2qDZFKJD55uqEiD7bTqFQIZd+Tbgwc=;
        b=Gu+1C6W1L2ZyK1kIQw7o1GBJX95OH33SweVUPYNo70EnUvKcn57jSSxTZfJOA/z78O
         EKOhwM86QbqEqI4RJ/7TD7Wrf3bC4aQvfJkIi5evAJcvebuAYo7JahPbtInRyyWZkA+0
         xqraA7rcRaBR7dxXKfdfVqv76gKgIoUQ1HHuz8MllbeKCNfqbP3hrVLttgSrUGuZoMFD
         Oc0lNxjXkmUCLeaTKOwTCMCqXhCop+obvsx/SXb2bG69pJeAXTH/Tjv259u2PkXolTbk
         b5u9UMcKFlEDcaLkfC+BhVXhoTPDkLhad6CDQ58x91I2XNXLk48tFI9Bf3/FGCjOvdFQ
         ZfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ZV9gJdU7xP5V2qDZFKJD55uqEiD7bTqFQIZd+Tbgwc=;
        b=8HqgKI2QaeDQC+9JuE543eJBJSkdtiea7ODrpVgXFn3xXTJgHIro9Pe2uZahy3t9et
         GhTrDwyXAZH9UwLlaYTil3pjTmqkIh7ES3z+Ter7XA9RodQcRkSVQgcyBP/dLoHiyOl0
         ssFF7BSuIyEDNcaz12/6OJ1P5TUA4HbgmevXqUC0XOjvYLFtElzHf7JMRntIY0jckH1x
         wi75mMWQ9iMF5nlKgxeUE3dTcD2gH1k5MQ1dSRjjVHCMrL5Zxw26+LUQ9dHA7ordyuU6
         cvur0G6LPI2RKEt/bWcy080tAZ7cHPmO4F9C65vHqs1Tgixm2rqqusoa/79mPjqOuL5C
         TArQ==
X-Gm-Message-State: AJIora8FQhSt+iTCEsw6cCnRxWOsm2z+oHIOZDMOErBcKh2kfh+Gjjiz
        O9Ad0YXvcE6NEf1mSy78johkUg==
X-Google-Smtp-Source: AGRyM1vEPc1ky9jQ9nUF2b6STIurwizqnUsS3QyJpQBDJCif150sij2Vln1dQG5DHNhbP4LJir/W/g==
X-Received: by 2002:ae9:dc42:0:b0:6a6:7b4b:1636 with SMTP id q63-20020ae9dc42000000b006a67b4b1636mr21424781qkf.111.1658244456765;
        Tue, 19 Jul 2022 08:27:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id de17-20020a05620a371100b006b5a12eb838sm5552552qkb.31.2022.07.19.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:27:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: don't run btrfs/257 if we have compression enabled
Date:   Tue, 19 Jul 2022 11:27:35 -0400
Message-Id: <31a36368502eb7b1ee7bae36f000f4ee1eda3913.1658244445.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This fails on all of our compression config variations because it
depends on specific file extent layout.  Add _require_btrfs_no_compress
so we don't complain about failures that don't apply.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/257 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/btrfs/257 b/tests/btrfs/257
index 5c5cdcc3..3092495f 100755
--- a/tests/btrfs/257
+++ b/tests/btrfs/257
@@ -27,6 +27,9 @@ _begin_fstest auto quick defrag prealloc
 _supported_fs btrfs
 _require_scratch
 
+# We rely on specific extent layout, don't run on compress
+_require_btrfs_no_compress
+
 # Needs 4K sectorsize
 _require_btrfs_support_sectorsize 4096
 _require_xfs_io_command "falloc"
-- 
2.26.3

