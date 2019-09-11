Received: from mx1.redhat.com ([209.132.183.28]:34604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfIKCe7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Sep 2019 22:34:59 -0400
Date: Wed, 11 Sep 2019 10:42:10 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic/566: use _require_xfs_quota_foreign to replace
 the hard -f option
Message-ID: <20190911024210.GH7239@dhcp-12-102.nay.redhat.com>
References: <20190910113611.31247-1-zlang@redhat.com>
 <2fc62795-d932-de07-a9ed-695893ead8f8@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
In-Reply-To: <2fc62795-d932-de07-a9ed-695893ead8f8@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: =?gb2312?B?WHUsIFlhbmcv0Owg0e4=?= <xuyang2018.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 11, 2019 at 10:19:10AM +0800, Xu, Yang/=D0=EC =D1=EE wrote:
> on 2019/09/10 19:36, Zorro Lang wrote:
>=20
> > xfstests should decide if xfs_quota need the -f option by
> > _require_xfs_quota_foreign, not write the -f option after
> > $XFS_QUOTA_PROG manually. The later way will cause unexpected
> > error on an old system which xfsprogs doesn't support the -f option.
>=20
>=20
> Hi Zorro
>=20
> I also sent a patch[1] about _require_xfs_quota_foreign but i miss
> $XFS_QUOTA_PROG have used -f option for non-xfs filesystem.
> And you may forget to modify the last $XFS_QUOTA_PRO. As below:
>=20
> $XFS_QUOTA_PROG -x -f -c 'report -hag' $SCRATCH_MNT >> $seqres.full
>=20
> [1]https://patchwork.kernel.org/patch/11137635/

Oh, I didn't notice that, we sent the patch nearly same time. As you've
sent a patch, you can keep working on that, ignore this patch.

But the '-f' options in the case must be removed, or the case will fail
on RHEL-7 XFS. Due rhel7 xfsprogs doesn't support -f option, but
_require_xfs_quota_foreign won't _notrun if the FSTYP is xfs.

Thanks,
Zorro

>=20
> Thanks
> Yang Xu
>=20
> >=20
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >   tests/generic/566 | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/tests/generic/566 b/tests/generic/566
> > index e8491e54..fb239a00 100755
> > --- a/tests/generic/566
> > +++ b/tests/generic/566
> > @@ -34,6 +34,7 @@ _supported_os Linux
> >   _supported_fs generic
> >   _require_scratch
> >   _require_quota
> > +_require_xfs_quota_foreign
> >   _require_user
> >   rm -f $seqres.full
> > @@ -45,7 +46,7 @@ _qmount
> >   dir=3D"$SCRATCH_MNT/dummy"
> >   mkdir -p $dir
> >   chown $qa_user $dir
> > -$XFS_QUOTA_PROG -x -f -c "limit -g bsoft=3D100k bhard=3D100k $qa_use=
r" $SCRATCH_MNT
> > +$XFS_QUOTA_PROG -x -c "limit -g bsoft=3D100k bhard=3D100k $qa_user" =
$SCRATCH_MNT
> >   $XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m' $dir/foo >> $seqres.full
> >   chown $qa_user "${dir}/foo"
>=20
>=20
