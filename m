Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55868C4332F
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Nov 2022 19:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKCTRX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Nov 2022 15:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiKCTRL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Nov 2022 15:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC01D0F3
        for <fstests@vger.kernel.org>; Thu,  3 Nov 2022 12:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667502969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0BdL5BurMpjS0mjJbHcG9qj2bbjAXUFX76zQ+NLRDw=;
        b=OMKWAWquGZbRryEYKZpXyWNlbmHKs3o3T+kLpn3m3DrEzE+1O1/CCo+2ycqNZWwEVeWjmn
        VKVt6Skch+Hu/oN2GJ39CwehJyLjYB8gUYnG86h9xARvAA40Xj15vhs0PxUb1H7dFqHF+0
        LRZkNG57ji354lxzLYu5cpysfBGD1ZY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-7hCpLYWfPGSPKtCWlJnAxg-1; Thu, 03 Nov 2022 15:16:08 -0400
X-MC-Unique: 7hCpLYWfPGSPKtCWlJnAxg-1
Received: by mail-ed1-f69.google.com with SMTP id w4-20020a05640234c400b004631f8923baso2006341edc.5
        for <fstests@vger.kernel.org>; Thu, 03 Nov 2022 12:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0BdL5BurMpjS0mjJbHcG9qj2bbjAXUFX76zQ+NLRDw=;
        b=D38DsHLj/g1ezb4H3V4up8qeuOM7qiEe/0LCnJ2xC5A91FHD0DpxBIGcFRkWTHtRiP
         AZfmsBeKtBHvDALcIW6A0BGWnWmE0+spihuaukdPzBW5gUHoRhFAqpxQGxcwSQzdr3dc
         yRshCp9w74LmwmlRFLLAC6wKx9rTE3G86HEi6vhOiMwVGOVvgpKwk3lBW6FszZVIyJqc
         CLrnrD2+Mej1ls2r4IIxk75H01XOVTF/hqvjTmCmDzLPQTmJmqSFj9HQ4D5l8rBBh3aN
         GZw7zeuPKHoxjWLn0/LOyBjH9Xg7yBKA4RLa6SE7UII7gHI+uqbYgiLyYWy5gb4mMi7D
         QkgA==
X-Gm-Message-State: ACrzQf0Fz3eXKxvDuSp6HrHzNKTpX7ZwHj2cvK3G204+UDXAi2wgdAKv
        lc3SmQnCulIFMeA7BzSz5VyzDMi0z0kMUqwXEIROl4jnmZYq8pHfdiYf6FZptezHFmOzovPnjIE
        hGqMlpNXTvQfUyLYPOz6G2/QYCSp6wHpvxky6fKKMRUVoaWbOnNBZk5yvgkdjZ+ynSB6E
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr29971581ejc.161.1667502967356;
        Thu, 03 Nov 2022 12:16:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Okd82EIxzxhdv77nJTp73wGA+j8BucMXNuQCof5jwzNWQmDV2tYLtb4r2ibLkfF7oswneqw==
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id nd23-20020a170907629700b0072f9aad0fcbmr29971560ejc.161.1667502967187;
        Thu, 03 Nov 2022 12:16:07 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm866699edr.43.2022.11.03.12.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:16:06 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 2/2] generic/577: add missing fsverity metadata cleaning
Date:   Thu,  3 Nov 2022 20:14:20 +0100
Message-Id: <20221103191420.390048-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103191420.390048-1-aalbersh@redhat.com>
References: <20221103191420.390048-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When fs-verity is enabled on the file, file becomes read-only. In last
check, test tries to empty the file. However, fs-verity denies
opening/writing to file.

Remove file beforehand as in other checks.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 tests/generic/577 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/577 b/tests/generic/577
index 98c3888f..916f3be3 100755
--- a/tests/generic/577
+++ b/tests/generic/577
@@ -121,6 +121,7 @@ if _fsv_have_hash_algorithm sha512 $fsv_file; then
 fi
 
 echo -e "\n# Testing empty file"
+reset_fsv_file
 echo -n > $fsv_file
 _fsv_sign $fsv_file $sigfile.emptyfile --key=$keyfile --cert=$certfile | \
 		_filter_scratch
-- 
2.31.1

