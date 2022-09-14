Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00302ECAAD3
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Sep 2022 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiINPYt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiINPYs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 11:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161661056C
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 08:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663169086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nOGNT7n06t02CfAUgXY49siMyGY36B2q3wh7gA2Q8M=;
        b=SZ9Y693BH8JG6nPkTc1AGuHNfdxOphFOxIrD+eS5XhKkTqebVxXhvpQVkz7Ckt7FGqMGIL
        +IUlvm6wV34LkIO/Y6T/dYrIJ0ctkYNJrDKRzIhPFj/apM3aBHkAYZZ4w/NnPeR14xLaLm
        esqdjWHmKt/JO4N62YEkLCadSRv7rBw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-X6FaaMiVPCi76_cysGz6jQ-1; Wed, 14 Sep 2022 11:24:44 -0400
X-MC-Unique: X6FaaMiVPCi76_cysGz6jQ-1
Received: by mail-qk1-f200.google.com with SMTP id u6-20020a05620a430600b006ce769b7150so3954220qko.0
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 08:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/nOGNT7n06t02CfAUgXY49siMyGY36B2q3wh7gA2Q8M=;
        b=bKzSLCacL792VVVWOS7GmatFp72Qrpc5SWHUReNjV7O1npaOXXez/Gf/fCIW1CKvwA
         TtCiltI/tenfxLCvPR5+1UN/7d6XLWWhYrqds8QeXcE9HOGJyn1A0bZONhEc+EzD0FxM
         fCwzOb+nhQy6frymegKdpCXznOoGmWnI3z0o+MGo1XStPnylEiaGz5cPGRseYah6Rmn/
         /w4VCu8zS8Or/Unlfya5rMz9GCaqZp9YwZ8828djL26IpzifT7qC/ub+784MAqnQLPIk
         YT1T1JbiR0aDRxfVVKLCNf0KCHQvS6/MM3T4o/I4v5RVh8sKY1DVhQfVzc92zRiDC9gt
         +PgQ==
X-Gm-Message-State: ACgBeo270GgE6fJdRdFBvK6Ujt5+9uiwBwfAbfD/ztnlgKVkzTFDreyj
        bs8+pMXD1aSbn8CPHKaflxJ1nQckI9GjtJIy/JJ1NjCV1LED2KK3R4p1V8b6K01dewEpxGUuHLT
        48XauCgFSHck3kJ40xA==
X-Received: by 2002:a05:622a:1394:b0:344:648b:575a with SMTP id o20-20020a05622a139400b00344648b575amr32470426qtk.607.1663169083960;
        Wed, 14 Sep 2022 08:24:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6eLpanJlyIOWOFnwwl2RC+z+74by5bYAxQbbZCtJlhEKfzA1vYhreAvWpuGebRLMd33Yec6w==
X-Received: by 2002:a05:622a:1394:b0:344:648b:575a with SMTP id o20-20020a05622a139400b00344648b575amr32470410qtk.607.1663169083697;
        Wed, 14 Sep 2022 08:24:43 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a44cf00b006bc56c063fcsm2210910qkp.62.2022.09.14.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:24:43 -0700 (PDT)
Date:   Wed, 14 Sep 2022 23:24:39 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] common/quota: fix grep pattern
Message-ID: <20220914152439.co7zcvfzngdzw3gc@zlang-mailbox>
References: <20220914090610.1994485-1-jencce.kernel@gmail.com>
 <20220914090610.1994485-2-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914090610.1994485-2-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 14, 2022 at 05:06:10PM +0800, Murphy Zhou wrote:
> The second dash is not needed now. Newer grep is complaining:
> +grep: warning: stray \ before -
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  common/quota | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/quota b/common/quota
> index 22be3c69..01ff7e6d 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -218,7 +218,7 @@ _qmount()
>          quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
>          quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
>          # try to turn on project quota if it's supported
> -        if quotaon --help 2>&1 | grep -q '\-\-project'; then
> +        if quotaon --help 2>&1 | grep -q '\--project'; then

Yeah, I can reproduce the problem [1] you said. But I'm wondering if using
"--" [2] might be better to be compatible with old and new grep ?

Thanks,
Zorro

[1]
  # quotaon --help 2>&1|grep '\--project'
  -P, --project            operate on project quotas
  # quotaon --help 2>&1|grep '\-\-project'
  grep: warning: stray \ before -
  -P, --project            operate on project quotas

[2]
  quotaon --help 2>&1 | "grep -q -- '--project'

>              quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
>          fi
>      fi
> -- 
> 2.31.1
> 

