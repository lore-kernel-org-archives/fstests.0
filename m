Received: from mail-pl0-f65.google.com ([209.85.160.65]:40684 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753149AbeFGLNz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Jun 2018 07:13:55 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so5922451plo.7
        for <fstests@vger.kernel.org>; Thu, 07 Jun 2018 04:13:54 -0700 (PDT)
Date: Thu, 7 Jun 2018 19:13:48 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] generic/401: fix test in case of no filetype support
Message-ID: <20180607111348.GI2861@desktop>
References: <1528186130-22854-1-git-send-email-amir73il@gmail.com>
 <c6dee1d1-f737-c60d-865b-b4b08e43b6d2@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6dee1d1-f737-c60d-865b-b4b08e43b6d2@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: xuhuan <xuhuan.fnst@cn.fujitsu.com>
Cc: Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 06, 2018 at 10:02:37AM +0800, xuhuan wrote:
> Hi
> 
> I have tested it passed on nfs.

What version of NFS are you testing? And what's your kernel version? I
couldn't reproduce the test failure on NFS (tried v4.[012] and v3) with
v4.17-rc5 kernel. Just want to make sure I didn't miss anything.

Thanks,
Eryu

> 
> thanks.
> 
> On 06/05/18 16:08, Amir Goldstein wrote:
> > Xu Huan reported that this test fails on nfs in some setup.
> > Apparently, the assumptions made about xfs/ext* do not hold
> > for nfs.
> >
> > Relax the verification of filetype not supported case to
> > allow either DT_UNKNOWN or actual file type on all files and
> > not only on special dir entires "." and "..".
> >
> > Convert the unknown d_type replacement code from awk to bash
> > so it is a bit more readable and flexible.
> Tested-by:Xu Huan <xuhuan.fnst@cn.fujitsu.com>
> > Reported-by: Xu Huan <xuhuan.fnst@cn.fujitsu.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Xu,
> >
> > Please check if this patch fixes your problem.
> > I prefer to keep the test coverage of unsupported case.
> >
> > I tested with xfs/ext4 with/without filetype support.
> >
> > Thanks,
> > Amir.
> >
> >  tests/generic/401 | 42 ++++++++++++++++++++----------------------
> >  1 file changed, 20 insertions(+), 22 deletions(-)
> >
> > diff --git a/tests/generic/401 b/tests/generic/401
> > index 74f2bea..34ce76e 100755
> > --- a/tests/generic/401
> > +++ b/tests/generic/401
> > @@ -4,14 +4,13 @@
> >  # Test filetype feature
> >  #
> >  # This test does NOT require that file system support the d_type feature.
> > -# It verifies that either all file types are reported as DT_UNKNOWN
> > -# or all file types are reported correctly.
> > +# It verifies that file types are reported as either DT_UNKNOWN or as
> > +# the actual file type. For example, special dir entries . and .. MAY be
> > +# reported as DT_UNKNOWN IF filetype feature is disabled (ext4), but MAY
> > +# also be reported as DT_DIR in this case (xfs).
> >  #
> >  # For fs for which we know how to test the filetype feature (xfs|ext*)
> >  # verify getting DT_UNKNOWN IFF feature is disabled.
> > -# Special dir entries . and .. MAY be reported as DT_UNKNOWN IF filetype
> > -# feature is disabled (ext4), but MAY also be reported as DT_DIR in this
> > -# case (xfs).
> >  #
> >  #-----------------------------------------------------------------------
> >  #
> > @@ -73,23 +72,22 @@ mknod $testdir/c c 1 1
> >  mknod $testdir/b b 1 1
> >  mknod $testdir/p p
> >  
> > -# Test d_type of . and ..
> > -# it must be DT_DIR on fs with filetype support and it could be
> > -# either DR_DIR or DT_UNKNOWN on fs without filetype support
> > -src/t_dir_type $testdir d | grep -F '.' | sort
> > -
> > -# Test that either all file types are unknown or all are correct
> > -if _supports_filetype $SCRATCH_MNT; then
> > -	# print real file types
> > -	src/t_dir_type $testdir | grep -vF '.' | sort
> > -else
> > -	# print fake dir file type for . and .. if they are DT_UNKNOWN
> > -	src/t_dir_type $testdir u | grep -F '.' | \
> > -		awk '{ print $1, "d" }' | sort
> > -	# list unknown files and print filename as fake file type
> > -	src/t_dir_type $testdir u | grep -vF '.' | \
> > -		awk '{ print $1, $1 }' | sort
> > -fi
> > +# Test d_type of test files - it must be the actual file type on fs
> > +# with filetype support and it could be either the actual file type
> > +# or DT_UNKNOWN on fs without filetype support
> > +ftype=
> > +_supports_filetype $SCRATCH_MNT && ftype=1
> > +src/t_dir_type $testdir | \
> > +while read name type; do
> > +	if [ "$ftype" != 1 -a "$type" = u ]; then
> > +		if [ "$name" = "." -o "$name" = ".." ]; then
> > +			type=d
> > +		else
> > +			type=$name
> > +		fi
> > +	fi
> > +	echo $name $type
> > +done | sort
> >  
> >  status=0
> >  exit
> 
> 
> 
