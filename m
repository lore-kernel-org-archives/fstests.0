Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704EC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Sep 2021 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E4C610F9
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Sep 2021 14:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhICOnu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349502AbhICOnt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Sep 2021 10:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630680168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEFnIURrP2vwLaJ5HTfs71djy1e9bipR/GQhDMVx0Ic=;
        b=VbN24Dd7hdQzwqP1Gnfv7GP53QXIF57pH2qPtzGsZwcP0SmrwKVGFpxEqhq/RT4/vixXW9
        lyHi+c2tyECi5S6YyI9s59LfO7UCGtl0xxyKDoZTgVpgSXgn2gNaIh5Whc1D8Z6y8IEmWF
        b/ZlXCXHC3sAU6rJ65qarOnkYg6bnQw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293--r83MZp-NS60Ez8Vsgh53Q-1; Fri, 03 Sep 2021 10:42:45 -0400
X-MC-Unique: -r83MZp-NS60Ez8Vsgh53Q-1
Received: by mail-il1-f198.google.com with SMTP id l4-20020a92d8c40000b02902242b6ea4b3so3643217ilo.8
        for <fstests@vger.kernel.org>; Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEFnIURrP2vwLaJ5HTfs71djy1e9bipR/GQhDMVx0Ic=;
        b=ArdS+6LYzjitKQ5sboMbTmpBtu4UdjN0qTEnd1eWJCHP55Ef0yq8j4y/bUSmTRV6iJ
         EU9MaUvBAZrcUd6jNOdOiWBSTxpt/KrBVL7mnTgTlbhu4B8Hz3vRDy4BEIbescUftnFb
         Mv+Kwtsdz/roHOf/P+/Y9u3YydJ+UgiAQkj6pdD+FaV3MllSLN20wz7bP9eVlWt4EA3R
         9slt4YfZ+XOJvH8BzVT1c4q+T8/k18z/2zY68zo3qkzhtpofRAbeX2L3SPcsfGdfK295
         Au3c0jmaPkxCIpQWN9SKmwzHs71Unu5o599tbOqjWH8RsXg5b87Hbn+5VKKSVfDKDxbN
         lSYg==
X-Gm-Message-State: AOAM532qUZZzVgH0IvAezZcKxZ5QeSDLhtQG3wN38p90CHK52Dc5hVXm
        kmXmVsUq75FdmYCfPIY2aQ84XGjqXJ6HMd7z0eZwMpotpVL8LTP0IjQpzeEXgli2VuchYOM2Es9
        szgAQCgfqCTaihY1gzL16fu2XYkOIMXTvkg==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr2910875ilk.108.1630680165301;
        Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9AT6fUQTezOFBvhyEPkIypPYE9orVd8STwsCxlacI9c6iwGMMi7S2j+q9xU7COfmaPZaiMz+DVo3Ee2EyNoY=
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr2910849ilk.108.1630680165078;
 Fri, 03 Sep 2021 07:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com> <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
In-Reply-To: <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
From:   Bruce Fields <bfields@redhat.com>
Date:   Fri, 3 Sep 2021 10:42:34 -0400
Message-ID: <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Well, we could also look at supporting trusted.* xattrs over NFS.  I
don't know much about them, but it looks like it wouldn't be a lot of
work to specify, especially now that we've already got user xattrs?
We'd just write a new internet draft that refers to the existing
user.* xattr draft for most of the details.

--b.

On Fri, Sep 3, 2021 at 2:56 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > xfstests: generic/062: Do not run on newer kernels
> > >
> > > This test has been written with assumption that setting user.* xattrs will
> > > fail on symlink and special files. When newer kernels support setting
> > > user.* xattrs on symlink and special files, this test starts failing.
> >
> > It's actually a good thing that this test case triggers for the kernel
> > change you're proposing; that change should never be merged. The
> > user.* namespace is meant for data with the same access permissions as
> > the file data, and it has been for many years. We may have
> > applications that assume the existing behavior. In addition, this
> > change would create backwards compatibility problems for things like
> > backups.
> >
> > I'm not convinced that what you're actually proposing (mapping
> > security.selinux to a different attribute name) actually makes sense,
> > but that's a question for the selinux folks to decide. Mapping it to a
> > user.* attribute is definitely wrong though. The modified behavior
> > would affect anybody, not only users of selinux and/or virtiofs. If
> > mapping attribute names is actually the right approach, then you need
> > to look at trusted.* xattrs, which exist specifically for this kind of
> > purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> > That's unfortunate, but not an acceptable excuse for messing up user.*
> > xattrs.
>
> Another possibility would be to make selinux use a different
> security.* attribute for this nested selinux case. That way, the
> "host" selinux would retain some control over the labels the "guest"
> uses.
>
> Thanks,
> Andreas
>

