Received: from mx1.redhat.com ([209.132.183.28]:33650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752457AbdC0Ivf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Mar 2017 04:51:35 -0400
Date: Mon, 27 Mar 2017 16:51:03 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [RFC PATCH] check: try to fix the test device if it gets
 corrupted
Message-ID: <20170327085103.GQ14226@eguan.usersys.redhat.com>
References: <20170302232050.31125-1-tytso@mit.edu>
 <20170303090332.GP14226@eguan.usersys.redhat.com>
 <20170303172157.GA5070@birch.djwong.org>
 <20170303230129.apzqe77r4d5jtf63@thunk.org>
 <20170327014802.wc5as2tdgecy3rzu@thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170327014802.wc5as2tdgecy3rzu@thunk.org>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Ted,

On Sun, Mar 26, 2017 at 09:48:02PM -0400, Theodore Ts'o wrote:
> On Fri, Mar 03, 2017 at 06:01:29PM -0500, Theodore Ts'o wrote:
> > On Fri, Mar 03, 2017 at 09:21:57AM -0800, Darrick J. Wong wrote:
> > >=20
> > > <shrug> The test device isn't supposed to get corrupted, since it (at
> > > least in theory) should be an old filesystem.  That said, I suppose
> > > there's little point in banging around with a corrupt test fs.  Maybe=
 we
> > > could go further and stop running if there's unfixable corruption?
> >=20
> > Yes, that was the other alternative I considered.  In my case, though,
> > since I'm trying to get a sense of how many failures I have to deal
> > with, I really wanted a "make -k" behavior that would continue after
> > the first failure.  After all, all I was going to do was manually run
> > fsck, and then continue the run --- so we might as well have the check
> > script do it automatically and then allow things to continue.
> >=20
> > We could make it be configurable, via a command-line option.  The -k
> > option isn't taken so we could have check -k that works like make -k
> > if you think that's better.  OTOH, perhaps making -k the default
> > behaviour is actually the better way to go, and in that case, maybe
> > it's not worth having the command-line flag?
>=20
> Eryu, do you have any preferences or comments about how you'd like me
> to modify this patch for upstreaming?  (Attached is my current version
> of the patch).
>=20
> Thanks!!

Sorry I lost this thread, I thought I've replied but apparently I didn't..

I agreed with both of you and Darrick, I think we can try to repair the
corrupted test fs, and if repair succeeds we can continue the test, and
stop running the whole test if repair fails.

>=20
> 					- Ted
>=20
> commit 727c737d1f0a40288fc897c0263fbf8e7a5db8b3
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Wed Mar 1 19:54:08 2017 -0500
>=20
>     check: try to fix the test device if it gets corrupted
>=20=20=20=20=20
>     If the test device gets corrupted all subsequent tests will fail.  To
>     prevent this from causing all subsequent tests to be useless, try
>     repair the file system on TEST_DEV if possible.  We don't need to do
>     this with the scratch device since that file system gets recreated
>     each time anyway.
>=20=20=20=20=20
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>=20
> diff --git a/check b/check
> index 2fcf385f..d253f744 100755
> --- a/check
> +++ b/check
> @@ -472,7 +472,11 @@ _summary()
>  _check_filesystems()
>  {
>  	if [ -f ${RESULT_DIR}/require_test ]; then
> -		_check_test_fs || err=3Dtrue
> +		if ! _check_test_fs ; then
> +		    err=3Dtrue
> +		    echo "Trying to repair broken TEST_DEV file system"
> +		    _repair_test_fs

Minor nit, need tab for indention in the if block.

> +		fi
>  		rm -f ${RESULT_DIR}/require_test*
>  	fi
>  	if [ -f ${RESULT_DIR}/require_scratch ]; then
> diff --git a/common/rc b/common/rc
> index 052f67aa..ce491f3f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1172,6 +1172,28 @@ _repair_scratch_fs()
>      esac
>  }
>=20=20
> +_repair_test_fs()
> +{

Minor nit, this function has mixed tab & space for indention too, use
tab for new functions.

> +    case $FSTYP in
> +    ext2|ext3|ext4)
> +        fsck -t $FSTYP -fy $TEST_DEV >$tmp.repair 2>&1
> +	if test $? -ge 4 ; then
> +	    echo "_repair_test_fs: couldn't repair filesystem on $device (see $=
seqres.full)"
> +
> +	    echo "_repair_test_fs: couldn't repair filesystem on $device" >>$se=
qres.full

We have _log_err() to do these to echos now.

> +	    echo "*** fsck.$FSTYP output ***"	>>$seqres.full
> +            cat $tmp.repair			>>$seqres.full
> +	    echo "*** end fsck.$FSTYP output"	>>$seqres.full
> +	    return 1
> +	fi
> +	return 0
> +	;;
> +    *)
> +	return 1

I think we should try to fix other filesystems too?

> +	;;
> +    esac
> +}
> +

And I'm wondering if a new helper function can be factored out and used
in both _repair_scratch_fs and _repair_scratch_fs? One of the problems I
see in doing this is that we don't have a _test_xfs_repair() counterpart
right now.

Thanks,
Eryu

>  _get_pids_by_name()
>  {
>      if [ $# -ne 1 ]
--
To unsubscribe from this list: send the line "unsubscribe fstests" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__vger.kernel.org_majordomo-2Dinfo.html&d=3DDwIBAg&c=3DRoP1YumCXCgaWHvlZYR=
8PQcxBKCX5YTpkKY057SbK10&r=3D-yMrTV4jriXR7ieyzzjV-QgHBD0UDw8ixoR77aMeAHE&m=
=3D0soB5gI1r50psvTdjA1KUFEWFkn9WxV3nD1owmmUN_w&s=3DhxbjQYhJ222LOmb3FrPhlXqW=
0DiWVx4j_ZNiQGQF1ok&e=3D=20
