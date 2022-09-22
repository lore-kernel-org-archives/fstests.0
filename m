Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A74C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 18:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiIVSzM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIVSzL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 14:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF765721D
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663872909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL6XkCTfghHBuDSedvvXNp9iuEeN6z3X+bmTL/XLFwY=;
        b=UKGMvvXv3Sv6I8Ggpi0uJ+pmQfKg3dtA21vOPtA5Eq9Eo2OHUQrlSBMz+2GJbeVpW6sFlU
        RarUTHFdk5xDBh5++ouM+N7yRSAJBX7m0YC5FJFjbuplXhnrGJsgISJzcKfInR4UDK/T8r
        cDUwYbz2wKnrkkq7GnoRkk3/uR2Rz1I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-297-EYHSmcToPiWBnDDN6Zri3Q-1; Thu, 22 Sep 2022 14:55:08 -0400
X-MC-Unique: EYHSmcToPiWBnDDN6Zri3Q-1
Received: by mail-ed1-f70.google.com with SMTP id m3-20020a056402430300b004512f6268dbso7359478edc.23
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 11:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YL6XkCTfghHBuDSedvvXNp9iuEeN6z3X+bmTL/XLFwY=;
        b=rUpV6flQs1RYvZYL/FgXpt8/ysCuQtQTdc8Wbc2PhGaI8cuGB9NES2hMAhmM6UsO/i
         Ejgm4aTgawwD/hanVmfzx/BGvoWWEjrOhMkzDyOZdTjdiUbCoUBm/xH1AD53D0DSp/X4
         c21XjGRisW5zS9RFxbnsKInzf+yYB7xC4Ca88mkmQd//ntmYaVZOaS2hITht/9QMTOi7
         4GsUtNhLRC5TkpQMgaO3knfxZ6ByA366X9NGe4zmvpzSA/qFKhPZRbBufmS3BhPxGlgW
         ILnFUJKu4WlfY3BMrqdNPCSbgIWWpoIOQnihWHHA3qeLH6zN+GxL3w/e0sJSVx4FNCSI
         Bc8Q==
X-Gm-Message-State: ACrzQf1JTIyG3Sf0TewiSL26k0vXRt1QIOT31AHBEM64q6O6fxzpZVGX
        sGPOeVLZAuD2Kjq8RZ4t5cCGCk3SrAxB/p/HtTmkD3CgCebrIHJL8W1J1Bkv32mdKlgcq4Sb5V+
        EbtyGZ+pf5RoQZ8tIBkEyV/+YzgqtaTOKStqA0ewPh+e8PlRK+dMfSMuENxQu/UrhsnGE
X-Received: by 2002:a05:6402:510c:b0:451:f363:24ee with SMTP id m12-20020a056402510c00b00451f36324eemr4750823edd.156.1663872906728;
        Thu, 22 Sep 2022 11:55:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hqiyNeJPvrAZRPzbu7YpJdOBdKsPYUnQ2HJfFPBwFXxPsxRwBV4dW+L4I2LvkRqboqE4lNQ==
X-Received: by 2002:a05:6402:510c:b0:451:f363:24ee with SMTP id m12-20020a056402510c00b00451f36324eemr4750804edd.156.1663872906498;
        Thu, 22 Sep 2022 11:55:06 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a50fc0e000000b0044792480994sm4094541edr.68.2022.09.22.11.55.04
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:55:05 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 2/2] g/299: skip test early if falloc is not supported
Date:   Thu, 22 Sep 2022 20:55:02 +0200
Message-Id: <20220922185502.1046115-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922185502.1046115-1-preichl@redhat.com>
References: <20220922185502.1046115-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Move the _require_xfs_io_command "falloc" above the
potencially 'expensive' function _get_max_file_size

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/299 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/299 b/tests/generic/299
index 8e1a112c..1bb371a3 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -24,6 +24,7 @@ _require_scratch
 _require_odirect
 _require_aio
 _require_block_device $SCRATCH_DEV
+_require_xfs_io_command "falloc"
 
 NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
@@ -96,7 +97,6 @@ filename=buffered-aio-verifier
 EOF
 
 _require_fio $fio_config
-_require_xfs_io_command "falloc"
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
-- 
2.37.3

