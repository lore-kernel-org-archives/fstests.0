Received: from mail-pl1-f194.google.com ([209.85.214.194]:44237 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfACPW3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 Jan 2019 10:22:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so16036448plt.11
        for <fstests@vger.kernel.org>; Thu, 03 Jan 2019 07:22:28 -0800 (PST)
Date: Thu, 3 Jan 2019 23:22:17 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] common/config: Always create RESULT_BASE
Message-ID: <20190103152217.GA2803@desktop>
References: <20190103100135.24748-1-nborisov@suse.com>
 <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8faa1f5-87db-b029-4e68-68d76f7c410a@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 03, 2019 at 02:29:08PM +0200, Nikolay Borisov wrote:
>=20
>=20
> On 3.01.19 =D0=B3. 12:01 =D1=87., Nikolay Borisov wrote:
> > Commit 7fc034868d5d ("common/config: create $RESULT_BASE before dumpi=
ng kmemleak leaks")
> > inadvertently broke $RESULT_BASE dir creation since it changed the lo=
gic
> > to only create the directory only if this variable is not explicitly =
set
> > by the user. Fix this by ensuring RESULT_BASE is always created.
> >=20
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>=20
> Eryu,
>=20
> I think Johannes' commit should actually be reverted. Currently
> get_next_config is called at the beginning of the section code _AFTER_
> _init_kmemleak so it's not really fixing the problem that Johannes
> described. So care to revert his commit ?

get_next_config is always called at the end of common/config as well,
which is sourced before _init_kmemleak, so $RESULT_BASE is created. But
I missed the user-specified RESULT_BASE case, so I think everything is
fine after applying your patch. Thanks for the fix!

Eryu

>=20
> > ---
> >  common/config | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/common/config b/common/config
> > index fb664cf0a967..e2da9cfacbb5 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -663,11 +663,12 @@ get_next_config() {
> >  	# set default RESULT_BASE
> >  	if [ -z "$RESULT_BASE" ]; then
> >  		export RESULT_BASE=3D"$here/results/"
> > -		mkdir -p ${RESULT_BASE}
> > -		if [ ! -d ${RESULT_BASE} ]; then
> > -			echo "failed to create results directory $RESULT_BASE"
> > -			exit 1
> > -		fi
> > +	fi
> > +
> > +	mkdir -p ${RESULT_BASE}
> > +	if [ ! -d ${RESULT_BASE} ]; then
> > +		echo "failed to create results directory $RESULT_BASE"
> > +		exit 1
> >  	fi
> > =20
> >  	if [ "$FSTYP" =3D=3D "tmpfs" ]; then
> >=20
