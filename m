Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BADAC43219
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Apr 2022 09:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiDEJZd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344126AbiDEJSS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Apr 2022 05:18:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C4C3AA43
        for <fstests@vger.kernel.org>; Tue,  5 Apr 2022 02:04:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gt4so5361753pjb.4
        for <fstests@vger.kernel.org>; Tue, 05 Apr 2022 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bXR8Uew6yDEb902NrhXtG4pmSpwVDw5uXNU/pd70qZ0=;
        b=ZI8Stqrs3CkXn97fpNGisOqEZA4aqt7E4r8MZ6t91FqACikvKTZ5ANU9w87rIrSTHb
         gNndH7AiUlKx7YxsVnSE3q1SQpdzKkw0MOQQygUVAAerHox6WGHK86G6JuZFOxDVr6up
         +40vVCrrStKb/6ipBQCCtyqM/UCKItGo7uITM2AHWtTPV7yAEkEDmQbHUmjNRglp8gMR
         J2htSsYFw2MOcgpA+McIr7/FdQZ3u7x2gOf0sgIZVclFdKfKKWzayg70AF55kUP4r4T8
         5AratlEH+N2uwgquAD44TdvHZgWl42o35l7yaS1m3GRpwNzst8A4ZVVNx8cYZWHzR3gi
         LCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXR8Uew6yDEb902NrhXtG4pmSpwVDw5uXNU/pd70qZ0=;
        b=q811UMC+RtDi3jNsBp/Qt7BIaqzfVLAQNmrslyPYwG4afazW+terRWlBVD6lQ1K6RH
         lhvtYIEdWz7JFflSqlmlRBhkhig/XG+B3ZnkH01XFXrbxR95JolBluVe9/5P8csAjstE
         bxtgH1XqgYSZ7+qhBN4y60NUMxk/b4wIWicVZQrQAh/NPZ31dpLCrtvuySA62Fk1NJ9+
         fsLDtNhrz8vVpzguz9bF80asOuT/cui8ZlYkSokS63CAkuBjQ8zLy4rYnFywscjC91G7
         k1Ym0MR0XlmBDrevVbJdYhVMLTRCVzqd1i52D4r8npOalYG9KIFUZbGPsoUi5FMXvLhH
         RlEg==
X-Gm-Message-State: AOAM533G7bvDdWFQV9iryhSY3lwDPnWQ561donx4zXsfglsNUX8vOUSM
        +hpcCkyGlDuO2oK0fgZPHY1aFTWLTwg=
X-Google-Smtp-Source: ABdhPJyjqAwzflZFzsMaNRPGdz0W2Jh5IVkCwseJPEdhehgVoDpodexoAW3S3FnaEa2yzDTstdyZZg==
X-Received: by 2002:a17:90a:4882:b0:1c5:f4e2:989a with SMTP id b2-20020a17090a488200b001c5f4e2989amr2936790pjh.160.1649149463516;
        Tue, 05 Apr 2022 02:04:23 -0700 (PDT)
Received: from localhost ([2406:7400:63:792d:bde9:ddd5:53e9:ed83])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm1692102pjf.32.2022.04.05.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 02:04:23 -0700 (PDT)
Date:   Tue, 5 Apr 2022 14:34:18 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Eric Sandeen <sandeen@sandeen.net>, Eryu Guan <guaneryu@gmail.com>,
        fstests@vger.kernel.org
Subject: Re: maintainership of fstests
Message-ID: <20220405090418.axfo5b7g7fijlxob@riteshh-domain>
References: <Yjdmj0lVqCbbbjW8@desktop>
 <20220321161935.46g3n22wbv5bfnyq@zlang-mailbox>
 <f73b9664-d3fc-0b95-e458-27860d87287a@sandeen.net>
 <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404161544.oosbjrnw4muu6y3p@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 22/04/05 12:15AM, Zorro Lang wrote:
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

Awesome!! :)

-ritesh
