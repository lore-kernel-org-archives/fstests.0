Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE6C433E1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25546619CF
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 22:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhC3WAb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232882AbhC3WAO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Mar 2021 18:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617141613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hp8hQWqoEZuTj5KIJ3Tua6tWI5QWBpoTdPdpekFNQRA=;
        b=L7EmYGKhDGTTDlyiql3ztjhskX5L6KNwmXxF8jNXhhxm6YvBhbXLYv7y0WiH3wOklCP9Aq
        CuT3wRwSKJEBWqY01Joc45Au1RrSSuKEdUl8WLpxadHFcAY7kgDm6cB/nLhO9R6xOJlQ6S
        YrFaDe3gArcMH/TjuZNxccSUSK1jQ1o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-oAa7vDmdOcGB_43iKNgv7g-1; Tue, 30 Mar 2021 18:00:10 -0400
X-MC-Unique: oAa7vDmdOcGB_43iKNgv7g-1
Received: by mail-wr1-f69.google.com with SMTP id h5so10914843wrr.17
        for <fstests@vger.kernel.org>; Tue, 30 Mar 2021 15:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hp8hQWqoEZuTj5KIJ3Tua6tWI5QWBpoTdPdpekFNQRA=;
        b=tu10ec1Ti0wjCRTzqDwI87ktAxn0tAwIKv7i4/Uvkdy6THxBAcWSXgShlJbGmnQ5u/
         YDIuJQp24vHVIZ3qZ7FD9WRpTLXI40YjRp/be72PSIMYucZl3Hn9/9m2hpkGNy8AcuhQ
         6nwnq3wAIqR5WfTu47P3EpRw0o2JRCeSg0b2vnx0BkWlSEh0LkG+SMDHalRQZX7H4My1
         c5MSWS3kNf0q4Z/7EIu0K/UdIse7BtOMBFdQ3XwfcsNqlj+etUEE7Bh5YCOa2MOpqQTa
         8/AV7NRoqQmfVjGC4rBqOxmRWXn2UvO+0yvLXVRlW5kKH1Qsjl/nprjkU5Sev9gJ55uL
         BoBg==
X-Gm-Message-State: AOAM533cD0LKN/j88sgy7g3LD+2rdnHEcKYFk4S8wXMxuih82v06ke+m
        zonoeU8k0OKgLA4yVkme1nprOjQdLfxGy4ixKzpM+BN1AeIhRvrdCQfh6Yi8buPwAXKm58Z5mps
        6eQCjBHBICjtuxOF3tETZWvcSWtUHbOpOutbU/05oUkgBApsGYvS+X7hebOH74q1pUcXL
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr134704wmj.54.1617141609260;
        Tue, 30 Mar 2021 15:00:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsdVO2VASFynOPLAEK8APaJN0ePKE19hLQ3dalQCSyvDySVLqQE3+Je0IJ2p6uWBsBAOay2A==
X-Received: by 2002:a1c:23c2:: with SMTP id j185mr134692wmj.54.1617141609030;
        Tue, 30 Mar 2021 15:00:09 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id z2sm522894wrm.0.2021.03.30.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:00:08 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, guan@eryu.me
Subject: [PATCH v2 2/4] common: hide permision warning from mkswap for exfat
Date:   Wed, 31 Mar 2021 00:00:03 +0200
Message-Id: <20210330220005.56019-3-preichl@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330220005.56019-1-preichl@redhat.com>
References: <20210330220005.56019-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

exfat does not support posix file permisions, so warning from mkswap is
inavitable. This patch hides the warning message so the test won't fail.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 9cdfe21c..2d658711 100644
--- a/common/rc
+++ b/common/rc
@@ -2392,7 +2392,13 @@ _format_swapfile() {
 	# Swap files must be nocow on Btrfs.
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
-	$MKSWAP_PROG "$fname" >> $seqres.full
+	if [ "$FSTYP" = "exfat" ]; then
+		# exfat does not support posix file permisions, so warning is
+		# to be expected
+		$MKSWAP_PROG "$fname" 2>&1 | grep -v 'insecure permission' >> $seqres.full
+	else
+		$MKSWAP_PROG "$fname" >> $seqres.full
+	fi
 }
 
 # Check that the filesystem supports swapfiles
-- 
2.30.2

