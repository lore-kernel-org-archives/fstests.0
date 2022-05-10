Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3428C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 06:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiEJGgc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiEJGgb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 02:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 887832265C7
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652164353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3h5h7vFFNlEkouniwaXqhbwXvv2DW4g4x627EWieto=;
        b=OiUwloX2ZgjGQ72MHKT6JrdAoLZ8Z0c+W/JQTET+mxhDvkr/0/N0Dq1Kuqi1v5L4C3adUP
        37tVCvwF6zsdrcsw3UjbXWqBYqKwgIw46G02tk8gHJnnVdJ2h+reExa1tsIdwDuu1zni1c
        H9QsDN/bvu5HFd+Xw47uToQJ7N+HW5E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-AtejmMvdO16p3s8i85BbCw-1; Tue, 10 May 2022 02:32:32 -0400
X-MC-Unique: AtejmMvdO16p3s8i85BbCw-1
Received: by mail-qv1-f69.google.com with SMTP id kd30-20020a056214401e00b0045a96ed0d4aso13547337qvb.17
        for <fstests@vger.kernel.org>; Mon, 09 May 2022 23:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=a3h5h7vFFNlEkouniwaXqhbwXvv2DW4g4x627EWieto=;
        b=TmSWnW0GSeceQ7UTHXwT1PV3ds9vhjKPun6R3lMttlTKXLOKGZBkGoAGFeAp+dKRrm
         rcCmZumAq7i7XcJaMSMi9B1moxngehXlYFWZyveV1WTTpq/nUj64FhSJKWm3XDM3ndpR
         4bfrVJdT1/3Ws0UmBKq5AcAqviyRt0b+9ALsKPjryD4JFB19tQy8/+5hY1aDZ2Px4KJh
         UK27I0YlIs/yelCDHh9evKJ6QLMli4QrVnb81bFITNyvSGk6Gec1F29UF0ERBcDW+61D
         XTOtrAh/WbMqVr8KgxNP8znd+xuMhnHVZr3SLj3xhkvvN0KhCaqvftQSR48qhFgwr3zz
         OX5w==
X-Gm-Message-State: AOAM532VUdmA4aq4EsmoyVGfE/w4afgybQW+DPIWbI15VIIHconzIvot
        Ngd06u/v4Vmsr8GkRtnARTDiPsshqG2ApdHDD8/ok0KbxlWXZ+I3hLV8t/f7sB1iqIAFKqmAgBz
        Ay5wYJ8dkAt9h+E/FGg==
X-Received: by 2002:a05:620a:71a:b0:6a0:15d6:60cc with SMTP id 26-20020a05620a071a00b006a015d660ccmr14022723qkc.413.1652164351026;
        Mon, 09 May 2022 23:32:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCznRrStrZANhqjTjRkWY2UTyw291k+9lD6DNcirlWqCKs5lhcy8i5x30DpJuXS3vWIlTlQg==
X-Received: by 2002:a05:620a:71a:b0:6a0:15d6:60cc with SMTP id 26-20020a05620a071a00b006a015d660ccmr14022721qkc.413.1652164350778;
        Mon, 09 May 2022 23:32:30 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c65-20020a379a44000000b0069fc13ce1eesm8315164qke.31.2022.05.09.23.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 23:32:30 -0700 (PDT)
Date:   Tue, 10 May 2022 14:32:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <20220510063223.dogoows5t7cxpnul@zlang-mailbox>
Mail-Followup-To: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401055713.634842-1-ojaswin@linux.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 01, 2022 at 11:27:13AM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS. This causes the FITRIM
> IOCTL to fail on filesystems like ext4.
> 
> This case was not correctly handle by "_require_batched_discard" as
> it incorrectly interpreted the FITRIM failure as fs not supporting
> the IOCTL. This caused the tests like generic/260 to incorectly
> report "not run" instead of "failed" in case of large discard
> granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index e2d3d72a..97386342 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3858,7 +3858,13 @@ _require_batched_discard()
>  		exit 1
>  	fi
>  	_require_fstrim
> -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> +
> +	$FSTRIM_PROG $1 2>&1 | grep -q "not supported"
> +	RET=$?

Better to use global variable carefully in common functions, if it's not
necessary, I'd recommend using "local ret" at here.

From my experience, the *quiet (-q)* grep does "exit_on_match" directly,
it won't wait the write process, if the write process is still writing but
the grep has exited, then it'll cause broken pipe, and the write process
exit with failure.

It doesn't always happend, it depends. So I'd like to use "${PIPESTATUS[1]}"
or write it as 'grep -q "not supported" <($FSTRIM_PROG $1 2>&1)', to make sure
we just care about the "grep" result.

> +	if [ "$RET" = "0" ]
> +	then
> +		_notrun "FITRIM not supported on $1"
> +	fi
>  }
>  
>  _require_dumpe2fs()
> -- 
> 2.27.0
> 

