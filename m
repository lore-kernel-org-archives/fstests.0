Received: from mx1.redhat.com ([209.132.183.28]:60656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbdF1HuK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Jun 2017 03:50:10 -0400
Date: Wed, 28 Jun 2017 15:50:08 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/2] common/rc: handle xfs_io copy_range when
 copy_file_range syscall isn't available
Message-ID: <20170628075008.GE23360@eguan.usersys.redhat.com>
References: <20170626164053.7634-1-lhenriques@suse.com>
 <20170626164053.7634-2-lhenriques@suse.com>
 <20170627052529.GX23360@eguan.usersys.redhat.com>
 <20170627085013.h5uxomucqonrf7cj@hermes.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170627085013.h5uxomucqonrf7cj@hermes.olymp>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Luis Henriques <lhenriques@suse.com>
Cc: fstests@vger.kernel.org, Anna Schumaker <Anna.Schumaker@Netapp.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 27, 2017 at 09:50:13AM +0100, Luis Henriques wrote:
> On Tue, Jun 27, 2017 at 01:25:29PM +0800, Eryu Guan wrote:
> > On Mon, Jun 26, 2017 at 05:40:53PM +0100, Luis Henriques wrote:
> > > _require_xfs_io_command() isn't handling the case where the copy_fi=
le_range
> > > syscall isn't available.  Unfortunately, old versions of xfs_io don=
't
> > > handle it correctly either and the test will succeed with an empty =
file.
> >=20
> > If copy_file_range syscall isn't available on the system, xfs_io shou=
ld
> > have no "copy_range" built either, or if you're using a pre-built xfs=
_io
> > binary shipped by a distro, it should have no copy_range either to ma=
tch
> > the kernel space. Anyway, I don't think it would cause any problem if
> > there's no copy_file_range syscall support. I'm curious what's your
> > environment setup.
>=20
> I am building an initramfs that contains the testing tools from a recen=
t
> distro, and running the tests against an old kernel (which does not
> include this syscall).  I'm not sure how usual this sort of setup is.
>=20
> Would you rather have the test ignoring these sort of setups, and just
> include the 2nd check (i.e., always assume the tools (xfs_io) are in sy=
nc
> with the kernel)?

I'm fine with having this "Function not implemented" check, it'd be
better to add more background information in the commit log. And perhaps
we should do it after the case switch so it not only applies to
copy_file_range syscall, but also to all other syscalls/commands.

But I don't think we should workaround a xfsprogs bug in test, it
revealed a real bug and that's what should be really fixed, i.e. build
the initramfs with a newer version of xfsprogs with that bug fixed?

Thanks,
Eryu

>=20
> > >=20
> > > To fix this function, we need to add two checks:
> > >=20
> > > 1) for old xfs_io versions, fail if the test seems to succeed (no o=
utput)
> > >    but the file created is empty,
> > > 2) for newer versions, use the error returned.
> > >=20
> > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > ---
> > >  common/rc | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/common/rc b/common/rc
> > > index 2972f89e9527..aad065cb2ade 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2146,6 +2146,10 @@ _require_xfs_io_command()
> > >  		$XFS_IO_PROG -F -f -c "pwrite 0 4k" $testfile > /dev/null 2>&1
> > >  		testio=3D`$XFS_IO_PROG -F -f -c "copy_range $testfile" $testcopy=
 2>&1`
> > >  		rm -f $testcopy > /dev/null 2>&1
> >=20
> > $testcopy is removed here...
> >=20
> > > +		[ -z "$testio" -a ! -s "$testcopy" ] && \
> >=20
> > then on hosts with copy_file_range support, this check always returns
> > true, and test _notrun when it should run.
>=20
> /me blushes and hides
>=20
> I'll send v2 once you let me know if you want me to keep these 2 checks.
>=20
> Cheers,
> --
> Lu=C3=ADs
>=20
> >=20
> > Thanks,
> > Eryu
> >=20
> > > +			_notrun "xfs_io $command support is missing"
> > > +		echo $testio | egrep -q "Function not implemented" && \
> > > +			_notrun "xfs_io $command support is missing"
> > >  		;;
> > >  	"falloc" )
> > >  		testio=3D`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2=
>&1`
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe fstests" =
in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
