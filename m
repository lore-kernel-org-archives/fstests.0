Return-Path: <SRS0=BfoT=2I=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDFC43603
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 20:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A802176D
	for <linux-fstests@archiver.kernel.org>; Wed, 18 Dec 2019 20:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dqs9fSV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRUqc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:46:32 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40236 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfLRUqc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Dec 2019 15:46:32 -0500
Received: by mail-il1-f194.google.com with SMTP id c4so2875804ilo.7
        for <fstests@vger.kernel.org>; Wed, 18 Dec 2019 12:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNh5Gii/np5etuiQaZGw7KfvlHebm4oXazjlac3DtIU=;
        b=Dqs9fSV7WnPeMbo8ebBnJ/YbJWpYCyQNyvnbqOp3p5kgCjWG/RHybUnM/WcGKJvboG
         2eVJlspGyU4lxtl0BlqnK9TgYuRBoz0SbGGM6CQOiXDMqnrHYAhkUUEIqj1sqH2uTWKn
         Bzaqetwa4RcwkJkR59menkD44MPDolkdDl3zZfEbdZUgjBgxkqxdO7nrZuaD2jdx929P
         c5/fncTFK7WxAAJzk4NPfWYSICF40rGVo2diFvvWVfA3MhoQ4P70j0AlmZ40aEJoDR8N
         dPjrlnXtBEuiRxRtuJ2Xda5TbmTp0dOM2b0Qwtd2yc6FIiY95GXHaPdpFjYN814XABph
         CGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNh5Gii/np5etuiQaZGw7KfvlHebm4oXazjlac3DtIU=;
        b=D5Md3lckjua5Q8SmVYOOJ4i2ierL7vdUjb100y/InP+w6ZG1WEJ97PF+A1Kd5I8iHY
         8iVAyXXkrdEf7q50otMBFRfRyq9YHOGqOwrZWQLxkT1yEPh2EC2DeCu+7WQaZgkKFSJu
         sO1l586LfNkusX1tpSv1fpyVpy/2ZqmgJODxRNPmYEP7UqKXqfn6mzmpdrPFwtJbribt
         PTzAlmZvstvRZNYgszyQqEVphWoWaGgUWkxPXFAOaVh1fBVZSOVO10g5E3szpEZleFHq
         Fwiv7YISIfh7OazIyYlyiZ61sDfnvdrjFO7gdyTsURLErUm4vfjEaI/wSAnFOz08OuTS
         Fh9w==
X-Gm-Message-State: APjAAAWzZVMtYAeBCrU7XiPnVnT+43tGYaHoZPD6i8Fx9fiyS+ZHBTPz
        nysd/lMMsgoTX37kbUJvKPyUIUGfEqD7qy7jV+Q=
X-Google-Smtp-Source: APXvYqw1pmqomM6odlYAaW2ryRHJOYAK/0l2WBdHjHVtpYzo5ZMaTsi/qCNqAlDiHWCMzRc0+ALHUSm3eD4n4GNi5Ho=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr3955732ilh.9.1576701991528;
 Wed, 18 Dec 2019 12:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20190719041231.26500-1-deepa.kernel@gmail.com>
 <CAOQ4uxhxVKhUh_P_NffLbGScpiL0wOrCTLwWJWeSbRRNbHzPrg@mail.gmail.com>
 <CABeXuvoHw8W02JsmZjafnQkOs1=0dodSpBFyJ_Gq+1vs+hFkQQ@mail.gmail.com> <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
In-Reply-To: <CABeXuvqO=04BJw2bWa6d2fv1FTe-B_JsNhVdYTwT=fY=ncOCkw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Dec 2019 22:46:20 +0200
Message-ID: <CAOQ4uxjaFBZZUKyu6YS08ta8pdW_FSjRYA4J7S8+_=Gfi-kO2Q@mail.gmail.com>
Subject: Re: [PATCH] generic/402: fix for updated behavior of timestamp limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Dec 18, 2019 at 10:21 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> I looked at this more closely. Here is the patch that added the sysctl
> to the kernel previously: https://lkml.org/lkml/2016/11/2/300.
>
> This was meant to be configurable earlier. That is why this made
> sense. But, now it is not. We unconditionally clamp to the fs limits.
> I looked around to see if we ever expose information about internal
> kernel changes to userspace. This is almost never done. And, this is
> always in the form of maybe a syscall failing. Given that we don't see
> any modified behaviour that the user can point out, I don't think we
> can expose the presence of clamping in the kernel.
>
> fsinfo though exposes a fs max and min that could be useful if we fill
> in an unknown pattern as default:
> https://lwn.net/ml/linux-api/153314004147.18964.11925284995448007945.stgit@warthog.procyon.org.uk/.
>
> I also spoke about this to Arnd, and he also suggested the fsinfo as
> an alternative.
>
> Is it easy to not run the test on older kernels? Otherwise, we just
> have to rely on fsinfo being merged?
>

Is it easy to blacklist the test if that is what you are asking.
How people run their stable kernel tests I don't know.
I believe Sasha is running xfstests to validate stable release
candidate patches.

I don't think there is a clear policy about being friendly to testing
less that master kernels in xfstest (Eryu?), but IMO we should try to
accommodate
this use case, because it is in the best interest of everyone that stable kernel
will be regularly tested with xfstests with as little noisy failures
as possible.

Thanks,
Amir.
