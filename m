Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC75FC54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 04:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiITEcw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 00:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiITEcw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 00:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DE354C84
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663648370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WidnTcxe+Q5+zVzIB7PWVz+NQEaL6Q6KEnHU8kE6hA8=;
        b=hNcqUSESDYcIqHezugcRbtKO5WZFNguTuah1dSeRfIZ6z1Y/+tzXKMtOvbi4V+H+oaS+P4
        TTjO+6UTU2MRDr/8NsaSC35cLuOnh5Y3tGFhZzZNLEvjuCUUONpsRmADe/5fZfHuxWVuk4
        vzcntD1072kL80nSuD0WMup8Pld/cZ4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-Ejjmy3_jM4SiVM1wm4CSuw-1; Tue, 20 Sep 2022 00:32:48 -0400
X-MC-Unique: Ejjmy3_jM4SiVM1wm4CSuw-1
Received: by mail-qt1-f199.google.com with SMTP id g21-20020ac87d15000000b0035bb6f08778so1016930qtb.2
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 21:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WidnTcxe+Q5+zVzIB7PWVz+NQEaL6Q6KEnHU8kE6hA8=;
        b=idvwGU3WWvPvdmExboXRQdZnz6QXxNu2885rDu5Df9PfMZVz4AnwoPkg4tHCtsMG06
         yGf8exlVH3K+l/c93Y7qj5c5+CcMAPyoSkgxAyz7dQ7QHhOSmtFIU72m0QUHq3A5sVGc
         BH6kEH8ZkfvIwhyq56cNitK+YsMZHgikb2LctLGYu0uA4PFpvhu1rcECx4c2FtLACSKI
         VCQvwvqs+p7Hi7/8zbmhzdpTVQ50ge5TMOGRpqCiUdrqx+wa7y2sLdldWWUStOadvV52
         PiFKeolCKqaY6662Lz5a+k0DcEnmH2t+c5v3JrKKZgZOoyBR9B59E0gd2vx6gtTPcABb
         RyOw==
X-Gm-Message-State: ACrzQf1RmvOdLMqbfp+qxyf+QAGiJR4qX042wQGtE+dXiqLvVtmWaQ27
        rUbuYmESxQRzuHlqUXpi2EC23RZP7fdvrU2UekS1e8xFyO09NNrTwZl/ymhTEQghIxzgK2Ls1mY
        duxQaEnTRlide3F+4ww==
X-Received: by 2002:a05:6214:da6:b0:4ad:552e:5216 with SMTP id h6-20020a0562140da600b004ad552e5216mr2883547qvh.116.1663648368209;
        Mon, 19 Sep 2022 21:32:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54HB5EazCOG+lz7ICkY12NR+gpX3RJnKI0z5H3+ERpIOmqhVZ2KBexYovE2928r1F3e0K0oA==
X-Received: by 2002:a05:6214:da6:b0:4ad:552e:5216 with SMTP id h6-20020a0562140da600b004ad552e5216mr2883539qvh.116.1663648368008;
        Mon, 19 Sep 2022 21:32:48 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a414600b006ce813bb306sm281689qko.125.2022.09.19.21.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 21:32:47 -0700 (PDT)
Date:   Tue, 20 Sep 2022 12:32:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/2] common/quota: fix grep pattern
Message-ID: <20220920043243.cx42bsa5xyr3skfq@zlang-mailbox>
References: <20220920031951.2098839-1-jencce.kernel@gmail.com>
 <20220920031951.2098839-2-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920031951.2098839-2-jencce.kernel@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 11:19:51AM +0800, Murphy Zhou wrote:
> The second dash is not needed now. Newer grep is complaining:
> +grep: warning: stray \ before -
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v1-->v2:
> 	Using -- option.

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  common/quota | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/quota b/common/quota
> index 22be3c69..24251d09 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -218,7 +218,7 @@ _qmount()
>          quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
>          quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
>          # try to turn on project quota if it's supported
> -        if quotaon --help 2>&1 | grep -q '\-\-project'; then
> +        if quotaon --help 2>&1 | grep -q -- '--project'; then
>              quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
>          fi
>      fi
> -- 
> 2.31.1
> 

