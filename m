Received: from mx1.redhat.com ([209.132.183.28]:44477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbcCXNRZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 24 Mar 2016 09:17:25 -0400
Date: Thu, 24 Mar 2016 21:17:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common: make sure dm error device is all settled before
 removing it
Message-ID: <20160324131722.GV11419@eguan.usersys.redhat.com>
References: <1458821311-18968-1-git-send-email-eguan@redhat.com>
 <CAL3q7H47cu7zwu43TzZ=VyzVYrY8U5HGPR_pmNfk_HkQ3hyUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H47cu7zwu43TzZ=VyzVYrY8U5HGPR_pmNfk_HkQ3hyUCg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 24, 2016 at 12:34:55PM +0000, Filipe Manana wrote:
> On Thu, Mar 24, 2016 at 12:08 PM, Eryu Guan <eguan@redhat.com> wrote:
> > _dmerror_cleanup() may fail to remove error-test device due to EBUSY and
> > cause subsequent tests to fail.
> >
> > Fix it by calling $UDEV_SETTLE_PROG before remove error-test device to
> > make sure no one is using it.
> 
> I often get the same problem with _cleanup_flakey.
> Would you be doing the same for flakey in this or another patch?

I'm going to fix them in one patch.

> 
> >
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks!

Eryu

> 
> > ---
> >  common/dmerror | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/common/dmerror b/common/dmerror
> > index 004530d..5d2c1b6 100644
> > --- a/common/dmerror
> > +++ b/common/dmerror
> > @@ -54,6 +54,9 @@ _dmerror_unmount()
> >  _dmerror_cleanup()
> >  {
> >         $UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> > +       # wait for device to be fully settled so that 'dmsetup remove' doesn't
> > +       # fail due to EBUSY
> > +       $UDEV_SETTLE_PROG >/dev/null 2>&1
> >         $DMSETUP_PROG remove error-test > /dev/null 2>&1
> >  }
> >
> > --
> > 2.5.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> "Reasonable men adapt themselves to the world.
>  Unreasonable men adapt the world to themselves.
>  That's why all progress depends on unreasonable men."
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
