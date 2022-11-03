Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D051C4167B
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Nov 2022 19:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiKCTRV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKCTRF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2022 15:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82806454
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 12:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667502968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0H1UnjHEgopC46KoA8lQ1jfKqsxGf3wWbcl3QR0fig=;
        b=hWBXELowq1LSIipPhZVd1jy99cPSjsCU2qS//kUK2W95ZBAc7GWIJtVmpHchFGVDLRXP7v
        8W13kaQVae1M2zZCcdf06T1hyLfg7sNtDzL8PUZFPglcyiscCOHuMOr+3WE7DW2VqJjoOW
        LiD3Y+BQK9irqvYuexZ13J/Edg5vbjs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-z0C64ak3MISSx3yB5mkGvg-1; Thu, 03 Nov 2022 15:16:07 -0400
X-MC-Unique: z0C64ak3MISSx3yB5mkGvg-1
Received: by mail-ej1-f69.google.com with SMTP id nc4-20020a1709071c0400b0078a5ceb571bso1845233ejc.4
        for <fstests@vger.kernel.org>; Thu, 03 Nov 2022 12:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0H1UnjHEgopC46KoA8lQ1jfKqsxGf3wWbcl3QR0fig=;
        b=rse3P2wb8eIJcyxVUDdQ693/5v0kMXig/fOSJwSBLt7m3ui4hGrjf0XdRYbP31bBUg
         Cxme6VbrJqRg5R1tLDmZozsIv/Xwn3HjUpzevQ0+htVHLQM+ZWzWoAM0fg6n3XShkzoV
         NYnkGwwC3U+3EZzK9rEh7D6ozgw1yKO00KX96C4dIeD1AkZFYu9GpXW7MfocC7Lt8gWI
         8+n0ZWFshiZ392RDlvT5wR4+aj7sW0TF8MUXdksTcsdiuUFwsNzSucza3wqgeg0yijh6
         MgQf/rkT7EfSe/tTRq1sQc3anv3G4PMx4e3v66SUaNjPek+0I9oy+o1FmrxMhNe/lIp5
         eQWg==
X-Gm-Message-State: ACrzQf2Q8oQflhdSH36WixHQq65WxO0jQa8kr577InXggrXPIMizIfjB
        kJG3/STycZILtttF0Jvk5SmNl/lJy811x/K+bWitmykREYrLcKIqOiYRDFmirgpmjzM375iZW+D
        fyXxYhq3d9Js/mjl/lr659gRdzn+MTQbjgBime72+kzvjt7RYy/QMM364pIHqpqzGlCMx
X-Received: by 2002:a17:907:c26:b0:7ad:f6c8:d6c with SMTP id ga38-20020a1709070c2600b007adf6c80d6cmr12879620ejc.640.1667502966190;
        Thu, 03 Nov 2022 12:16:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Gpi4SILo3xSs//YLM6zwrwb8FGceImv5uqlIoNm2EbCD43B+WHMxlHkY+CQBaEtN6K/g/Lg==
X-Received: by 2002:a17:907:c26:b0:7ad:f6c8:d6c with SMTP id ga38-20020a1709070c2600b007adf6c80d6cmr12879601ejc.640.1667502965951;
        Thu, 03 Nov 2022 12:16:05 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm866699edr.43.2022.11.03.12.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:16:05 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 1/2] common/verity: disable signature verification on hash alg check
Date:   Thu,  3 Nov 2022 20:14:19 +0100
Message-Id: <20221103191420.390048-2-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103191420.390048-1-aalbersh@redhat.com>
References: <20221103191420.390048-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When the fs.verity.require_signatures is set to 1 the file with fsverity
enabled need to be signed. The generic/577 needs require_signatures
enabled as it test signing. The _fsv_have_hash_algorithm tries to enable
verity on a file without signing it.

Temporarily disable require_signatures for the check and restore it to
previous state afterwards.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 common/verity | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/verity b/common/verity
index 897a7f0b..aad6728f 100644
--- a/common/verity
+++ b/common/verity
@@ -254,10 +254,13 @@ _fsv_have_hash_algorithm()
 
 	rm -f $test_file
 	head -c 4096 /dev/zero > $test_file
+	_disable_fsverity_signatures
 	if ! _fsv_enable --hash-alg=$hash_alg $test_file &>> $seqres.full; then
+		_restore_fsverity_signatures
 		# no kernel support
 		return 1
 	fi
+	_restore_fsverity_signatures
 	rm -f $test_file
 	return 0
 }
-- 
2.31.1

