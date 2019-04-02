Received: from mx1.redhat.com ([209.132.183.28]:36916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfDBI3a (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 04:29:30 -0400
Date: Tue, 2 Apr 2019 04:29:29 -0400 (EDT)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <2070529038.372776.1554193769718.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5mt=ffwygAmeuHGtNCbDXAzJ3f+V1Xeaw=S=MmaQKRkHLA@mail.gmail.com>
References: <20190331123130.14922-1-xifeng@redhat.com> <CAH2r5mspi108y=4wkKWxQno+WGJnEOrWOGWL9KqSucF6fULG0g@mail.gmail.com> <CAH2r5mt=ffwygAmeuHGtNCbDXAzJ3f+V1Xeaw=S=MmaQKRkHLA@mail.gmail.com>
Subject: Re: [PATCH v2] common/rc: add global mounted option for
 _scratch_remount
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


Thanks Steve for the feedback.

----- Original Message -----
> From: "Steve French" <smfrench@gmail.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>, fstests@vger.kernel.org
> Sent: Tuesday, April 2, 2019 8:33:12 AM
> Subject: Re: [PATCH v2] common/rc: add global mounted option for _scratch_remount
> 
> And 306 also works with cifs (as long as mounting with "sfu" mount
> option) with this patch
> 
> On Mon, Apr 1, 2019 at 10:29 AM Steve French <smfrench@gmail.com> wrote:
> >
> > I also verified that test 452 now works to cifs (SMB3 mounts to
> > multiple types of test targets, Azure, Windows etc.)
> >
> > On Sun, Mar 31, 2019 at 7:31 AM XiaoLi Feng <xifeng@redhat.com> wrote:
> > >
> > > From: Xiaoli Feng <xifeng@redhat.com>
> > >
> > > When call _scratch_remount for cifs , it always requires to input
> > > password. This will make generic/306 generic/452 failed because
> > > cifs remount failed.
> > > ---
> > >  common/rc | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/common/rc b/common/rc
> > > index 1c42515f..ea1eaf6a 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -357,7 +357,7 @@ _scratch_remount()
> > >      local opts="$1"
> > >
> > >      if test -n "$opts"; then
> > > -       mount -o "remount,$opts" $SCRATCH_MNT
> > > +       mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT
> > >      fi
> > >  }
> > >
> > > --
> > > 2.18.1
> > >
> >
> >
> > --
> > Thanks,
> >
> > Steve
> 
> 
> 
> --
> Thanks,
> 
> Steve
> 
