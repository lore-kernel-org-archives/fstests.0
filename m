Received: from mx2.suse.de ([195.135.220.15]:37933 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936494AbeE2QgF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:36:05 -0400
Date: Tue, 29 May 2018 18:36:04 +0200
From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] Make ./new work for non-root user
Message-ID: <20180529163604.sfzx3337gybgjqfi@quack2.suse.cz>
References: <20180524183055.16031-1-jack@suse.cz>
 <20180529013914.GI23861@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529013914.GI23861@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue 29-05-18 11:39:14, Dave Chinner wrote:
> On Thu, May 24, 2018 at 08:30:55PM +0200, Jan Kara wrote:
> > Currently 'new' script sources common/config which tries to find mkfs
> > and fails if not found (which is likely for non-root user). This is
> > inconvenient as development usually does not happen as root. In fact the
> > vast majority of setup in common/config and common/rc is not necessary
> > for 'new'. Split out the necessary bits into new common/config-base and
> > use it in 'new'. Cleanup common/rc and common/config now that it's only
> > used from 'check'.
> 
> FWIW, common/config is also called from setup.

Fixed up.

> > diff --git a/check b/check
> > index 96198ac4714e..4c6e8285bc16 100755
> > --- a/check
> > +++ b/check
> > @@ -331,10 +331,11 @@ while [ $# -gt 0 ]; do
> >  	shift
> >  done
> >  
> > -# we need common/config, source it after processing args, overlay needs FSTYP
> > -# set before sourcing common/config
> > -if ! . ./common/config; then
> > -	echo "$iam: failed to source common/config"
> > +# we need common/rc, that also sources common/config. We need to source it
> > +# after processing args, overlay needs FSTYP set before sourcing common/config
> > +if ! . ./common/rc
> > +then
> > +	echo "check: failed to source common/rc"
> >  	exit 1
> >  fi
> 
> Can we keep the existing formatting of "if foo ; then", please?

Will do.

> > diff --git a/common/config b/common/config
> > index af360cefc804..fa07a6799824 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -47,6 +47,8 @@
> >  #   validity or mountedness.
> >  #
> >  
> > +. common/config-base
> > +
> >  # all tests should use a common language setting to prevent golden
> >  # output mismatches.
> >  export LANG=C
> > @@ -88,12 +90,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
> >  
> >  export RECREATE_TEST_DEV=false
> >  
> > -# $1 = prog to look for
> > -set_prog_path()
> > -{
> > -	type -P $1
> > -}
> 
> Can we just get rid of set_prog_path() and replace it with direct
> calls to $(type -P foo) as an initial patch? This goes away at that
> point, because new can then just use a locally coded version....

I've added your patch to the series. Thanks!

> > --- /dev/null
> > +++ b/common/config-base
> > @@ -0,0 +1,21 @@
> > +##/bin/bash
> > +
> > +# Valid test names start with 3 digits "NNN":
> > +#  "[0-9]\{3\}"
> > +# followed by an optional "-":
> > +#  "-\?"
> > +# followed by an optional combination of alphanumeric and "-" chars:
> > +#  "[[:alnum:]-]*"
> > +# e.g. 999-the-mark-of-fstests
> > +#
> > +VALID_TEST_ID="[0-9]\{3\}"
> > +VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
> 
> This, then, is really the only thing shared between check and new,
> right? So perhaps rename the file to common/test_names so it doesn't
> get confused with stuff to do with configuration?

OK, there's also the AWK_PROG thing but I've decided to just have that
directly in 'new'. There's not much to break there.

Thanks for review!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
