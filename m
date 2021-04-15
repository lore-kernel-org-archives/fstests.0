Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D34C43461
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B0C611AB
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Apr 2021 09:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhDOJth (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231809AbhDOJte (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Apr 2021 05:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618480151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdWhtJvl7MC1oD/gW6XMgG8McJ9WGJMyj2oi9yBarHU=;
        b=JgEsbCbEn1vigWKIq9hZV4hS6dS7kanmP/il/tELPLC6JgdyjlSY0+ELTX6a2l2Zhw9GQV
        03T7QoM/w3q81iwRtb9FDeWMDjfswb+vfs2YoCuSHWwo17+Z9eSfXiNlKRzjtjsvY8HD9O
        tEbQ6Nsyr8KEK6sRmDMiglxYRHQFWNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-KpKI6LfQNySwwA_OBD-yFw-1; Thu, 15 Apr 2021 05:49:10 -0400
X-MC-Unique: KpKI6LfQNySwwA_OBD-yFw-1
Received: by mail-wr1-f70.google.com with SMTP id j4-20020adfe5040000b0290102bb319b87so2490017wrm.23
        for <fstests@vger.kernel.org>; Thu, 15 Apr 2021 02:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdWhtJvl7MC1oD/gW6XMgG8McJ9WGJMyj2oi9yBarHU=;
        b=NBdaA1RtfMp/mmFrKtdrN3L8q68KhneqHYRfGuduyBwhFKKiIWQWqEvGDVK+P6/6KT
         O1zK8D0K/GOGbziv/nIUsqZHerHTSL9xJdHlbPxBfMrPI0Rwa9WUN45nTujjCGkYi5UN
         NKt4imJEYa0p7PkeeAVmjNwVT2HXjl7rAWS+Uy1NB0Df4GsaAMhd246Pk5M9jcT/WgWR
         SpnUJCmv8/MMWHLv4QUrbNecyPe67nSASNWGBN6aKB+XYQkJsr4887LA+AkuoUfCi4JA
         I2np2FNg6hsLWxnw6R8jW3OLRyccK0d6IFfUghlChKNMl8NZmaf+BG0Wau44Ul730R8L
         +liw==
X-Gm-Message-State: AOAM5327mU+cwjr5ZCk8CPMbyNfJnrQ3O8AQ85lN3XHkdDSzsPb2IqZ6
        ub9DRi/B5XJhQa2Y/2lVwMffwdxK+5It2r2Dmk7JY/ZGruzqP0MQl0qEqRDkVA1hXT3sBiA2sNO
        UWv3Cs5dShGG7s3q2LR040LJ93+Fd/dvJBFPJG2zVW2AhzhKTFsvt8ip1+AAHYshivN8g
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr2526699wri.125.1618480148667;
        Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUfC1I0psH1pmH7LzmAk7edBqzYXyt+VYxcps2SVsqhB2+UwobP1bLOBkp5+lFb6og1z4DQw==
X-Received: by 2002:a05:6000:184c:: with SMTP id c12mr2526682wri.125.1618480148544;
        Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id v4sm2427278wrf.36.2021.04.15.02.49.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:49:08 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v3 3/4] generic/554: hide permision warning on exfat
Date:   Thu, 15 Apr 2021 11:49:04 +0200
Message-Id: <20210415094905.61853-4-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210415094905.61853-1-preichl@redhat.com>
References: <20210415094905.61853-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 7 +++++++
 tests/generic/554 | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 47098b55..fb1f7598 100644
--- a/common/rc
+++ b/common/rc
@@ -2378,6 +2378,13 @@ _format_swapfile() {
 	$MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
 }
 
+_swapon_file() {
+	local fname="$1"
+
+	# Ignore permission complaints on filesystems that don't support perms
+	swapon "$fname" 2> >(grep -v "insecure permissions" >&2)
+}
+
 # Check that the filesystem supports swapfiles
 _require_scratch_swapfile()
 {
diff --git a/tests/generic/554 b/tests/generic/554
index fa4f97d2..da9bfce5 100755
--- a/tests/generic/554
+++ b/tests/generic/554
@@ -46,7 +46,8 @@ $XFS_IO_PROG -f -c "pwrite -S 0x61 0 128k" $SCRATCH_MNT/file >> $seqres.full 2>&
 
 echo swap files return ETXTBUSY
 _format_swapfile $SCRATCH_MNT/swapfile 16m
-swapon $SCRATCH_MNT/swapfile
+_swapon_file $SCRATCH_MNT/swapfile
+
 $XFS_IO_PROG -f -c "copy_range -l 32k $SCRATCH_MNT/file" $SCRATCH_MNT/swapfile
 swapoff $SCRATCH_MNT/swapfile
 
-- 
2.30.2

