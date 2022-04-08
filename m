Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6EC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Apr 2022 07:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiDHHgq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Apr 2022 03:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiDHHgo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Apr 2022 03:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A66197AE0
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649403281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pZtNdOfzSSjYErKFbduDDmGmm5jb8VIKf0crmx7H+8=;
        b=dzSG7f4ZF7YZi09Lc/hl+XoQJnWBu/H6DNar6+sfdbTq/33dWwo5qbeq0m4zUDE8rMxZa3
        beBUqE1sdLwe1ma9sQgxh19nOzNVq+k9/X86xXsaTDkwuQ76FxUIXF454BObv/9T/6HYt1
        LZ+UUq2bxDvUU158hPpk5c2ovDEpOmI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-0AUVhFWIOnOGHERkibOreA-1; Fri, 08 Apr 2022 03:34:38 -0400
X-MC-Unique: 0AUVhFWIOnOGHERkibOreA-1
Received: by mail-pj1-f71.google.com with SMTP id oj16-20020a17090b4d9000b001c7552b7546so7281792pjb.8
        for <fstests@vger.kernel.org>; Fri, 08 Apr 2022 00:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2pZtNdOfzSSjYErKFbduDDmGmm5jb8VIKf0crmx7H+8=;
        b=SyPxyG5fB3Edqf+s+RcOMNCjGGSYN8famgsEP4htRqEq99pEx138zlzCp+/7hHQZJC
         tIcNB3FRHUz16qXY09M8MROjyt2dO3o1cPrS1QBAiBtBqzvc+f+VbMKMMOkH6JGYJhRc
         gcIAjcE36C81ZnJ3uEjnpdYXdIs6JXX78Ad1fXyYyCWf21Lyx7DjfesVg5mIF7XO0fBr
         PdmlDMVE1GRHta7zgN8dDrSkyAh2j581fqoePZnfQylq4y1nJn1TYLf9cMCXO82Ul3Pg
         Whhv1NGIRmQutRb6OqNSwaBHSGjTWNVjS8rVV3vGjS6grnsnGu27AO8P2yxB2Jwn7vyG
         UyRg==
X-Gm-Message-State: AOAM533J8aA+8HzCks2BCl2nl2VMYTQXmjWFNcN5MGXMaSF6ehPN45BH
        66lCqjoG49PHD1esv5kXlcPMRVwKNhvn3M3ZXO1Nc1sMkbgfgE7UaNGpbhQRoT2mbN/x5QYHnYd
        nfpkFDGALKnkwmRjUMQ==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr20149865pjb.136.1649403277220;
        Fri, 08 Apr 2022 00:34:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjiixitDhfCBnxdHYNFpXmS1gcb7RjPFPV53J4awpX4yEvqxdF4QJ1y3nbomuazGOuHBqaVg==
X-Received: by 2002:a17:90b:1bc2:b0:1c9:9cd1:a4fe with SMTP id oa2-20020a17090b1bc200b001c99cd1a4femr20149838pjb.136.1649403276887;
        Fri, 08 Apr 2022 00:34:36 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm21121644pgc.80.2022.04.08.00.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:34:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 15:34:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2 6/6] idmapped-mounts: Add open with O_TMPFILE
 operation in setgid test
Message-ID: <20220408073431.zhsx73p5rygzuj2g@zlang-mailbox>
Mail-Followup-To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        Christian Brauner <brauner@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649333375-2599-6-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407134350.yka57n27iqq5pujx@wittgenstein>
 <624FC123.6060603@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624FC123.6060603@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 08, 2022 at 03:58:27AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/7 21:43, Christian Brauner wrote:
> > On Thu, Apr 07, 2022 at 08:09:35PM +0800, Yang Xu wrote:
> >> Since we can create temp file by using O_TMPFILE flag and filesystem driver also
> >> has this api, we should also check this operation whether strip S_ISGID.
> >>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >
> > This is a great addition, thanks!
> > Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> Thanks for your review.
> 
> @Darrick @Eryu @Zorro
> just a kindly question, not a push
> xfstests has not update for 3 weeks and Eryu will take off maintainer.
> 
> Zorro lang has apply for this job. So when does xfstest can work well?

Hi Yang,

Sorry for the delay, I'm still waiting for the job handover, I have no
permission to push to kernel.org now. The transfer might need a few days/week,
Eryu is busy on other things :) He might merge the current patches on queue
when he get free time, then we can start the handover step by step.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu

