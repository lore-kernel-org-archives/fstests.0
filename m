Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:25925 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfCGUWT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 15:22:19 -0500
Date: Fri, 8 Mar 2019 07:22:14 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power failure
Message-ID: <20190307202214.GH26298@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
 <20190306050049.GA23020@dastard>
 <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
 <20190306221202.GG26298@dastard>
 <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chao Yu <yuchao0@huawei.com>, fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Filipe Manana <fdmanana@gmail.com>, Jayashree Mohan <jaya@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 07, 2019 at 09:12:06AM +0200, Amir Goldstein wrote:
> On Thu, Mar 7, 2019 at 12:12 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Mar 06, 2019 at 09:44:54AM +0200, Amir Goldstein wrote:
> > > > > >
> > > > > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > > > > and generic/311.
> > > > > >
> > >
> > > Right now 311 is not "quick".
> > > That means adding quick tests to it without breaking it up or declaring it quick
> > > is not a good idea.
> >
> > Why would we need to change the group? Indeed, I almost never use
> > the "quick" group anymore because it doesn't mean "quickly run a
> > smoke test" anymore. It now just means "test doesn't take a long
> > time" but that still adds up to 30-60 minutes of runtime (depending
> > on storage) because of the hundreds of tests in the quick group.
> >
> > If you are testing crash recovery changes, then you are likely
> > running the "log" group to execute all the crash recovery tests,
> > maybe the "metadata" group, and maybe the "shutdown" group.
> >
> > So I don't think the this test not being in the "quick" group is
> > relevant at all.
> >
> 
> OK. Just pointing your attention to the fact that the test generic/520
> is a result of public discussion of how crash consistency tests should
> be aggregated into xfstests tests.

That was about how the crashmonkey tests would be integrated, not
generic fsync tests should be integrated.  There lots of
auto-generated crashmonkey tests them and they were proposing a
single fs test per single fsync test. We ended up settling  on
"aggregating into related groups" and generic/520 only covers one
specific group - only about 5 test cases of the many, many
crashmonkey test cases that were proposed. Which leaves me to
ponder: what happened to the rest of the Crashmonkey test cases that
were supposed to follow on from generic/520?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
