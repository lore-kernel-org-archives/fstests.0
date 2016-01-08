Received: from mx1.redhat.com ([209.132.183.28]:34531 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbcAHJjR (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 8 Jan 2016 04:39:17 -0500
Date: Fri, 8 Jan 2016 17:39:12 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] fstests: comments to prevent from adding "/" to the
 end of 2 environment variables
Message-ID: <20160108093912.GH21019@eguan.usersys.redhat.com>
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-2-git-send-email-hejianet@gmail.com>
 <20160107102723.GD21019@eguan.usersys.redhat.com>
 <568E7049.1020508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <568E7049.1020508@gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: hejianet <hejianet@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 07, 2016 at 10:03:53PM +0800, hejianet wrote:
> Hi Eryu Guan
> Thanks for the comments,  reasonable to me.
> I will add it into v2 patch together with other
> =E5=9C=A8 1/7/16 6:27 PM, Eryu Guan =E5=86=99=E9=81=93:
> >On Thu, Jan 07, 2016 at 02:37:28PM +0800, Jia He wrote:
> >>This adds comments to prevent user from adding "/" to the end of TEST=
_DIR and
> >>SCRATCH_MNT
> >Instead of adding comments, how about removing the trailing "/" in the
> >code, something like:
> >
> >diff --git a/common/config b/common/config
> >index e82d279..cb34fd7 100644
> >--- a/common/config
> >+++ b/common/config
> >@@ -551,5 +551,10 @@ if [ -z "$CONFIG_INCLUDED" ]; then
> >  	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
> >  fi
> >+# canonicalize the mount points
> >+# this follows symlinks and removes all trailing "/"s
> >+export TEST_DIR=3D`readlink -e "$TEST_DIR"`
> >+export SCRATCH_MNT=3D`readlink -e "$SCRATCH_MNT"`
> >+
> Thanks, but maybe it will empty the invalid path and the user doesn't k=
now
> why his TEST_DIR/SCRATCH_MNT are assigned to NULL?

These values have been proved to be a directory in get_next_config(), if
they're not, the test errors out there.

Thanks,
Eryu
