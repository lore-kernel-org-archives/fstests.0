Received: from mail-pf1-f193.google.com ([209.85.210.193]:38345 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDBAdY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Apr 2019 20:33:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so5414128pfo.5
        for <fstests@vger.kernel.org>; Mon, 01 Apr 2019 17:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190331123130.14922-1-xifeng@redhat.com> <CAH2r5mspi108y=4wkKWxQno+WGJnEOrWOGWL9KqSucF6fULG0g@mail.gmail.com>
In-Reply-To: <CAH2r5mspi108y=4wkKWxQno+WGJnEOrWOGWL9KqSucF6fULG0g@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Apr 2019 19:33:12 -0500
Message-ID: <CAH2r5mt=ffwygAmeuHGtNCbDXAzJ3f+V1Xeaw=S=MmaQKRkHLA@mail.gmail.com>
Subject: Re: [PATCH v2] common/rc: add global mounted option for _scratch_remount
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: XiaoLi Feng <xifeng@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

And 306 also works with cifs (as long as mounting with "sfu" mount
option) with this patch

On Mon, Apr 1, 2019 at 10:29 AM Steve French <smfrench@gmail.com> wrote:
>
> I also verified that test 452 now works to cifs (SMB3 mounts to
> multiple types of test targets, Azure, Windows etc.)
>
> On Sun, Mar 31, 2019 at 7:31 AM XiaoLi Feng <xifeng@redhat.com> wrote:
> >
> > From: Xiaoli Feng <xifeng@redhat.com>
> >
> > When call _scratch_remount for cifs , it always requires to input
> > password. This will make generic/306 generic/452 failed because
> > cifs remount failed.
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 1c42515f..ea1eaf6a 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -357,7 +357,7 @@ _scratch_remount()
> >      local opts="$1"
> >
> >      if test -n "$opts"; then
> > -       mount -o "remount,$opts" $SCRATCH_MNT
> > +       mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT
> >      fi
> >  }
> >
> > --
> > 2.18.1
> >
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
