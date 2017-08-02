Received: from mail-qt0-f196.google.com ([209.85.216.196]:35170 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbdHBEM3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Aug 2017 00:12:29 -0400
Received: by mail-qt0-f196.google.com with SMTP id t37so3566351qtg.2
        for <fstests@vger.kernel.org>; Tue, 01 Aug 2017 21:12:29 -0700 (PDT)
Date: Wed, 2 Aug 2017 01:12:24 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH] generic/449: make the test effective against xfs
Message-ID: <20170802041223.GA7310@debian.home>
References: <20170801045528.GA4696@debian.home>
 <20170802013314.GP9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802013314.GP9167@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 02, 2017 at 09:33:14AM +0800, Eryu Guan wrote:
> On Tue, Aug 01, 2017 at 01:55:31AM -0300, Ernesto A. Fern=C3=A1ndez wro=
te:
> > Setting acls on an xfs filesystem will succeed even after running out
> > of space for user attributes. Use trusted attributes instead.
> >=20
> > Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail=
.com>
>=20
> How about using the "XFS way" unconditionally in the test? I found that
> test still failed for ext4 and btrfs when using the "XFS way", so I
> wondered if we don't need to special-case XFS at all.

I tried some other filesystems and it is as you say. I don't know why I
expected otherwise. I'll send the new patch right away.
