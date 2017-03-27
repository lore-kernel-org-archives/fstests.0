Received: from mx1.redhat.com ([209.132.183.28]:35256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751821AbdC0LgJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Mar 2017 07:36:09 -0400
Date: Mon, 27 Mar 2017 19:35:37 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] Code to allow cros-compilation on chromeOS
Message-ID: <20170327113537.GR14226@eguan.usersys.redhat.com>
References: <CAMHSBOXjP4QOGmM2HxygY0r+ML93XyEmLEfwGz6KvS0S0sjuCA@mail.gmail.com>
 <20170324234800.23674-1-gwendal@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324234800.23674-1-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 24, 2017 at 04:48:00PM -0700, Gwendal Grignou wrote:
> - Request LIBTOOL to be used
> - Set topbuildir based on a Makefile variable to call libtool
> - Use /usr/local instead of /var for xfstest final location
> - Move macros from aclocal.m4 to acinclude.m4, aclocal.m4 is autogenerate=
d.
>=20
> The regular way of compiling xfstests - make - remains.
> But it now runs autoreconf and libtoolize -i to produce a valid
> configure.
> Verified compiling in chromeOS chroot works as well.

This works for me now, thanks!

But I noticed that the "/usr/local" location is only used if DESTDIR is
defined, otherwise it defaults to /var/lib, this seems inconsistent. Is
it possible, e.g. to define another var, to control the location and
make "/var/lib" as the default?

And again, I really appreciate if someone else with more packaging
experience could help review this patch!

Thanks,
Eryu
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3DukLPNj4j4uFJyDwWW7Eu3T83sCjYPH-2y0Pk7dzkaBc&s=3DYFXsKIOjJ40JxbMAtZHJFLRC=
c_nS_pISTYYzZBM5lRw&e=3D=20
