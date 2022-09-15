Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47AECAAA1
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Sep 2022 05:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIOF3C (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOF3B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Sep 2022 01:29:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AD86B4D
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 22:29:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w20so5197525ply.12
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XeiF3itndil52WCfDPcqExThAPqwQ8cmP6L31xcu8zA=;
        b=GGqTCcHoXieNVHTowDp8qY/g5LH4+O10xbDQnWzFc4Mjoq04HqZcuudYevR5/bjNbH
         NJVHgpJA9kwCi52lOD8YctOdKc/gXl4VKam62JZJLlYq3+caTC/BrXy00eKTZ6cjkRqe
         PdcdhfzcolOogSr0jHL7iAKjSkFGvzAWSnyKVH8cnk2Y6Zf2pyWq/EFKilmlNdRX/fYa
         fAOdbis2g8cAPC1ILgjiCx/iN/NYLfZe551VOd7JMCeEbLY1hfb2DzmtnWLk/vgip2GK
         5Mij4OUkCadZ1xebQEbZmw2NiW/wkcJDb0favJerHmcr1mArJW4zLHTdI0Yx/XbzZfu/
         GeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XeiF3itndil52WCfDPcqExThAPqwQ8cmP6L31xcu8zA=;
        b=UxVL5Kgvi13E9YjvHXm+e8+PiMB9nc75DCn9DMwntNzmHjMJCLv4q0bkA2lhiZLPQX
         JB0HQv3wcmbAVNu4UlFtWcLt4Wvz/si/NXY3dwLer7ABrNEkN4Le7LQWOwAg1jtrzVuM
         +xcTx+Kb95SfazKcD5WmKzHkYrVJVx325u9ew6ZGiFfVQgavPKE9Wo2d5IiQA0v/eMf+
         fOy32w1DOXCqFGyKKoXEBj7BotLEYWy4lKlgtln6ve3QROf1R2TkLo8VK15rMoGdvvPu
         qyqueN2zkZUgIbC5Acah0Zc8yFb5CbwZnvGjo2vX1kqLJFTBluAFGotD8JeuJWmDMZch
         uIpg==
X-Gm-Message-State: ACrzQf38ZBn3/PM6WsCeUda7Psd+qVIWwbdSOtoXOgKobc4yzs1l/M8i
        H57k+Qphj5R5Yhd3cuQvR03JEcL620K/MGERh9U=
X-Google-Smtp-Source: AMsMyM6dBxrcFowwZ/ZlGXLuhafBg8FFpWIsSPLiJL4RdYaSJJAxCLRupcdqF8byCVPG/H4mP0jRo8kww0Tdx5jyd8w=
X-Received: by 2002:a17:90b:14d2:b0:202:dd9c:4e98 with SMTP id
 jz18-20020a17090b14d200b00202dd9c4e98mr8629182pjb.62.1663219740623; Wed, 14
 Sep 2022 22:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220914090610.1994485-1-jencce.kernel@gmail.com>
 <20220914090610.1994485-2-jencce.kernel@gmail.com> <20220914152439.co7zcvfzngdzw3gc@zlang-mailbox>
In-Reply-To: <20220914152439.co7zcvfzngdzw3gc@zlang-mailbox>
From:   Murphy Zhou <jencce.kernel@gmail.com>
Date:   Thu, 15 Sep 2022 13:28:48 +0800
Message-ID: <CADJHv_u89LnUN6nS9Q5FD37pAh1qrxXB9UTU3nRiso=2YHRekA@mail.gmail.com>
Subject: Re: [PATCH 2/2] common/quota: fix grep pattern
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 14, 2022 at 11:24 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Sep 14, 2022 at 05:06:10PM +0800, Murphy Zhou wrote:
> > The second dash is not needed now. Newer grep is complaining:
> > +grep: warning: stray \ before -
> >
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  common/quota | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/quota b/common/quota
> > index 22be3c69..01ff7e6d 100644
> > --- a/common/quota
> > +++ b/common/quota
> > @@ -218,7 +218,7 @@ _qmount()
> >          quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
> >          quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
> >          # try to turn on project quota if it's supported
> > -        if quotaon --help 2>&1 | grep -q '\-\-project'; then
> > +        if quotaon --help 2>&1 | grep -q '\--project'; then
>
> Yeah, I can reproduce the problem [1] you said. But I'm wondering if using
> "--" [2] might be better to be compatible with old and new grep ?

Agree! Thanks!

>
> Thanks,
> Zorro
>
> [1]
>   # quotaon --help 2>&1|grep '\--project'
>   -P, --project            operate on project quotas
>   # quotaon --help 2>&1|grep '\-\-project'
>   grep: warning: stray \ before -
>   -P, --project            operate on project quotas
>
> [2]
>   quotaon --help 2>&1 | "grep -q -- '--project'
>
> >              quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
> >          fi
> >      fi
> > --
> > 2.31.1
> >
>
