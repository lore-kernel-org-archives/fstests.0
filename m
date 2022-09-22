Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2C7C6FA82
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiIVNtC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiIVNsi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 09:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AECEFA4E
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663854508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bE/A0pq7kRufxtzbmvFWrVrjL4QmrJK3Fsgs0/sLIg8=;
        b=C31aNQeD9cs+DEz1+da+NpRVPcVKFUH2DMCx/k7zms1/XTY8MveK/ZhhwTioPVhUXocRNL
        xPSjPPyCw3az13VGQPl3c4Ee8LHskb7aAk553953geh9wuRM4JupEjicfv2ICo50PsWAtY
        UOclTyp5S5NVOvKySGMhEejITjVB0mU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-jxyoetytMeK2hz-sCdsD3Q-1; Thu, 22 Sep 2022 09:48:26 -0400
X-MC-Unique: jxyoetytMeK2hz-sCdsD3Q-1
Received: by mail-ej1-f69.google.com with SMTP id hp18-20020a1709073e1200b0078054727517so4501944ejc.0
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=bE/A0pq7kRufxtzbmvFWrVrjL4QmrJK3Fsgs0/sLIg8=;
        b=StnOFxyho91z/p6LENRHwHltusNE9lwfsp1ILxJPYs9do7vMbr9myJHWTaj1Aqyw9r
         Tt0yQGgAPMblW2vL9fzn7Yq9hz2xStSNKwwMmwvL1xtUMX0fDR8RvuQiS+1I2yzdIWLB
         7zVT1dzFYyzdPZkJPf/VCasc5yRXx2L1Hxid/dOVid+CxSGQ0D/ACTy0hy8JcoMG5u/z
         eZncMRG9pJh9rdl7QYJr8IGwGKEVxgm5cZiD171U8z1LM/wsOkcAy9Hh7k5Ec6gK2yHn
         7XgOkFeyoebjgQiUhnP+Y0TKd+Fr74CaltXzh/Y/cPffU8ze96Jp2XaeWxLcZ0eJtIGh
         La7A==
X-Gm-Message-State: ACrzQf3fFB6Np9Z0s1EqFTR/yg0n/HjVbHtdxMYHn1riGxeKMbx1b8Yk
        SABH2AluCDtY4cxlhfUQAl55Z2PuYI5LU7WXerxORTzVsTZwnXW1RX+vFuqDzG9+E8RhhVjERX4
        DGPBFQYJUHeLuRDaQOKVoXpqJc+wpmySEyrckRTZcrPsTRWhyLlzH1of10rNMBWR2bR/m
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id k16-20020aa7c050000000b004534427a947mr3411167edo.172.1663854505231;
        Thu, 22 Sep 2022 06:48:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6mmrIbq65da+iiEX276XEeHiT2nVV3h+icqx79F1wGitLcdRuJ8Iw+gYjQpneld0v02Pxdig==
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id k16-20020aa7c050000000b004534427a947mr3411151edo.172.1663854505002;
        Thu, 22 Sep 2022 06:48:25 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e4-20020aa7d7c4000000b0044ec76521a1sm3760861eds.55.2022.09.22.06.48.23
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:48:24 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/4] common: Fix file leak in _get_max_file_size
Date:   Thu, 22 Sep 2022 15:48:19 +0200
Message-Id: <20220922134822.1020119-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This is obviously mostly problematic for FS lacking support for sparse
files.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 1 +
 tests/generic/692 | 0
 2 files changed, 1 insertion(+)
 mode change 100644 => 100755 tests/generic/692

diff --git a/common/rc b/common/rc
index 228fcb37..c9078649 100644
--- a/common/rc
+++ b/common/rc
@@ -4637,6 +4637,7 @@ _get_max_file_size()
 			l=$m
 		fi
 	done
+	rm -f $testfile
 	echo $l
 }
 
diff --git a/tests/generic/692 b/tests/generic/692
old mode 100644
new mode 100755
-- 
2.37.3

