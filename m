Received: from mx3-phx2.redhat.com ([209.132.183.24]:33695 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbcESDgT convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 May 2016 23:36:19 -0400
Date: Wed, 18 May 2016 23:36:17 -0400 (EDT)
From: Zirong Lang <zlang@redhat.com>
Message-ID: <450668405.52826142.1463628977521.JavaMail.zimbra@redhat.com>
In-Reply-To: <20160518235531.GB26977@dastard>
References: <1463502981-15593-1-git-send-email-zlang@redhat.com> <20160518235531.GB26977@dastard>
Subject: Re: [PATCH 1/2] common/rc: modify _require_xfs_io_command function
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Dave Chinner" <david@fromorbit.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>
> =E6=8A=84=E9=80=81: fstests@vger.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E5=9B=9B, 2016=
=E5=B9=B4 5 =E6=9C=88 19=E6=97=A5 =E4=B8=8A=E5=8D=88 7:55:31
> =E4=B8=BB=E9=A2=98: Re: [PATCH 1/2] common/rc: modify _require_xfs_io_c=
ommand function
>=20
> On Wed, May 18, 2016 at 12:36:20AM +0800, Zorro Lang wrote:
> > 1. This function try to run $XFS_IO_PROG -c "$command help", that's
> > wrong. It should be "help $command".
>=20
> I think there was more to it that than:
>=20
> $ sudo xfs_io -c "pwrite help"
> $ sudo xfs_io -c "help pwrite"
> pwrite [-i infile [-d] [-s skip]] [-b bs] [-S seed] [-wW] [-FBR [-Z N]]=
 [-V
> N] off len -- writes a number of bytes at a specified offset
>=20
>  writes a range of bytes (in block size increments) from the given offs=
et
> [....]
> $ sudo xfs_io -c "foo help"
> command "foo" not found
>=20
> i.e. that check simply tells us whether the command exists or not
> with an error message that is captured and then tested. If we
> actually run the help command, we got lots of output for commands
> that exist and that may confuse the error string checking we then
> do.
>=20
> Yes, it's a bit of a hack, and we may not even need the "help"
> parameter anymore, but ISTR older versions of xfs_io needed it to
> parse the CLI successfully for all the different commands....

Hmm, that's a smart way. So I don't need to change that before someone
new xfsprogs break this "hack rule":)

>=20
> > 2. The $param can't be used for all command's options, for example
> > "help pwrite" include:
> >=20
> >  -Z N -- zeed the random number generator (used when writing randomly=
)
> >          (heh, zorry, the -s/-S arguments were already in use in pwri=
te)
>=20
> This bit is fine.
>=20
> In general, you should put separate changes into separate patches.
> If you find yourself iterating a list of things a patch fixes in the
> description, then that's a good sign it should be split into
> multiple patches.

Thanks for point that, I'll send a V2 patch only contain this change.

Thanks,
Zorro

>=20
> Cheers,
>=20
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
