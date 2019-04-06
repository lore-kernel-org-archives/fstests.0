Received: from mail-pf1-f193.google.com ([209.85.210.193]:36691 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDFMQo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Apr 2019 08:16:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so4799998pfn.3
        for <fstests@vger.kernel.org>; Sat, 06 Apr 2019 05:16:43 -0700 (PDT)
Date: Sat, 6 Apr 2019 20:16:37 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] common/rc: add global mounted option for
 _scratch_remount
Message-ID: <20190406121637.GI2824@desktop>
References: <20190331123130.14922-1-xifeng@redhat.com>
 <20190401111554.GE2824@desktop>
 <1613847653.376782.1554195525189.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613847653.376782.1554195525189.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Xiaoli Feng <xifeng@redhat.com>
Cc: fstests@vger.kernel.org, smfrench@gmail.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 02, 2019 at 04:58:45AM -0400, Xiaoli Feng wrote:
> Hi Eryu,
> 
> ----- Original Message -----
> > From: "Eryu Guan" <guaneryu@gmail.com>
> > To: "XiaoLi Feng" <xifeng@redhat.com>
> > Cc: fstests@vger.kernel.org, smfrench@gmail.com
> > Sent: Monday, April 1, 2019 7:15:54 PM
> > Subject: Re: [PATCH v2] common/rc: add global mounted option for _scratch_remount
> > 
> > On Sun, Mar 31, 2019 at 08:31:30PM +0800, Xiaoli Feng wrote:
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
> > > -	mount -o "remount,$opts" $SCRATCH_MNT
> > > +	mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT
> > 
> > IMHO, your v1 patch looks better, just need to update overlay/035 to use
> > bare $MOUNT_PROG to do the first remount.
> 
> The v1 patch use "_try_scratch_mount "-o remount,$opts"". And actually it will
> call like this "mount -o $option -o remount $dev $mountpoint". But this remounting
> operation seems is different from "mount -o $option -o remount $mountpoint"(just use
> strace to check). One difference is that it won't check /etc/fstab. That's why I give
> up v1 patch. What do you think about it? If you consider we can ignore the difference.
> Then I will use v1 patch and modify overlay/035.

I think we could ignore that difference. All you need for CIFS to work
is the password information set in $MOUNT_OPTIONS when remounting, and
_try_scratch_mount takes other mount options, e.g. selinux context, to
remount as well, not just $MOUNT_OPTIONS.

Thanks,
Eryu
