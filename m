Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746ADC4332F
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Apr 2022 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377118AbiDDVUB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379005AbiDDQRt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 12:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0475C31922
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649088952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aTfGS//goQjWAgIFeV0nlANv5fG58SsoTT307/BWNs=;
        b=IeYpuxH8ff7Tiz4RANMMgWug7MllbteWAIWq+K8ZvVxD8bn4/TTkeBh+j29HYGeEVlgZwH
        hMPqpr81QixIi8KmrcyBW6osoB8bOIgdovJipkOwe6/iAyN0VkqxMagBc0Tv6fIHJ2Bixj
        Sd+2pLIOnQJBC5Mks5K44RYgKRb8who=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-g-2bIvlJNOqWS0fwLbVMzQ-1; Mon, 04 Apr 2022 12:15:50 -0400
X-MC-Unique: g-2bIvlJNOqWS0fwLbVMzQ-1
Received: by mail-pf1-f199.google.com with SMTP id 138-20020a621690000000b004fa807ac59aso6223920pfw.19
        for <fstests@vger.kernel.org>; Mon, 04 Apr 2022 09:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6aTfGS//goQjWAgIFeV0nlANv5fG58SsoTT307/BWNs=;
        b=WrDM90RqZeFuvuIaT2L4y3Z64ckrROQMnCDgtdgpS/KCfQz2SwczFknLx2WH2gE/lX
         zGg1EVLiZvhRWxXp6miWtCaorKiGc/Dp+3VvBPu1EXHJ6esdMfeeS7evqAu/VAEVmZIz
         DNompWcIfB3N1cvLitV+rhv4FO8iFh96vQuQJNDGtgCpPZVhQCECz7/M/7gM1CJRB5+x
         Bbm7w4SpRePEee9+FezRoaTuWI6/pOAqYY0HlhxfFzYKQxpBv6SU2VSDTPavdDJl+rCd
         K2NQwXnd65PvqZYrl3po3Jk1hu/ChTlBCxpyL5A/gnJnlZ1TKbiKPxwQj8wAYxThDg0o
         8QGg==
X-Gm-Message-State: AOAM530ptcRswKvC54Sy3BYKAfBoki/enb7Gyr5oJTfpZd//Z9ZrsKcD
        xCTFoItB4TiciaGrTDEmr2/VL2pekvAuScb7kEaATEgRaY09tucSeFYLFxVGeqeJXJvi/zgEXz6
        85l0iFBpKDPJnEJAelg==
X-Received: by 2002:a17:90a:d50a:b0:1c6:aade:e4b3 with SMTP id t10-20020a17090ad50a00b001c6aadee4b3mr27463096pju.69.1649088949183;
        Mon, 04 Apr 2022 09:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8hSqqfwWFFtf7qIkd/htHSCqRj1izagHMzYbFRJMy9neCkBlruu5NiwjtuZ4l+0l1jweQsA==
X-Received: by 2002:a17:90a:d50a:b0:1c6:aade:e4b3 with SMTP id t10-20020a17090ad50a00b001c6aadee4b3mr27463072pju.69.1649088948900;
        Mon, 04 Apr 2022 09:15:48 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm5194955pjm.13.2022.04.04.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 09:15:48 -0700 (PDT)
Date:   Tue, 5 Apr 2022 00:15:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
Mail-Followup-To: Eric Sandeen <sandeen@sandeen.net>,
        Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
 <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 04, 2022 at 10:36:01AM -0500, Eric Sandeen wrote:
> On 3/21/22 11:19 AM, Zorro Lang wrote:
> > On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> >> Hi folks,
> >>
> >> It's almost 6 years since I've taken the maintainership of fstests, and
> >> I tried my best to keep the pace of weekly update, or at least bi-weekly
> >> update due to something like public holidays.
> >>
> >> But it's been a month since last fstests update due to my personal
> >> urgent issues, and some patches got no review for more than one month.
> >> So I think it's time to re-consider the maintainership of fstests.
> >>
> >> I will have less spare time in the foreseeable future, as I have to
> >> spend more time on my family, so it's hard to keep the weekly update
> >> pace. And six years is a long time, I think it's time to have a new
> >> maintainer.
> > 
> > Hi Eryu,
> > 
> > By thinking about it a while, I get up my courage to apply this job, although I
> > know I'm not the best one can handle this job. Just this project is really
> > useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> > xfstests. It's a great testsuit, which can cover most of our testing. I felt
> > relieved when you toke this maintainer, and admired your courage at that time,
> > that really helps us a lot. No matter what you decide, thanks again for all your
> > help, as previous colleague, as friend.
> 
> Hi Zorro - I'm sure that you would do well as a new maintainer, even if it
> requires some learning. Every new challenge requires learning. :) If you are able
> to balance it with your other tasks, I would be happy to see you take this on,
> if it's something you want to do.
> 
> (See also Darrick's suggestion that maintainer tasks could be split up a bit,
> across the different filesystems.)

Thanks for your trust, Eric. As you said, it'll be a challenge to me, but I'll try
my best if I can have this opportunity.

Thanks,
Zorro

> 
> Thanks,
> -Eric
> 
> > Thanks,
> > Zorro
> > 
> >>
> >> Or we could go to the group-maintain way? As Darrick mentioned before
> >> (for xfs not fstests, if I recall correctly). Then we need a new primary
> >> maintainer :)
> >>
> >> What do you think?
> >>
> >> Thanks,
> >> Eryu
> >>
> >> P.S.
> >> I'll keep the maintainer role and do the review & update as usual until
> >> all things settle down.
> >>
> > 
> 

