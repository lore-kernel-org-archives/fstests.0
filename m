Received: from mail-pl1-f193.google.com ([209.85.214.193]:44846 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfC3Id5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Mar 2019 04:33:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so2096568pll.11
        for <fstests@vger.kernel.org>; Sat, 30 Mar 2019 01:33:57 -0700 (PDT)
Date: Sat, 30 Mar 2019 16:33:50 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fstests: Don't delete seqres.full file in generic/077
Message-ID: <20190330083350.GY2824@desktop>
References: <20190326150158.17700-1-nborisov@suse.com>
 <20190326154635.GC6537@magnolia>
 <fa0d0273-e654-c23e-e1e8-8797bfa4e78e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa0d0273-e654-c23e-e1e8-8797bfa4e78e@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 05:40:31PM +0200, Nikolay Borisov wrote:
>=20
>=20
> On 26.03.19 =D0=B3. 17:46 =D1=87., Darrick J. Wong wrote:
> > On Tue, Mar 26, 2019 at 05:01:58PM +0200, Nikolay Borisov wrote:
> >> When this test finishes there is no 079.full file with output from c=
ommands.=20
> >=20
> > "077.full" ?
>=20
> Eryu, would you fold this when merging or shall I resend?

I'll fix it on merge, thanks!

Eryu
>=20
> >=20
> >> Sometimes this information is useful for post mortem so stop deletin=
g the=20
> >> file upon test completion.=20
> >>
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >=20
> > Looks ok to me otherwise,
> >=20
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> >=20
> >> ---
> >>  tests/generic/077 | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/tests/generic/077 b/tests/generic/077
> >> index 284e25253c9e..d11b49c6ff15 100755
> >> --- a/tests/generic/077
> >> +++ b/tests/generic/077
> >> @@ -73,6 +73,5 @@ cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2=
>&1
> >>  _check_scratch_fs
> >> =20
> >>  echo "*** all done"
> >> -rm -f $seqres.full
> >=20
> > I had wondered about this myself... :)
> >=20
> > --D
> >=20
> >>  status=3D0
> >>  exit
> >> --=20
> >> 2.7.4
> >>
> >=20
