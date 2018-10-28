Received: from mail-pl1-f193.google.com ([209.85.214.193]:34234 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ1WUe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 28 Oct 2018 18:20:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id f10-v6so2552875plr.1
        for <fstests@vger.kernel.org>; Sun, 28 Oct 2018 06:35:54 -0700 (PDT)
Date: Sun, 28 Oct 2018 21:35:45 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: update group file to indicate generic/456 uses
 {collapse,zero}_range
Message-ID: <20181028133545.GD3876@desktop>
References: <20181026115349.4241-1-tytso@mit.edu>
 <CAL3q7H4PN_Rz6HUkCrp4aEQsd+Jv_M9PBR+yRvXf7Y=Y2tZMMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3q7H4PN_Rz6HUkCrp4aEQsd+Jv_M9PBR+yRvXf7Y=Y2tZMMQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Filipe Manana <fdmanana@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, Oct 27, 2018 at 10:22:16AM +0100, Filipe Manana wrote:
> On Fri, Oct 26, 2018 at 12:53 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  tests/generic/group | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 28452732..8a21970e 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -458,7 +458,7 @@
> >  453 auto quick dir
> >  454 auto quick attr
> >  455 auto log replay
> > -456 auto quick metadata
> > +456 auto quick metadata collapse zero
>=20
> Since it uses fallocate too, should also be in the 'prealloc' group.

I'll add it on commit, thanks for review!

Eryu

>=20
> Thanks.
>=20
> >  457 auto log replay clone
> >  458 auto quick clone collapse zero
> >  459 auto thin
> > --
> > 2.18.0.rc0
> >
>=20
>=20
> --=20
> Filipe David Manana,
>=20
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 yo=
u're right.=E2=80=9D
