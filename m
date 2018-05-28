Received: from mx1.redhat.com ([209.132.183.28]:53600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbeE1Gk5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 28 May 2018 02:40:57 -0400
Date: Mon, 28 May 2018 02:40:56 -0400 (EDT)
From: Xiaoli Feng <xifeng@redhat.com>
Message-ID: <246296494.4735384.1527489656588.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180527125058.GC6581@desktop>
References: <1526959436-7170-1-git-send-email-xifeng@redhat.com> <20180527125058.GC6581@desktop>
Subject: Re: [PATCH] common/rc: skip atime related tests on CIFS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>, Leif Sahlberg <lsahlber@redhat.com>
Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


Add Ronnie to to list.

Hello Ronnie,
  what's the expected behavior from CIFS on atime/noatime? We want to skip the
atime related tests on cifs for xfstests just like nfs. But not sure if it's
correct. What do you think about it?

Thanks.

----- Original Message -----
> From: "Eryu Guan" <guaneryu@gmail.com>
> To: "XiaoLi Feng" <xifeng@redhat.com>
> Cc: fstests@vger.kernel.org, linux-cifs@vger.kernel.org
> Sent: Sunday, May 27, 2018 8:50:58 PM
> Subject: Re: [PATCH] common/rc: skip atime related tests on CIFS
> 
> On Tue, May 22, 2018 at 11:23:56AM +0800, Xiaoli Feng wrote:
> > From: xiaoli feng <xifeng@redhat.com>
> > 
> > The atime related mount options have no effect on cifs mounts
> > now or in the future. So skip these tests on CIFS.
> > 
> > Signed-off-by: xiaoli feng <xifeng@redhat.com>
> 
> Looks fine to me. But I really need an ACK from cifs folks.
> 
> > ---
> >  common/rc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index ffe5323..d3af55f 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3244,6 +3244,8 @@ _require_atime()
> >  	_exclude_scratch_mount_option "noatime"
> >  	if [ "$FSTYP" == "nfs" ]; then
> >  		_notrun "atime related mount options have no effect on NFS"
> > +	elif [ "$FSTYP" == "cifs" ]; then
> > +		_notrun "atime related mount options have no effect on CIFS"
> 
> Or just change the check to a case-switch on $FSTYP?

Ok, I will change it on the next commit.
Thanks!

> 
> Thanks,
> Eryu
> 
> >  	fi
> >  }
> >  
> > --
> > 1.8.3.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
