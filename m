Received: from mx1.redhat.com ([209.132.183.28]:54490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdGYHug (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 Jul 2017 03:50:36 -0400
Date: Tue, 25 Jul 2017 15:50:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/446: make sure all background processes are dead
 before umount
Message-ID: <20170725075034.GN9167@eguan.usersys.redhat.com>
References: <20170724101125.13309-1-eguan@redhat.com>
 <5976A150.1090904@cn.fujitsu.com>
 <20170725063107.GL9167@eguan.usersys.redhat.com>
 <5976F6BF.1040401@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5976F6BF.1040401@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jul 25, 2017 at 03:43:59PM +0800, Xiao Yang wrote:
> > > >   # run mapped write to the same hole as dio read
> > > > -for i in `seq 0 999`; do
> > > > +while true; do
> > > >   	$XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file \
> > > >   		>  /dev/null
> > > >   	$XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file>  /dev/null
> > > > +	if ! kill -s 0 $dread_pid>/dev/null 2>&1; then
> > > > +		break
> > > > +	fi
> > > >   done
> Could we simplify this break, as below:
> while kill -s 0 $dread_pid >/dev/null 2>&1; do
>     $XFS_IO_PROG -c "mmap 0 $filesz" -c "mwrite 0 $filesz" $SCRATCH_MNT/file
> \
> > /dev/null
>     $XFS_IO_PROG -c "fpunch 0 $filesz" $SCRATCH_MNT/file > /dev/null
> done

This looks better, thanks! I'll send v2.

Eryu
