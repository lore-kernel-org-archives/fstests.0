Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725724AbeHJEbG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 10 Aug 2018 00:31:06 -0400
Date: Fri, 10 Aug 2018 10:03:24 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] src/statx: fix undefined reference to xfstests_statx
Message-ID: <20180810020324.GW4893@hp-dl360g9-06.rhts.eng.pek2.redhat.com>
References: <20180809152132.4965-1-zlang@redhat.com>
 <CAL3q7H5WKBZxpbB+BEWZYVKQ7QVfcqH_578rU2mK2y6v+=a++w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3q7H5WKBZxpbB+BEWZYVKQ7QVfcqH_578rU2mK2y6v+=a++w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Filipe Manana <fdmanana@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, dhowells@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 09, 2018 at 06:07:54PM +0100, Filipe Manana wrote:
> On Thu, Aug 9, 2018 at 4:21 PM, Zorro Lang <zlang@redhat.com> wrote:
> > xfstests build fails after glibc updated to 2.28:
> >
> >   /tmp/cc3s96Dw.o: In function `main':
> >   /root/xfstests-dev/src/stat_test.c:690: undefined reference to `xfs=
tests_statx'
> >   /tmp/cc3s96Dw.o: In function `get_reference':
> >   /root/xfstests-dev/src/stat_test.c:301: undefined reference to `xfs=
tests_statx'
> >   /tmp/cc3s96Dw.o: In function `main':
> >   /root/xfstests-dev/src/stat_test.c:642: undefined reference to `xfs=
tests_statx'
> >   collect2: error: ld returned 1 exit status
> >   gmake[2]: *** [Makefile:82: stat_test] Error 1
> >   gmake[1]: *** [include/buildrules:31: src] Error 2
> >   make: *** [Makefile:53: default] Error 2
> >
> > Due to glibc-headers-2.28 defines struct statx and all related
> > things, include STATX_TYPE. But xfstests src/statx.h won't build
> > xfstests_statx() function STATX_TYPE has been defined, that doesn't
> > make sense.
> >
> > If all statx things has been defined by glibc, we can skip xfstests
> > internal statx definition, but xfstests_statx() function is still
> > needed, because it's called by other programs.
> >
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>=20
> Lu sent the same fix 2 days ago:
>=20
> https://patchwork.kernel.org/patch/10558653/

OK, Great :)

Thanks,
Zorro

>=20
>=20
> > ---
> >
> > CC David Howells <dhowells@redhat.com>, the original author of src/st=
atx.h.
> > For this change won't break his original design.
> >
> > Thanks,
> > Zorro
> >
> >  src/statx.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/statx.h b/src/statx.h
> > index 5d58208a..f6aaafd6 100644
> > --- a/src/statx.h
> > +++ b/src/statx.h
> > @@ -160,6 +160,8 @@ struct statx {
> >
> >  #define STATX_ATTR_AUTOMOUNT           0x00001000 /* Dir: Automount =
trigger */
> >
> > +#endif /* STATX_TYPE */
> > +
> >  static inline
> >  int xfstests_statx(int dfd, const char *filename, unsigned flags,
> >                    unsigned int mask, struct statx *buffer)
> > @@ -172,5 +174,4 @@ int xfstests_statx(int dfd, const char *filename,=
 unsigned flags,
> >  #endif
> >  }
> >
> > -#endif /* STATX_TYPE */
> >  #endif /* STATX_H */
> > --
> > 2.14.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --=20
> Filipe David Manana,
>=20
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
