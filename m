Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5725C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 12:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbiC3MLj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbiC3MGM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 08:06:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB192F395
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 05:04:05 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b18so17780542qtk.13
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 05:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGxRoWbK0o7CgH+3JuY4noXrg9iNRnbkocCXQDyx1Ug=;
        b=WOO0G/16UntvX7ihdI5WgjC6kOOtWnxfXgDCmbSidk//SFRH9jk2f6TNwUcOEXDS7U
         kYZPl0jfJjJU19MElkX7lEqJlrES3hIZJ1Qsh56S//Q4aFD5kJc6ReT04KC9R4ss7HBP
         dYWL2Qe6eJodCqsC++2MitLjZtiX+O4wyraiYz1bxtdqeYUCf0A+ah2+93hTufeKK9jn
         m7ItVAg3htecslOREVieto+MaSUi4VFSRi3fc4Vaa3HCXZRBnI/KtUCVkTCPG/uB3wp/
         mSgs6c1703QAza434vRWvwSLL2moNxMYQINJqZ14TmiZ7EqD4rFMwTBmQYO3V8SIuD2x
         mGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGxRoWbK0o7CgH+3JuY4noXrg9iNRnbkocCXQDyx1Ug=;
        b=N4WSCBM0gfqxXuo50ipyN2QnfpZntGIqbzxzKyw0CV+FLedUDgcotznROAHeyBhpGs
         JsCG7+1hngY7ibwRDoJHD7fbRU1a66Sp58PwVvpGTm0GPrR91YgMDGXKwifculLf5Q7H
         E70tXGbFJXd7hixGUetpa1eK3e7AjVoxW4W8gr25LbMidS5Xc8t3lqjFYVjDPTarkhKF
         cvYthNwNiDrVrpFnQMWtNQvBcUdYG0LjJ21osjD5bVcAmAQGWRC+9gc8EBoTD5hhKcz1
         REwVywqox/9IQef2W1MYNinOajEeNs+RXfepiRdWo2c3Euntl1FaZdz4xqceE+roCp4X
         VugA==
X-Gm-Message-State: AOAM531F/flrr6w99M+ZKgSFk7niKCnRBFKtss32y0uvRglcFUNFl3uB
        /6S+PjUMaCBReyFkpfERQRPDyOK7NzEqybqwAGyy+HKXR58=
X-Google-Smtp-Source: ABdhPJx3NlTRIhnxXI1Lc4Xmi9FT24zWtNP8al43Rq3YlU6rZNB+lQve6FJTWSKVDKKyw/S6OwNxojIiLUYSstNV35E=
X-Received: by 2002:a05:622a:18a4:b0:2e1:e7a5:98ba with SMTP id
 v36-20020a05622a18a400b002e1e7a598bamr32674953qtc.424.1648641844691; Wed, 30
 Mar 2022 05:04:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220330102409.1290850-1-brauner@kernel.org> <20220330102409.1290850-21-brauner@kernel.org>
 <CAOQ4uxid3vxXpxL25XNp7OWy9OjumHtSm7Zw3TEXO5_UHFRjnA@mail.gmail.com> <20220330113824.3vbjsi4zxsoh5nfx@wittgenstein>
In-Reply-To: <20220330113824.3vbjsi4zxsoh5nfx@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Mar 2022 15:03:53 +0300
Message-ID: <CAOQ4uxg7OWJK5rJpxsvOYZwrtSOKyWO-AcjXM2HS7aVj_Xc+fQ@mail.gmail.com>
Subject: Re: [PATCH v2] common: allow to run all tests on idmapped mounts
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 30, 2022 at 2:38 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Mar 30, 2022 at 02:10:11PM +0300, Amir Goldstein wrote:
> > On Wed, Mar 30, 2022 at 1:26 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > In addition to the generic and filesystem-specific idmapped mount
> > > testsuites that already exist upstream today add simple infrastructure
> > > so any test can be run on idmapped mounts simply by setting
> > > IDMAPPED_MOUNTS=true in the config file or section. The main user for
> > > now will be overlay to verify it works correctly on idmapped mounts.
> > >
> >
> > It is not clear from this message how IDMAPPED_MOUNTS=true affects
> > non -overlay runs and the answer is complicated:
> >
> > You handled the majority of cases using _test_mount and _scratch_mount
> > but there are still many tests that open code _mount and some helpers
> > like _dmthin_mount that are used quite often.
>
> I verified that actually for testing overlay. _dmthin_mount is used in 8
> tests (btrfs/196, generic/347, generic/405, generic/455, generic/457,
> generic/470, generic/482, generic/500). None of them were run in a
> regular testrun on the 5.17 base kernel.
> Direct _mount calls in the generic/ testsuite are 8 (generic/042,
> generic/081, generic/108, generic/361, generic/459, generic/563,
> generic/620, geneirc/649).
> Again, none of them were run in a regular testrun on the 5.17 base
> kernel. Let alone that for most of them conversion to be tested on
> idmapped mounts didn't make sense.
>

Yes of course, overlayfs tests cannot call _mount directly
so your tests with check -overlay should be perfectly fine.
My comment is only addressing the *generic* implementation
of IDMAPPED_MOUNTS.

> >
> > So either document that IDMAPPED_MOUNTS=true will idmapp the
> > fs mounts whenever it can as best effort, or restrict the use of
> > IDMAPPED_MOUNTS=true with OVERLAY=true for now.
>
> Just to clarify, the test patch will be upstreamed independently. It is
> included here so people can run xfstests right away if they are
> interested.
>
> The infrastructure is completely generic so every filesystem that
> supports idmapped mounts can simply run all of their tests idmapped. But
> there will be corner-cases. For example, xfs doesn't allow bulkstat on
> idmapped mounts because it is a filesystem wide operation, i.e. you can
> retrieve information for any inode in the filesystem so the operation
> cannot be scoped reasonably under a single mount. So xfstests testing
> bulkstat will fail as it's blocked. Similar for some btrfs ioctl()s.
>
> We could of course restrict this testmode to -overlay for which we know
> things work correctly but that I don't like that as this means that
> people won't start using it and so we won't see issues unless someone
> sits down and goes through all 750+ tests and figures out for each
> individual one why it fails the way it fails.
>
> I'd rather not restrict the generic infrastructure so people can run and
> report failures and we can fix them up or block them as we detect them.
> So I'd rather just point that out in the commit message, I think.
>

Yes this makes perfect sense to me.

The failing bulkstat tests are exactly why we would want to let
people start testing their fs, it's the false negatives that I am worried
about. all the tests that use _dmthin_mount() will succeed without
the tester knows that idmalleped was not tested and its going to
be hard to audit all the callers of _mount, so either you make
_mount a wrapper to __mount or I don't know what.
Maybe you'll think of something wiser to do.

Thanks,
Amir.
