Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8740AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Apr 2022 07:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiDHIAE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDHIAA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Apr 2022 04:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C831012986F
        for <fstests@vger.kernel.org>; Fri,  8 Apr 2022 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649404661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXEyDa5FOo09yHKYjbpe/Wdg3O1bqlUIwwqlv5/iDRI=;
        b=ARCjhArEU5nZbtG4UFLkhEIysI2R6rzPjbMXMu0uNoXoOfZATDsv1io5q8IWzuyGr09gq5
        vWl3WfiggyQYTjELNpyBj6zi+hOdBx3/Y4PB/PWK2SwylKGVfX5UAvqKHq7UiuMeE+SHYf
        vNV6FFPK6E0KmWLC6IcD/GrsFmxrIGQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-gfzwrw1TNkenxAAqVWA8yg-1; Fri, 08 Apr 2022 03:57:39 -0400
X-MC-Unique: gfzwrw1TNkenxAAqVWA8yg-1
Received: by mail-pf1-f197.google.com with SMTP id j67-20020a62c546000000b00505660f065aso2697844pfg.18
        for <fstests@vger.kernel.org>; Fri, 08 Apr 2022 00:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qXEyDa5FOo09yHKYjbpe/Wdg3O1bqlUIwwqlv5/iDRI=;
        b=iAx1KGZKf6Mqy5CVHxUHsSkFMQghl7MDn1G5hiOxMMBDjn2R2GZBCJBnCXKVLXy7kn
         MuqAymXXVY9eyVCd2qLauPKLvJ6CsA/U3h3BHcSRwtK5z7fImeM7UeE4m9ZmULt5polv
         5Ib+hc7qSA9LgwWVb94PegO9kgaJ7/a8RmUHwPetYryiTqIF9lX/GKzivxhNQikwUyeP
         xzij9Fl4Ej43SLqWM/v9ulFLP8xxcbeI9jGP0Y9IFbFHCYuGgOuuXrkBL1spgFSxzNPx
         lRktMajOWHrZFpVdpJIHG6sr1V4Z7rL6kvwgLTxzCp+FSElztlFhiLp1sWzrPCx48Q62
         TXkg==
X-Gm-Message-State: AOAM5301A2Duh0MPB9K+Y1f7kpUwImBsqUBpuxrcodK8+wTs9bhLOJ14
        zaWEQprSJHMvKhaQtnw11S3XfDCt3D4I3TiHPQ+4RVzSKAcuy+o00xOG03ZzGCalSOm7RO49D68
        cWzjjBGDta9aN+woCzn3sw3qTfuZ+Km1muQ==
X-Received: by 2002:a63:4e26:0:b0:386:1839:3bde with SMTP id c38-20020a634e26000000b0038618393bdemr14663745pgb.603.1649404658770;
        Fri, 08 Apr 2022 00:57:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSHiSbmwum1lqm488Sm0lqOBe+RZ69HLu9y5mBxwG7xDrGBhrsjd8XV5Oth9VafoF3Bq6l/SHhDW4tpcdLTlM=
X-Received: by 2002:a63:4e26:0:b0:386:1839:3bde with SMTP id
 c38-20020a634e26000000b0038618393bdemr14663735pgb.603.1649404658506; Fri, 08
 Apr 2022 00:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <Yjdmj0lVqCbbbjW8@desktop> <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
 <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net> <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
In-Reply-To: <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 8 Apr 2022 15:57:27 +0800
Message-ID: <CAHLe9Yb8wTh=7XvQ6LAV3VoJ6voRF3nsVfcPYZV3wAwpA3SFRg@mail.gmail.com>
Subject: Re: maintainership of fstests
To:     Eric Sandeen <sandeen@sandeen.net>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 5, 2022 at 5:50 AM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Apr 04, 2022 at 10:36:01AM -0500, Eric Sandeen wrote:
> > On 3/21/22 11:19 AM, Zorro Lang wrote:
> > > On Mon, Mar 21, 2022 at 01:38:23AM +0800, Eryu Guan wrote:
> > >> Hi folks,
> > >>
> > >> It's almost 6 years since I've taken the maintainership of fstests, and
> > >> I tried my best to keep the pace of weekly update, or at least bi-weekly
> > >> update due to something like public holidays.
> > >>
> > >> But it's been a month since last fstests update due to my personal
> > >> urgent issues, and some patches got no review for more than one month.
> > >> So I think it's time to re-consider the maintainership of fstests.
> > >>
> > >> I will have less spare time in the foreseeable future, as I have to
> > >> spend more time on my family, so it's hard to keep the weekly update
> > >> pace. And six years is a long time, I think it's time to have a new
> > >> maintainer.
> > >
> > > Hi Eryu,
> > >
> > > By thinking about it a while, I get up my courage to apply this job, although I
> > > know I'm not the best one can handle this job. Just this project is really
> > > useful for my team. Nearly from I joined Red Hat, my jobs started to around the
> > > xfstests. It's a great testsuit, which can cover most of our testing. I felt
> > > relieved when you toke this maintainer, and admired your courage at that time,
> > > that really helps us a lot. No matter what you decide, thanks again for all your
> > > help, as previous colleague, as friend.
> >
> > Hi Zorro - I'm sure that you would do well as a new maintainer, even if it
> > requires some learning. Every new challenge requires learning. :) If you are able
> > to balance it with your other tasks, I would be happy to see you take this on,
> > if it's something you want to do.
> >
> > (See also Darrick's suggestion that maintainer tasks could be split up a bit,
> > across the different filesystems.)
>
> Thanks for your trust, Eric. As you said, it'll be a challenge to me, but I'll try
> my best if I can have this opportunity.

As his colleague, I see Zorro's great passion, effort and professional
in the fs area. It's great to me that Zorro goes for this position.

-Boyang

>
> Thanks,
> Zorro
>
> >
> > Thanks,
> > -Eric
> >
> > > Thanks,
> > > Zorro
> > >
> > >>
> > >> Or we could go to the group-maintain way? As Darrick mentioned before
> > >> (for xfs not fstests, if I recall correctly). Then we need a new primary
> > >> maintainer :)
> > >>
> > >> What do you think?
> > >>
> > >> Thanks,
> > >> Eryu
> > >>
> > >> P.S.
> > >> I'll keep the maintainer role and do the review & update as usual until
> > >> all things settle down.
> > >>
> > >
> >
>

