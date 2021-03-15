Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D82C4332B
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 11:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C99764E90
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Mar 2021 11:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhCOLU2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229901AbhCOLUI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Mar 2021 07:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615807207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fP6ROJvol2l8Fh0lbodDcLDfrGd8f0tcuJVWEp5n61E=;
        b=JIVrG2KlcEXDlp4V7s/wHQomsKi/lEvdkXI2CZ2/qqlbZEG4cYmpibCDu0wjuAiHtOMYcC
        HiJzOKa2wjsLMlL4UqE4OtudD66hOHWOI8GRGxOW21VqsKXA1h4T36K+EuDPAD7T+/4ogK
        hvWVf3efcFJ9HmrxTWPxfvpFPAd2+9U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-WkkRbvC3PdasEkqo5JTEuQ-1; Mon, 15 Mar 2021 07:20:05 -0400
X-MC-Unique: WkkRbvC3PdasEkqo5JTEuQ-1
Received: by mail-pj1-f71.google.com with SMTP id r18so13324771pjz.1
        for <fstests@vger.kernel.org>; Mon, 15 Mar 2021 04:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fP6ROJvol2l8Fh0lbodDcLDfrGd8f0tcuJVWEp5n61E=;
        b=UZRHOFyCCeMcIW0sDcV7nL1vrhaAKlscAttPytcsB72Z6QUbl7k8hy3k+/nB2VZyDR
         RGoqQBKP7XFFCCICXdbRlzBkO8kCN1WsTl6IbHgFur6MF1uRAt905j+s635yIuN1HZp+
         j1Kitgh58KkjrFmO3RolsiJfICyv06RJ53hwU2siHXjwkpWJrOsljZ+zjo5hcehlifr1
         XWK3JMx3J+mDPHy6UtmvkwtLrVKFypCCKInE/IKUaD8sIvSUjn8sfXsZtLzWBxFwAG7A
         4Q4vZuQ68KxtYizFtkfJ/hS306JxQnWEibfnCu3xeTUkeQKymFIcxuK6NRVYHoJDvjsP
         ibMg==
X-Gm-Message-State: AOAM5328Wn7GaDBI6HteJaz7l0bpltRMn2iarrVAtq5N2zsYp7vjG1sx
        WuWTv1JopGX62rak44nNW26qX4AEq+tYwkNCA7e/5Dxs1eQm57bYtThzLcwcQ3ClAWfZmnl0rVz
        JBlKBcYjimR7gFX6f4w==
X-Received: by 2002:a17:90b:188:: with SMTP id t8mr1151380pjs.169.1615807204595;
        Mon, 15 Mar 2021 04:20:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk24S4eLWwCOdVETeCFw3+wTt3VJ6DGiIGP3ptYCDjEJexgOVu+BR+zYKqsp6AF+KizU7T9Q==
X-Received: by 2002:a17:90b:188:: with SMTP id t8mr1151366pjs.169.1615807204458;
        Mon, 15 Mar 2021 04:20:04 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r23sm11058448pje.38.2021.03.15.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 04:20:04 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Gao Xiang <hsiangkao@redhat.com>
Subject: [RFC PATCH v3 1/3] common/xfs: add a _require_xfs_shrink helper
Date:   Mon, 15 Mar 2021 19:19:24 +0800
Message-Id: <20210315111926.837170-2-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315111926.837170-1-hsiangkao@redhat.com>
References: <20210315111926.837170-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In order to detect whether the current kernel supports XFS shrinking.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 common/xfs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/xfs b/common/xfs
index 2156749d..ea3b6cab 100644
--- a/common/xfs
+++ b/common/xfs
@@ -432,6 +432,17 @@ _supports_xfs_scrub()
 	return 0
 }
 
+_require_xfs_shrink()
+{
+	_require_scratch
+
+	_scratch_mkfs_xfs > /dev/null
+	_scratch_mount
+	$XFS_GROWFS_PROG -D1 "$SCRATCH_MNT" 2>&1 | grep -q 'Invalid argument' || \
+		_notrun "kernel does not support shrinking"
+	_scratch_unmount
+}
+
 # run xfs_check and friends on a FS.
 _check_xfs_filesystem()
 {
-- 
2.27.0

