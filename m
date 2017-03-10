Received: from mx1.redhat.com ([209.132.183.28]:42070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbdCJG5f (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Mar 2017 01:57:35 -0500
Date: Fri, 10 Mar 2017 14:57:34 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of
 TEST_DIR
Message-ID: <20170310065734.GN14226@eguan.usersys.redhat.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
 <20170308115136.GF14226@eguan.usersys.redhat.com>
 <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
 <20170309095938.GJ14226@eguan.usersys.redhat.com>
 <CAOQ4uxhcb1UnX29nsEEvp5djaWMHXc_dO==Pibv4i2AvXmfjTA@mail.gmail.com>
 <CAOQ4uxijM=6AJjPCG23w6QWK8z4+a-5pRW2wZEXbVXJbGz=csQ@mail.gmail.com>
 <20170310035240.GK14226@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310035240.GK14226@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 10, 2017 at 11:52:40AM +0800, Eryu Guan wrote:
> On Thu, Mar 09, 2017 at 03:16:38PM +0200, Amir Goldstein wrote:
> > On Thu, Mar 9, 2017 at 1:28 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Thu, Mar 9, 2017 at 11:59 AM, Eryu Guan <eguan@redhat.com> wrote:
> > >> On Wed, Mar 08, 2017 at 04:26:22PM +0200, Amir Goldstein wrote:
> > >>
> > >> [snip]
> > >>
> > >>> From f365bd5d60d9d5b82e02db17e615380bf37a74de Mon Sep 17 00:00:00 2001
> > >>> From: Amir Goldstein <amir73il@gmail.com>
> > >>> Date: Wed, 8 Mar 2017 12:38:22 +0200
> > >>> Subject: [PATCH] filter: match $TEST_* $SCRATCH_* in beginning of path string
> > >>>
> > >>> For example, if $TEST_DIR=/mnt, only replace instacnes of /mnt that
> > >>> are in the beginning of a path string, e.g.:
> > >>>
> > >>> "/mnt/mntA/mntB:/mnt/mntC" => "TEST_DIR/mntA/mntB:TEST_DIR/mntC"
> > >>>
> > >>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >>
> > >> I'm testing this patch now, with the following config:
> > >>
> > >> TEST_DEV=/dev/vda5
> > >> TEST_DIR=/vda5
> > >> SCRATCH_DEV=/dev/vda6
> > >> SCRATCH_MNT=/vda6
> > >> FSTYP=xfs
> > >> MKFS_OPTIONS="-m crc=1,reflink=1"
> > >>
> > >> First I run this test on xfs, and everything went well. Then I ran test
> > >> with -overlay option, and found generic/171 generic/172 in this order
> > >> confused _check_mounted_on().
> > >>
> > >> ./check -overlay generic/17[1-2]
> > >>
> > >> I got this diff
> > >>
> > >> --- tests/generic/172.out       2016-12-30 14:13:24.076000000 +0800
> > >> +++ /root/xfstests/results//xfs_4k_reflink/generic/172.out.bad  2017-03-09 17:27:12.203000000 +0800
> > >> @@ -1,9 +1,4 @@
> > >>  QA output created by 172
> > >> -Format and mount
> > >> -Reformat with appropriate size
> > >> -Create a big file and reflink it
> > >> -Allocate the rest of the space
> > >> -CoW the big file
> > >> -pwrite: No space left on device
> > >> -Remount and try CoW again
> > >> -pwrite: No space left on device
> > >> +SCRATCH_DEV=/vda6 is mounted but not on SCRATCH_MNT=/vda6/ovl-mnt - aborting
> > >> +Already mounted result:
> > >> +/dev/vda6 on /vda6 type xfs (rw,relatime,context=system_u:object_r:nfs_t:s0,attr2,inode64,noquota)
> > >>
> > >> Seems the 'grep -F "$dev on ' check isn't that accurate either. This
> > >> also happens without this patch.
> > >>
> > >
> > > Oops. Good catch.
> > > I have this sort of setup with kvm-xfstests, but only tested it with
> > > old overlay config
> > > (because I need to change kvm-xfstests scripts to new overlay config)
> > 
> > So I changed kvm-xfstests over to new overlay config and got the error
> > you reported.
> > Your fix also works, but see a few minor comments below.
> > 
> > >
> > >> I'm trying a draft patch like below, this seems to fix the problem for
> > >> me, and it works for NFS too (both ipv4 and ipv6). I'm testing your
> > >> patch + my local fix now.  Will see how it goes, if everything goes well
> > >> I'll post it as a seperate patch.
> > >
> > > Are you planning to keep my patch as is or drop the else statement in
> > > the filters?
> 
> I was testing your attached patch as is, if you can send a formal patch
> with the else statement dropped that'd be great.

Your test patch worked fine in my testing. I tested the following
configs with both reflink enabled xfs (which could cover the most test
cases) and overlayfs on top of xfs (both old and new config)

# kvm-xfstests config
TEST_DEV=/dev/sdc1
TEST_DIR=/sdc1
SCRATCH_DEV=/dev/sdc2
SCRATCH_MNT=/sdc2

# djwong config
TEST_DEV=/dev/sdc1
TEST_DIR=/mnt
SCRATCH_DEV=/dev/sdc2
SCRATCH_MNT=/opt

Thanks,
Eryu
