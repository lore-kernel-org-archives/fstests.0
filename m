Received: from mail-ua1-f65.google.com ([209.85.222.65]:42931 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGUmR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 15:42:17 -0500
Received: by mail-ua1-f65.google.com with SMTP id s26so10652975uao.9
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2019 12:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20190305114744.129633-1-yuchao0@huawei.com> <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com> <20190306050049.GA23020@dastard>
 <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
 <20190306221202.GG26298@dastard> <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
 <20190307202214.GH26298@dastard>
In-Reply-To: <20190307202214.GH26298@dastard>
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Thu, 7 Mar 2019 14:42:05 -0600
Message-ID: <CA+EzBbCT4Xz+1aQ5r2kgp8_YaSu3=HsCSsLpVchOQR4oe54oiw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] generic: test i_mode recovery after power failure
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>, fstests <fstests@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Eryu Guan <guaneryu@gmail.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

We will submit patches for the rest of the tests soon. We are working on it.

Thanks,
Jayashree Mohan


Thanks,
Jayashree Mohan



On Thu, Mar 7, 2019 at 2:22 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Mar 07, 2019 at 09:12:06AM +0200, Amir Goldstein wrote:
> > On Thu, Mar 7, 2019 at 12:12 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Wed, Mar 06, 2019 at 09:44:54AM +0200, Amir Goldstein wrote:
> > > > > > >
> > > > > > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > > > > > and generic/311.
> > > > > > >
> > > >
> > > > Right now 311 is not "quick".
> > > > That means adding quick tests to it without breaking it up or declaring it quick
> > > > is not a good idea.
> > >
> > > Why would we need to change the group? Indeed, I almost never use
> > > the "quick" group anymore because it doesn't mean "quickly run a
> > > smoke test" anymore. It now just means "test doesn't take a long
> > > time" but that still adds up to 30-60 minutes of runtime (depending
> > > on storage) because of the hundreds of tests in the quick group.
> > >
> > > If you are testing crash recovery changes, then you are likely
> > > running the "log" group to execute all the crash recovery tests,
> > > maybe the "metadata" group, and maybe the "shutdown" group.
> > >
> > > So I don't think the this test not being in the "quick" group is
> > > relevant at all.
> > >
> >
> > OK. Just pointing your attention to the fact that the test generic/520
> > is a result of public discussion of how crash consistency tests should
> > be aggregated into xfstests tests.
>
> That was about how the crashmonkey tests would be integrated, not
> generic fsync tests should be integrated.  There lots of
> auto-generated crashmonkey tests them and they were proposing a
> single fs test per single fsync test. We ended up settling  on
> "aggregating into related groups" and generic/520 only covers one
> specific group - only about 5 test cases of the many, many
> crashmonkey test cases that were proposed. Which leaves me to
> ponder: what happened to the rest of the Crashmonkey test cases that
> were supposed to follow on from generic/520?
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
