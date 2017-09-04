Received: from aserp1040.oracle.com ([141.146.126.69]:34914 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbdIDRca (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Sep 2017 13:32:30 -0400
Date: Mon, 4 Sep 2017 10:32:19 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] kvm-xfstests: use aio=native for test drives
Message-ID: <20170904173219.GE4660@magnolia>
References: <1504527328-24615-1-git-send-email-amir73il@gmail.com>
 <20170904155550.GC4660@magnolia>
 <CAOQ4uxh6PyCtyYvTmHFA7R6_E=nv1Kg52eEier=OcRf0wR2zag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh6PyCtyYvTmHFA7R6_E=nv1Kg52eEier=OcRf0wR2zag@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Eryu Guan <eguan@redhat.com>, Josef Bacik <jbacik@fb.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 04, 2017 at 08:11:31PM +0300, Amir Goldstein wrote:
> On Mon, Sep 4, 2017 at 6:55 PM, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Mon, Sep 04, 2017 at 03:15:28PM +0300, Amir Goldstein wrote:
> >> Lost IOs have been observed with the default aio=threads with
> >> QEMU 2.5.0 when running crash consistency tests.
> >> The issue has not been observed with QEMU 2.9.0.
> >> Native AIO is probably better for our goal which is test proofing
> >> production systems.
> >>
> >> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >> ---
> >>
> >> Ted,
> >>
> >> Not sure you have been following the crash consistency tests threads.
> >>
> >> Anyway, I ran into an issue of sucessfuly completed bio's that
> >> did not make it to storage device when running in kvm-xfstests.
> >>
> >> Josef reported that he did not observe the issue with newer QEMU
> >> and the issue is gone with aio=native on my version of QEMU.
> >>
> >> Crash consistency tests still can't run properly on kvm-xfstests
> >> without this fix to kernel:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?h=dm-log-writes-fixes&id=08c7d64773091c7d2e0147da7064aa4dc297629d
> >> After the fix is merged I will post a patch to enable running
> >> dm-log-write tests in kvm-xfstest.
> >>
> >> Mean while, the change to aio=native seems like a good move
> >> anyway and if I observed a bio black hole in one test, who's to say
> >> they don't exist for other tests as well.
> >>
> >> Amir.
> >>
> >>
> >>  kvm-xfstests/kvm-xfstests | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
> >> index 305e2f5..98bd76a 100755
> >> --- a/kvm-xfstests/kvm-xfstests
> >> +++ b/kvm-xfstests/kvm-xfstests
> >> @@ -101,15 +101,22 @@ chmod 400 "$VDH"
> >>
> >>  mkdir -p /tmp/kvm-xfstests-$USER
> >>
> >> +# Lost IOs have been observed with the default aio=threads with
> >> +# QEMU 2.5.0 when running crash consistency tests.
> >
> > Note however that Ubuntu 16.04 LTS is still on qemu 2.5, so perhaps
> > it's worth the trouble to check the qemu version prior to enabling
> > native aio support?
> >
> 
> hmm.. I am using Ubuntu 16.04/QEMU 2.5
> that is why I am posting this patch
> 
> The default aio=threads is allegedly buggy on QEMU 2.5
> so I am proposing to always use aio=native,
> which is probably the right configuration for several other reasons

D'oh, you're right, I got that whole thing backwards.  Ignore my noise.

--D

> 
> Amir.
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
