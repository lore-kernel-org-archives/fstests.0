Received: from mx1.redhat.com ([209.132.183.28]:59288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755325AbdCJIpO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Mar 2017 03:45:14 -0500
Date: Fri, 10 Mar 2017 16:45:11 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] common/rc: use findmnt to check mounted device
Message-ID: <20170310084511.GO14226@eguan.usersys.redhat.com>
References: <20170310063343.8722-1-eguan@redhat.com>
 <CAOQ4uxjYMz0vTxDsRaZoPmYyNuU1mjNUyZsFGw1PUontRep1Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjYMz0vTxDsRaZoPmYyNuU1mjNUyZsFGw1PUontRep1Cw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 09:43:36AM +0200, Amir Goldstein wrote:
> On Fri, Mar 10, 2017 at 8:33 AM, Eryu Guan <eguan@redhat.com> wrote:
> > Doing 'grep -F "$dev on "' to find the mounted device is not
> > always accurate, e.g.
> >
> >  SCRATCH_DEV=/vda6 is mounted but not on SCRATCH_MNT=/vda6/ovl-mnt - aborting
> >  Already mounted result:
> >  /dev/vda6 on /vda6 type xfs (rw,relatime,context=system_u:object_r:nfs_t:s0,attr2,inode64,noquota)
> >
> > Fix it by using findmnt command and specifying the $dev as mount
> > source, print the result in "$dev $mnt" format. This works for local
> > filesystems, network filesystems and overlayfs, avoids all kinds of
> > tricky and error-prone grep pattern/regex.
> >
> > Also fixed the if-then-fi format in _check_mounted_on() while we're
> > at it.
> >
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> > ---
> 
> Looks good. Also passed my kvm-xfstests -c overlay run.

Thanks! Can I take it as a Reviewed-by tag?

Eryu
