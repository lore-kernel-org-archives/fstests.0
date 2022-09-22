Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F21C54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiIVNtD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiIVNsj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 09:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E1ACA2F
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663854510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL6XkCTfghHBuDSedvvXNp9iuEeN6z3X+bmTL/XLFwY=;
        b=KYAamsALTnIA2gFa8Od5ZZTZHlRldHiHI97E2XtLFXZV0IOhebCMkMMlL4TPyiyXAX8ZUB
        dkF28w0lVVISDRFCo+dCtCQgszZYN3QRpip/ellZXYotkSi4BM6Hbr1qj5BIFcmtsVRUG2
        7fTVyQwnTDwhvMkSNz9pjdHyYnDSHcQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-EaY74p3fNc-E-E75o__GkQ-1; Thu, 22 Sep 2022 09:48:28 -0400
X-MC-Unique: EaY74p3fNc-E-E75o__GkQ-1
Received: by mail-ed1-f70.google.com with SMTP id v11-20020a056402348b00b004516e0b7eedso6717496edc.8
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YL6XkCTfghHBuDSedvvXNp9iuEeN6z3X+bmTL/XLFwY=;
        b=OWsfP2ycmFYZoJS5NrVzSgz0KmCNUhysPcurZxRMqfBu0qXQaYW/Wdt12SDw8AY5GL
         5GmVQdC8QzsLYRrdVIBv3qrJDeZ5r/4qeQvt4gW7wDvs+/eJIgHNJhbo3M+7yaATsQVn
         cnloB04EC9krMj+NUTx3gVvoNjwhhtNBd34sPpOu8pvQ+pGqXXke8od93tuW8S7BaxLz
         BY8+xyPpTM38hTQNlbSLciz+parDpDNhA7OxQzndzcjaHTZRFCQ2rc51PW43Ze+fD/se
         uTOhFypchQfrCeD21m+FdYWVhN+5kA8y4Grt5TIu75VEZBF3zGTE4HZ4b2qXWOPPt8Ea
         aiQA==
X-Gm-Message-State: ACrzQf3kBZQKVe2VoPEX/BRbOEyNZXAcfkfSZxyVRVHz57civ6GluP0Q
        qtcApSonVFK2ao9uJD//+4BEm6Ky4WYBWsVweZ1FIlAEaHMYNhO3wkP1UKfTLPJ3fVXnsd4KXIw
        iSN09MepU0WPF/U+kdijC2bVwBqxUZl8p/zdb5a5e/9nb/Wu4HvCItPiBo42URSEpfnxn
X-Received: by 2002:a17:907:a421:b0:780:c72d:daa with SMTP id sg33-20020a170907a42100b00780c72d0daamr2982118ejc.68.1663854506833;
        Thu, 22 Sep 2022 06:48:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM46KF0PjBaHSfQsRgZsYNyk636av7tEvT6MvcbpqYkSN0cs/QfZqLJchy39TVAPkLYKwcpkGQ==
X-Received: by 2002:a17:907:a421:b0:780:c72d:daa with SMTP id sg33-20020a170907a42100b00780c72d0daamr2982099ejc.68.1663854506599;
        Thu, 22 Sep 2022 06:48:26 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e4-20020aa7d7c4000000b0044ec76521a1sm3760861eds.55.2022.09.22.06.48.25
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:48:25 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/4] g/299: speed up the test
Date:   Thu, 22 Sep 2022 15:48:20 +0200
Message-Id: <20220922134822.1020119-2-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922134822.1020119-1-preichl@redhat.com>
References: <20220922134822.1020119-1-preichl@redhat.com>
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

