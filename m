Received: from mx1.redhat.com ([209.132.183.28]:35552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752403AbdLNEc0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Dec 2017 23:32:26 -0500
Date: Thu, 14 Dec 2017 12:32:23 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v3 1/3] common/rc: add scratch shutdown support for
 overlayfs
Message-ID: <20171214043223.GC2749@eguan.usersys.redhat.com>
References: <1513048179-151065-1-git-send-email-cgxu519@icloud.com>
 <20171212091622.GQ2749@eguan.usersys.redhat.com>
 <915A4652-253D-4326-B60A-9CF5504AAED0@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <915A4652-253D-4326-B60A-9CF5504AAED0@icloud.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Chengguang Xu <cgxu519@icloud.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>, linux-unionfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 14, 2017 at 11:35:04AM +0800, Chengguang Xu wrote:
>=20
> >=20
> > =E5=9C=A8 2017=E5=B9=B412=E6=9C=8812=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=
=885:16=EF=BC=8CEryu Guan <eguan@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
> >=20
> > On Tue, Dec 12, 2017 at 11:09:37AM +0800, Chengguang Xu wrote:
> >> OverlayFS overrides SCRATCH_MNT variable to it's own,
> >> so adjust target to underlying filesystem(OVL_BASE_SCRATCH_MNT)
> >> when running shutdown on overlayfs.
> >>=20
> >> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> >> ---
> >>=20
> >> Changes since v2:
> >> 1. Make option for _scratch_shutdown(), so caller can=20
> >> specify option when calling.
> >> 2. Add comment for why overlay requires special handling.
> >> 3. Add commit log.
> >>=20
> >> Changes since v1:
> >> _scratch_shutdown() does not call notrun.
> >>=20
> >> common/rc | 37 +++++++++++++++++++++++++++++++++++--
> >> 1 file changed, 35 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/common/rc b/common/rc
> >> index 4c053a5..a5c4ace 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -382,6 +382,24 @@ _scratch_cycle_mount()
> >>     _scratch_mount "$opts"
> >> }
> >>=20
> >> +_scratch_shutdown()
> >> +{
> >> +	if [ $FSTYP =3D "overlay" ]; then
> >> +		# In lagacy overlay usage, it may specify directory as=20
> >=20
> > Trailing whitespace in above line.
> >=20
> >> +		# SCRATCH_DEV, in this case OVL_BASE_SCRATCH_DEV
> >> +		# will be null, so check OVL_BASE_SCRATCH_DEV before
> >> +		# running shutdown to avoid shutting down base fs accidently.
> >> +		if [ -z $OVL_BASE_SCRATCH_DEV ]; then
> >> +			echo -n "Ignore shutdown because "
> >> +			echo "$SCRATCH_DEV is not a block device"
> >=20
> > Hmm, I think a '_fail "<message>"' would be more appropriate here, so
> > that test fails and exits immediately. Test should call
> > _require_scratch_shutdown first before calling _scratch_shutdown, if
> > not, it indicates a useage error of the helper, we need to prompt the
> > test writer to call _require_scratch_shutdown first in error message.
>=20
>=20
> The additional check I added here, is mainly for avoiding accident impr=
oper shutdown.

Yeah, I understand, and the _fail call I suggested is to exit the test
immediately with a proper error message when such an accident usage is
detected, while current code just prints a message and continues the
rest of the test, which is unnecessary.

> If you think we need to prompt message to indicate should call _require=
_scratch_shutdown first,
> I think we had better modify godown to implement this function. What do=
 you think?

I just want to see a more specific & clearer error message on such a
usage failure, so people know what to do to correct this error. Similar
to what we do in common/rc::_require_command (_fail "usage:
_require_command <command> [<name>]").

Thanks,
Eryu
