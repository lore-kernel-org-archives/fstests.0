Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB1AC07E9C
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0F661CBE
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGGKWx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231194AbhGGKWw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625653212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2boMp2VdCqkwPnnrA2lHCgYxwA8XXK8IgfXbt4AB3I=;
        b=dPvrEPfph1C2bYT7Sjx+b7BSJh7m+ilspiH6ohX8OCrhk1XdccpR58FX531uT0lJF0Wp9J
        gEEW6/A3EimQVZBaci8jf9vM2eX7JnknQTNGCh7Eguln4TKaf1TNrY4Xpwkc5HvB8AwQm5
        hXOrbW/udfi435OjkxgWAYrJ6FEeSKE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-cfdyc_s3MWmVT8E0oOifGg-1; Wed, 07 Jul 2021 06:20:11 -0400
X-MC-Unique: cfdyc_s3MWmVT8E0oOifGg-1
Received: by mail-ed1-f72.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso1188875edd.12
        for <fstests@vger.kernel.org>; Wed, 07 Jul 2021 03:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u2boMp2VdCqkwPnnrA2lHCgYxwA8XXK8IgfXbt4AB3I=;
        b=j+Qvyo13S4UnzTPv0gL+Sk8HDOZEdEVHOx0T761sVMDqhfUJSBrqmGXsQKHqbz+8Ko
         VuFRCqinuk+TXa/jn9hK2QZ7xqQ726i+sfeDXGl/uWLJcTv7lXXOvS81sDHddQzLQhPX
         Kfa0ON13aze9YfGyJrxPC3TnNcFFDc5vmUdlIa5/Ytu4rHDBL6Cbv/GvltDe9TPOpAXw
         fZ9KFj0Q5csqyyZ8uDStPE03o7tw09ODqibUTNvSlC2pSFniZ7LGeFzDxz68dKGfJI15
         ddt0x/IIdyJTEsKlr6rSuu30Tl9A6vCifzTqCxFM3oWhMhHszI8wHwYUDcNRb5W/7UgR
         zDUg==
X-Gm-Message-State: AOAM533C1+g4ofkxIeoBMDMTVZxTcCTh6W/bR8s6khxiwNKQN5kvGJWj
        88QmoKNzltwIRFmBdTfLFRwNC4H6aCx+bn9C35Ma+1aEgopndPDDjA0YHW7hIEBy8Q4vR7O6mLq
        8W1+tqRwDl6bx7OGgKtC2s5pRCvQ3Hs1qI8C7r/TrOtf5HgYHYc54/suw4nsHcBhHaDRu
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr28691044ede.39.1625653210066;
        Wed, 07 Jul 2021 03:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3NNSTRGyiUoqHmhYY6yI+kq1S7sMzyDRsjSm6NrA648JvrRqkYdR0TruQ40R8AMnVCJidlA==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr28691033ede.39.1625653209934;
        Wed, 07 Jul 2021 03:20:09 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id t11sm4095087edr.34.2021.07.07.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:20:09 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     shreeya.patel@collabora.com, djwong@kernel.org
Subject: [PATCH 1/1] generic/453: Do NOT run for FSs restricting names
Date:   Wed,  7 Jul 2021 12:20:07 +0200
Message-Id: <20210707102007.66774-2-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210707102007.66774-1-preichl@redhat.com>
References: <20210707102007.66774-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Running generic/453 test is probably only useful for filesystems that
allow unrestricted byte streams for names.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
---
 common/rc         | 11 +++++++++++
 tests/generic/453 |  1 +
 2 files changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index d4ad421e..7a352445 100644
--- a/common/rc
+++ b/common/rc
@@ -4599,6 +4599,17 @@ _require_od_endian_flag()
 		_notrun "od does not support endian flag"
 }
 
+_require_names_are_bytes() {
+        case "$FSTYP" in
+        ext2|ext3|ext4|xfs|btrfs)
+		# do nothing
+	        ;;
+	*)
+                _notrun "$FSTYP does now allow unrestricted byte streams for names"
+		;;
+        esac
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/453 b/tests/generic/453
index 55ddcc01..a0fb802e 100755
--- a/tests/generic/453
+++ b/tests/generic/453
@@ -15,6 +15,7 @@ _begin_fstest auto quick dir
 # Import common functions.
 
 _require_scratch
+_require_names_are_bytes
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.31.1

