Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE1C433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6FA822207
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiABGHYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKWSm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725835AbgIKWSj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 18:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599862718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jhIOoupe5KCjIu8EKWJd1ZipqPJt9AoZkpIfH3o9Ew=;
        b=KiABGHYELQyMVngi0CbVutJNsCFf3/GNsARZ7OsCIRT55iWReGtcBsOPTUbtnPaM43K/xY
        /vRxNhIMySzd+lMp8OJ7UzQLrIFHidfzw3M0obISnq7hiDCUW2NlQf/1bJUHFw43j8DSeC
        RE7yB/TGnc9xww4hfw/+L0ZMclyS8u4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-kFOEW7NRP92aSoRbGvnC9Q-1; Fri, 11 Sep 2020 18:18:36 -0400
X-MC-Unique: kFOEW7NRP92aSoRbGvnC9Q-1
Received: by mail-wr1-f70.google.com with SMTP id f18so3920412wrv.19
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1jhIOoupe5KCjIu8EKWJd1ZipqPJt9AoZkpIfH3o9Ew=;
        b=Cw5hlT/XDC+qN19EU8VHJH2dsmdBn98CdcaxAelhN1Kh2+ElFEyhXh2ihriRjzfvoR
         yTp86UV2yRid0qO3E73S8mSLtHQ9jwASftEK4u4v0i3sV0YvJgZxjt3cdzLPqSdV1owo
         Tdca7/h1SEB3Yh2uaMf3HlSzdK35KJV6L7yk6kwbgWPTmGvsF9GcFx5rAzcwIsw4t/G0
         dUSqOtEk/6B92EcOb+K5CgjzDBZMPJRb655lTZ40gqyqLZPTJxMZ/5ccERrHT727ug1y
         GcIj01BrwZR628Xe0MPGBv1mHPYLBP07xu5avJP6b1SHtNZXEj3xn7Yeu5gYXsqLR+uP
         YQrA==
X-Gm-Message-State: AOAM532I6t/cqJawGQr6mKpPOYKVbw5RdCk3iBX6eaKWR8KQZOViMeCy
        FRwUVpqW6ZwLX94MNqNxSqkygF3qXt9inzEoIuGdxtWTcDLWe0a11KtYe8+xKvH3QzDJq7xbfFY
        Q1jwdrDuuGGoHU1PPrQ==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr4112812wmm.128.1599862715683;
        Fri, 11 Sep 2020 15:18:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0YHTi9YRcUiYxE1Xx2Ht/o1Z9v2rHre3FJj+5c3MsSXSomPg1JNpsIW1Bovp8cGLmMr287w==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr4112805wmm.128.1599862715552;
        Fri, 11 Sep 2020 15:18:35 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id u17sm6428598wmm.4.2020.09.11.15.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:18:34 -0700 (PDT)
Subject: Re: [PATCH 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
To:     fstests@vger.kernel.org
References: <20200911133855.38997-1-preichl@redhat.com>
 <20200911133855.38997-2-preichl@redhat.com>
 <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
Cc:     Zorro Lang <zlang@redhat.com>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <1082b05b-28fa-cb11-e5ec-c0f4292329c3@redhat.com>
Date:   Sat, 12 Sep 2020 00:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911182346.GH2937@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Hi, 

thanks for the comments. I tried to address them all in version 2 of this patch.

Thanks.

Pavel

