Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C182C433E2
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 11:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A35121973
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 11:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0BAiJsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIOLvn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 07:51:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726454AbgIOLvO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 07:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600170616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=04wN3Gk18wpigTKbmJEGYbTabSws/Lo0r4QSpf8BSss=;
        b=V0BAiJsJfjjVGlfhLoNzVq5RXxRMXvnGoDlqeG0DnEjcoFhq8r0VYnWMnaRXoWd0x/rqCT
        nOsvFMlXTnYFjIXHnd25tDaNCfl/3XtLO8qV4TeVOIJdgRIOmQEa86OKE0l/ag3+ePY21/
        tSyNB/qpHM7XXXLajnBvpPxK2iR9j/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Jev6FHvFNP6cr6PHh5caiA-1; Tue, 15 Sep 2020 07:50:14 -0400
X-MC-Unique: Jev6FHvFNP6cr6PHh5caiA-1
Received: by mail-wm1-f69.google.com with SMTP id x6so817358wmi.1
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 04:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04wN3Gk18wpigTKbmJEGYbTabSws/Lo0r4QSpf8BSss=;
        b=YP4zs+1cxVcY6KZR+YgeYxciTaGyipiEEjdOBPwfnUMNPnqvJyBXiXMMGkoK/XQRBZ
         GS/CMB61Q2z3NUkIxnITYDDBEsx/ySqyy7h3m1OCjP204Te1MFneFyaVi+IWzNP2W6X4
         10c1zELqFHjW9y8i27byrxNxvVUWDG0EDwqFuIdI8mtfcqqRBIk53r3XPYxsXBhoPi91
         hPWa7cYCE7k7c2ebRRAaYp2xshwMbPJHpjrWrzk1AsNotdOc4EI9JN6nZv1o1zUoyC79
         okMZIh3wjrguTHV0YpyBDvk0xDyw8ooZuUnB8zqF1YmsSODYpG8wtmhwy9eI+ACrScwv
         MW6Q==
X-Gm-Message-State: AOAM531NZT8aqUnf2fWduXmkpeIp+MxvYOq2qO3m4leTj8MzHI2W+5IC
        WVc1sijy3SKBx7cE7r/aW4PNOZ1ern7PDAH+IisNiWyQN/brV6b+LKtSKUWmjtB/vPaT3nr6Zx9
        UBYnwPBhdnMybI+OYNA==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr4347367wmc.103.1600170612775;
        Tue, 15 Sep 2020 04:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHU/JaRI7QuafztE4DZsiVzpFti86J+jhXA8HazqzKDx+qBEjM0qN/gAUV2Dh0hFNSX7W9SQ==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr4347355wmc.103.1600170612624;
        Tue, 15 Sep 2020 04:50:12 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id q20sm23383911wmj.5.2020.09.15.04.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 04:50:12 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] generic: add test for boundary in
 xfs_attr_shortform_verify
To:     fstests@vger.kernel.org
References: <20200914153213.76894-1-preichl@redhat.com>
 <20200914153213.76894-2-preichl@redhat.com>
 <20200915115612.GP2937@dhcp-12-102.nay.redhat.com>
Cc:     Zorro Lang <zlang@redhat.com>
From:   Pavel Reichl <preichl@redhat.com>
Message-ID: <5ab30d99-6a9e-8751-d60b-57ceb89846fe@redhat.com>
Date:   Tue, 15 Sep 2020 13:50:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200915115612.GP2937@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


> 
> If you don't need fsck at here, the _scratch_unmount (and the comment) isn't
> needed either :)

Hi, thanks for the comment. I guess it's not important for the test itself...should I fix it and send another revision of the patch?

