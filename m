Received: from userp1040.oracle.com ([156.151.31.81]:31866 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932184AbcHZQS5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2016 12:18:57 -0400
Date: Fri, 26 Aug 2016 09:18:38 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/098: fix xfs_repair on newer xfsprogs
Message-ID: <20160826161838.GF8265@birch.djwong.org>
References: <1472116951-3317-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160825120903.GF10350@dhcp12-143.nay.redhat.com>
 <20160825154052.GD20705@birch.djwong.org>
 <57BFB868.7030806@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <57BFB868.7030806@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 26, 2016 at 11:32:56AM +0800, Xiao Yang wrote:
> =E4=BA=8E 2016/08/25 23:40, Darrick J. Wong =E5=86=99=E9=81=93:
> >On Thu, Aug 25, 2016 at 08:09:03PM +0800, Zorro Lang wrote:
> >>On Thu, Aug 25, 2016 at 05:22:31PM +0800, Xiao Yang wrote:
> >>>Make sure xfs_repair can't clear the log by default when it is corru=
pted.
> >>>xfs_repair always and only clear the log when the -L parameter is sp=
ecified.
> >>>This has updated by:
> >>>Commit f2053bc ("xfs_repair: don't clear the log by default")
> >>>
> >>>Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>>---
> >>>  tests/xfs/098 | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>>diff --git a/tests/xfs/098 b/tests/xfs/098
> >>>index d91d617..0fe8d93 100755
> >>>--- a/tests/xfs/098
> >>>+++ b/tests/xfs/098
> >>>@@ -93,7 +93,9 @@ echo "+ mount image"
> >>>  _scratch_mount 2>/dev/null&&  _fail "mount should not succeed"
> >>>
> >>>  echo "+ repair fs"
> >>>-_scratch_xfs_repair>>  $seqres.full 2>&1
> >>>+_scratch_xfs_repair>>  $seqres.full 2>&1&&  _fail "xfs_repair shoul=
d not succeed without -L option"
> >>Hi,
> >>
> >>If you make it fail at here, this case can't run for old xfsprogs(wit=
hout
> >>commit f2053bc).
> >>
> >>>+
> >>>+_scratch_xfs_repair -L>>  $seqres.full 2>&1
> >>For compatibility, maybe you can use "-L" directly. Or use -L
> >>after _scratch_xfs_repair return error.
> >I suggest _repair_scratch_fs.
> >
> >--D
> >
> Hi Darrick
> I changed _repair_scratch_fs because xfs_repair return 1 when log is
> corrupted.

xfs_repair returns 2 when the log is corrupted, 1 when there's corruption=
 left
to be fixed *or* some kind of operation error happened, and 0 if either i=
t
found nothing wrong or all the corruptions were fixed.  The manpage lies.

(Proceeding on to the rest of the messages in this thread...)

--D

> Thanks for your review.
>=20
> Regards,
> Xiao Yang
>=20
> >>Thanks,
> >>Zorro
> >>
> >>>
> >>>  echo "+ mount image (2)"
> >>>  _scratch_mount
> >>>--=20
> >>>1.8.3.1
> >>>
> >>>
> >>>
> >>>--
> >>>To unsubscribe from this list: send the line "unsubscribe fstests" i=
n
> >>>the body of a message to majordomo@vger.kernel.org
> >>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
