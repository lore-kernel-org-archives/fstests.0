Received: from mail-pg1-f195.google.com ([209.85.215.195]:40500 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbeIJJYo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Sep 2018 05:24:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so9776321pga.7
        for <fstests@vger.kernel.org>; Sun, 09 Sep 2018 21:32:40 -0700 (PDT)
Date: Mon, 10 Sep 2018 12:32:33 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] tmpfs: don't require TEST_DEV
Message-ID: <20180910043233.GL3651@desktop>
References: <20180903122728.22882-1-mszeredi@redhat.com>
 <20180909145611.GJ3651@desktop>
 <CAOssrKePY7Ea2eLanP3Xtx62zHBnBo39GkUWGHKjiLvBy7qsKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKePY7Ea2eLanP3Xtx62zHBnBo39GkUWGHKjiLvBy7qsKA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 09, 2018 at 09:07:52PM +0200, Miklos Szeredi wrote:
> On Sun, Sep 9, 2018 at 4:56 PM, Eryu Guan <guaneryu@gmail.com> wrote:
> > On Mon, Sep 03, 2018 at 02:27:28PM +0200, Miklos Szeredi wrote:
> >> tmpfs doesn't require a device and the source argument of the mount is ignored.
> >> If TEST_DEV is not given then set it to "none".
> >>
> >> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >> ---
> >>  common/config | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/common/config b/common/config
> >> index 2f1f27206776..40c2b399a3c7 100644
> >> --- a/common/config
> >> +++ b/common/config
> >> @@ -456,8 +456,9 @@ _check_device()
> >>       fi
> >>
> >>       case "$FSTYP" in
> >> -     9p)
> >> +     9p|tmpfs)
> >>               # 9p mount tags are just plain strings, so anything is allowed
> >> +             # tmpfs doesn't use mount source, ignore
> >>               ;;
> >>       overlay)
> >>               if [ ! -d "$dev" ]; then
> >> @@ -657,6 +658,10 @@ get_next_config() {
> >>               export RESULT_BASE="$here/results/"
> >>       fi
> >>
> >> +     if [ "$FSTYP" == tmpfs -a -z "$TEST_DEV" ]; then
> >> +             export TEST_DEV=none
> >> +     fi
> >> +
> >
> > Looks like we could ignore SCRATCH_DEV as well, just set it to a
> > different name. I'll just update it on commit.
> 
> Actually, no need to set it to a different name, since the $DEV
> argument of tmpfs is completely ignored (just like proc, sys, etc).

That's true. But fstests will check if the device is mounted or not
based on the device name, so if TEST_DEV is already mounted with "none"
and SCRATCH_DEV shares the same name, fstests will find SCRATCH_DEV
already mounted at a wrong path and exit.

Thanks,
Eryu
