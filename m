Received: from mx1.redhat.com ([209.132.183.28]:57850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeADIUa (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 Jan 2018 03:20:30 -0500
Date: Thu, 4 Jan 2018 16:20:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3] ext4/030: Ext4 online resize with bigalloc tests.
Message-ID: <20180104082028.GA5123@eguan.usersys.redhat.com>
References: <20171101001159.88570-1-harshads@google.com>
 <20180104011801.10141-1-harshads@google.com>
 <CAOQ4uxguExYyi4gkDmAedgQcCSXSucG3_nP4YzT0x9AbqTNJxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxguExYyi4gkDmAedgQcCSXSucG3_nP4YzT0x9AbqTNJxA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>, harshads <harshads@google.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 04, 2018 at 10:09:08AM +0200, Amir Goldstein wrote:
> On Thu, Jan 4, 2018 at 3:18 AM, harshads <harshads@google.com> wrote:
> > Add tests to verify Ext4 online resizing feature with bigalloc feature
> > enabled. We test various resizing scenarios with different cluster
> > sizes.
> >
> > Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> > ---
> >  common/rc          |  23 ++++++++
> >  tests/ext4/030     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/030.out | 148 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/group   |   1 +
> >  4 files changed, 330 insertions(+)
> >  create mode 100755 tests/ext4/030
> >  create mode 100644 tests/ext4/030.out
> >
> > diff --git a/common/rc b/common/rc
> > index 9216efdb..052dadae 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1845,6 +1845,29 @@ _require_scratch_ext4_feature()
> >      _scratch_unmount
> >  }
> >
> > +# Check whether the specified feature whether it is supported by
> > +# mkfs.ext4 and the kernel by using a sparse file image.
> > +_require_ext4_feature()
> 
> 1. please explain why this loop variant is needed
> 2. it would be great if you could also change callers to
> _require_scratch_ext4_feature
>     to use _require_scratch_feature and plug
> _require_scratch_ext4_feature in there
> 3. probably best to post this as a separate patch from the test itself

I haven't went through the whole patch yet, just want to point out that
the _require_scratch_ext4_feature helper has been added in commit
be341e36fd02 ("common: rework _require_ext4_mkfs_feature"), but not
enabled in the more generic _require_scratch_feature helper yet.

It'd be good to plug the ext4 helper to the generic helper in a separate
patch, as Amir suggested, and perhaps converting all existing callers of
the ext4 helper to the generic helper.

Thanks,
Eryu

> 
> > +{
> > +    if [ -z "$1" ]; then
> > +        echo "Usage: _require_loop_ext4_feature feature"
> 
> So which is it, _require_loop_ext4_feature or _require_ext4_feature?
> First one sounds better to me, given that you explain why the loop
> variant is needed.
> If it is needed, will it be useful to have for other fs?
> Then better implement _require_loop_feature and make ext4
> a specific case.
> 
> Cheers,
> Amir.
