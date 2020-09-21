Return-Path: <SRS0=Zf7U=C6=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63857C43463
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 09:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F4720874
	for <linux-fstests@archiver.kernel.org>; Mon, 21 Sep 2020 09:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZiGKjA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIUJAw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 21 Sep 2020 05:00:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIUJAw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Sep 2020 05:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600678851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Glq6BNgaCJMk7a9WMizCP5W2rAXj8izaokGYFW+fyzw=;
        b=OZiGKjA45hLwcf+H65swWT7KeXaeYMsryk7L/ERvJpC1WO/whrY9iJFuRtfpLM1nhezkz8
        qrOdNNK0Qn7cuhBqW4fQNHRLNSOm3hTTCs1INkgL8usRH11w1Il3/7RvnP2hQWYKlcyRIT
        LRlEYM5bd7vSfcSyXxFAY6MrQuxOwV8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-r0MBLoxdM16-ldbEhDSjtw-1; Mon, 21 Sep 2020 05:00:48 -0400
X-MC-Unique: r0MBLoxdM16-ldbEhDSjtw-1
Received: by mail-wr1-f69.google.com with SMTP id r16so5574418wrm.18
        for <fstests@vger.kernel.org>; Mon, 21 Sep 2020 02:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Glq6BNgaCJMk7a9WMizCP5W2rAXj8izaokGYFW+fyzw=;
        b=najb45M3OfAaap5AtrdvKFeW4sTga99JLWIBa1Uc5BCTg/Vsren8cfn7PS+BlVfJsy
         D5E0cj8X5sxuBzn81il8NPjRpPqHMGEvW+o9CUVX4TRIjpB4Jet19l4iHedyoDxN/660
         GIDdTVtrXaVh6Cvi4GKdZSljbSwww6AgzwclksDp4KQsOVMcwODriKD5VMmsDYZcUSve
         qABaNJYytUfScorXWyzgAaOHdzKK90yjIkjwxZMfCJ8D2dq1D9TJaHP2zP/kep8zo7J/
         wqQJUxR8Z9TKNsFf0xlZVxaOwlLJx6zsSZqeSHAKROcCqnWqU+GToCyzg953Sw/TjJSv
         YNrQ==
X-Gm-Message-State: AOAM533BBBaN7FM3bPk5aN3/byoykMcKt75s/Ebvcn3dWH6THBxEc4I+
        +YwIFm1W45iovDYrGePEkI2CqZhEJLeQtvmUMZ4yhs0d1t+rn+06qB0fVcaS9yXTqfTHdD+RgrB
        cCL3e+YlK3MLvFvqvIg==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr55524626wro.249.1600678847377;
        Mon, 21 Sep 2020 02:00:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUersjfdrdljmg6JWUintD8tXAgo8EnzlewrSCacyh8H/m9xNkCd+3SwSn0nF6FuR4WMXLBg==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr55524614wro.249.1600678847260;
        Mon, 21 Sep 2020 02:00:47 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id k6sm18372154wmi.1.2020.09.21.02.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:00:46 -0700 (PDT)
Subject: Re: [PATCH] generic/611: remove _supported_os line
To:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
References: <20200921043144.8057-1-zlang@redhat.com>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <baec92ca-8515-a2f0-17da-51612e9a4297@redhat.com>
Date:   Mon, 21 Sep 2020 11:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921043144.8057-1-zlang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

Looks good to me,

Reviewed-by: Pavel Reichl <preichl@redhat.com>

