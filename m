Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86907C432BE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666E661057
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 09:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhIAJle (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232817AbhIAJld (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 05:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630489236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I4Vv9FhzpXy4aniAWFdVz1JM+EpzEki0ocz5vOxu/90=;
        b=EU6v5BMYx1DU08NBVv7rw7CMtj6AdSHZXLq24WK4g/nOAd2Vo1m2pOWBQK+D6atOr4Sln7
        p4pr+hVGuvTjuCx89svv4itOEszyFbULIYv+a+u+a70uYQd11FUBT1jHLtBcsLoWr14BFk
        dg0rKffncAfTk0Nl8/c55Yq2FzvEj3k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-G7K1hIllOIyappCOQkoaOg-1; Wed, 01 Sep 2021 05:40:35 -0400
X-MC-Unique: G7K1hIllOIyappCOQkoaOg-1
Received: by mail-pl1-f198.google.com with SMTP id p5-20020a170902a405b029012cbb4fcc03so738337plq.19
        for <fstests@vger.kernel.org>; Wed, 01 Sep 2021 02:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I4Vv9FhzpXy4aniAWFdVz1JM+EpzEki0ocz5vOxu/90=;
        b=kdgaYLOJo54hxmfOe61VWwerR5Fza+ymAYymlNYsOx1xavZ3LaBy64RjlDNSHMD8kr
         S1Xq+x8iY3dLnLax/lZqNqfFrSi9/Q/K/epakSjRI9/G2R9fx1+kWEBv5A+oRNNZ/H7c
         i+P9xx6o6D0Mc383NLyuG15ewqdb375oVl1uztRC663twm/9zwVESW94K06xnySKhj1S
         X6XFTCqtAorR3cyRsu3lenxWeyMVEBFmzO/0m8eMeApxhfsmjs/ZhC0kQe07otf37NVs
         zzDzXvN4yFBIhJJtaBV6W4exhis+o7x9yZJwxAdd63XSTO8+T0INgcP7ARt/vIdf3qxI
         3uuA==
X-Gm-Message-State: AOAM532QbrtRBP3yRVwhKBzKHiDVliHTpU80Di7T1QzYNw+Y/6x/BMa8
        W7mhFQh1pYjvUwAwGflVVCodZYX+siUg8uQhB+HclPL6PruglpqlwgvxXbFVAP5du7zSDSHWw1S
        ANIdMKcR8snoGp2pbBQ==
X-Received: by 2002:a17:90a:8a82:: with SMTP id x2mr5842105pjn.189.1630489234638;
        Wed, 01 Sep 2021 02:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaWZnidLQ5dIPwJehRocOBxFuChDTZTqmcuR23MGlNeueM9B/f67zIJlMClle4uTxaZFYm3A==
X-Received: by 2002:a17:90a:8a82:: with SMTP id x2mr5842080pjn.189.1630489234390;
        Wed, 01 Sep 2021 02:40:34 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u10sm12905704pfn.147.2021.09.01.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 02:40:33 -0700 (PDT)
Date:   Wed, 1 Sep 2021 17:40:24 +0800
From:   Xiong Zhou <xzhou@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Murphy Zhou <xzhou@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210901094024.424whsgozs5lwyzo@xzhoux.usersys.redhat.com>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
 <20210831134207.aa4e26xuyji4npia@fedora>
 <YS5hRsSXNHYQdUv9@mit.edu>
 <20210901054822.phzkg5xqoocx3duq@xzhoux.usersys.redhat.com>
 <20210901071545.GA1756565@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901071545.GA1756565@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After commit
  0e4dd8b9 common/rc: fix ignoring of errors on
we are getting this error message when running swapfiles tests:
  +./common/rc: line 2553: MKSWAP_PROG: command not found

Rewrite the line.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---

Thanks all for the suggestions!

v2:
  rewrite the line and add a filter
  source filters for generic/643
v3:
  drop the filter, use grep

 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 46b6b220..00f3023f 100644
--- a/common/rc
+++ b/common/rc
@@ -2550,7 +2550,8 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
+	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
+		grep -v "insecure permission"
 }
 
 _swapon_file() {
-- 
2.20.1

