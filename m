Received: from mx1.redhat.com ([209.132.183.28]:38446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfDBI6p (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 04:58:45 -0400
Date: Tue, 2 Apr 2019 04:58:45 -0400 (EDT)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <1613847653.376782.1554195525189.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190401111554.GE2824@desktop>
References: <20190331123130.14922-1-xifeng@redhat.com> <20190401111554.GE2824@desktop>
Subject: Re: [PATCH v2] common/rc: add global mounted option for
 _scratch_remount
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, smfrench@gmail.com
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

----- Original Message -----
> From: "Eryu Guan" <guaneryu@gmail.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org, smfrench@gmail.com
> Sent: Monday, April 1, 2019 7:15:54 PM
> Subject: Re: [PATCH v2] common/rc: add global mounted option for _scratch_remount
> 
> On Sun, Mar 31, 2019 at 08:31:30PM +0800, Xiaoli Feng wrote:
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
> > -	mount -o "remount,$opts" $SCRATCH_MNT
> > +	mount $MOUNT_OPTIONS -o "remount,$opts" $SCRATCH_MNT
> 
> IMHO, your v1 patch looks better, just need to update overlay/035 to use
> bare $MOUNT_PROG to do the first remount.

The v1 patch use "_try_scratch_mount "-o remount,$opts"". And actually it will
call like this "mount -o $option -o remount $dev $mountpoint". But this remounting
operation seems is different from "mount -o $option -o remount $mountpoint"(just use
strace to check). One difference is that it won't check /etc/fstab. That's why I give
up v1 patch. What do you think about it? If you consider we can ignore the difference.
Then I will use v1 patch and modify overlay/035.

Thanks.

> 
> Thanks,
> Eryu
> 
> >      fi
> >  }
> >  
> > --
> > 2.18.1
> > 
> 
