Received: from mail-yw1-f66.google.com ([209.85.161.66]:41188 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGHMS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 02:12:18 -0500
Received: by mail-yw1-f66.google.com with SMTP id q128so12480953ywg.8
        for <fstests@vger.kernel.org>; Wed, 06 Mar 2019 23:12:17 -0800 (PST)
MIME-Version: 1.0
References: <20190305114744.129633-1-yuchao0@huawei.com> <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com> <20190306050049.GA23020@dastard>
 <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com> <20190306221202.GG26298@dastard>
In-Reply-To: <20190306221202.GG26298@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2019 09:12:06 +0200
Message-ID: <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Chao Yu <yuchao0@huawei.com>, fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@gmail.com>, Jayashree Mohan <jaya@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 7, 2019 at 12:12 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Mar 06, 2019 at 09:44:54AM +0200, Amir Goldstein wrote:
> > > > >
> > > > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > > > and generic/311.
> > > > >
> >
> > Right now 311 is not "quick".
> > That means adding quick tests to it without breaking it up or declaring it quick
> > is not a good idea.
>
> Why would we need to change the group? Indeed, I almost never use
> the "quick" group anymore because it doesn't mean "quickly run a
> smoke test" anymore. It now just means "test doesn't take a long
> time" but that still adds up to 30-60 minutes of runtime (depending
> on storage) because of the hundreds of tests in the quick group.
>
> If you are testing crash recovery changes, then you are likely
> running the "log" group to execute all the crash recovery tests,
> maybe the "metadata" group, and maybe the "shutdown" group.
>
> So I don't think the this test not being in the "quick" group is
> relevant at all.
>

OK. Just pointing your attention to the fact that the test generic/520
is a result of public discussion of how crash consistency tests should
be aggregated into xfstests tests.

I must say that I like the result in generic/520 much better than I like
generic/311, because of its readability - it is easier to see which test
cases are covered.

Thanks,
Amir.
