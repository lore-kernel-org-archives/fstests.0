Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4E1D8DEE
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248369; cv=none; b=r8oKeDJ3Qh65BWQPJ3DnuTpP3EWPde/OA307iYjx5LjGSbMSplmwQ1fWf5ThD/LljX4tN3De43yuCzNO9FQyZvqR7yaFuqTtpjyobiwroX84G1ho/RcEjjmMELka9YwbXninFbMOr7vLr4e6+YvMssabf4gAlb8PAGpSbyoMLQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248369; c=relaxed/simple;
	bh=Q4qcNWktyDKNrWa60Le1ifoOFMKhlGeSS1zp/G6PkDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFz86VMxGvZH40VXmCNv21qvQoHFXwm6gpURGXJn8nM/kOW2cnrFe70PKS60nDKT41gBaAgauExH3GUVoB/Dpq5aWN7yzxf7NZKYqSgChLyoLCbT5IINl6QGARXiZc4K68ZuhhM8WRxPGiDRfVb+68b5Wf58v1tSDDl/FwSimng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EeQpI3QF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EeQpI3QF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741248364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/NeOHd+t1tsDnS3n4x6LuDJXrM6IOwzn+pCdF92Eac=;
	b=EeQpI3QFT/uE8VZFnyI9Jw3JjUcwZar1cXlUVQJKFAM4Zq7lj8JPIqMkWmg3P8xDxRacSx
	dRimBpYmlcwr1BJu2p5vBE7asfJm/Kho0QXjX4J8LF87IGPSB3QLlQ9jL5gFB444QKKvxp
	R7qjj0wJsm0wHtf+2InVmsaDuZ2Dl50=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-5rOIgKB_Og2pFKPPHmdvUQ-1; Thu, 06 Mar 2025 03:05:53 -0500
X-MC-Unique: 5rOIgKB_Og2pFKPPHmdvUQ-1
X-Mimecast-MFC-AGG-ID: 5rOIgKB_Og2pFKPPHmdvUQ_1741248352
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so598374a91.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 00:05:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741248352; x=1741853152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/NeOHd+t1tsDnS3n4x6LuDJXrM6IOwzn+pCdF92Eac=;
        b=HpeMxJ2sL2oS6MSTIqi95iD1bC0ShXnG+KGNo7FJvoUwk5Bc0svmRtDMSTB4nvYTkS
         LDAh/Fu3pd8X712Ya3vL6Bc5fvxWbhFOnbmSQ9Ijm3dY8AzR/B8gXSdDGdr0bW/yV69a
         8B9sf0du4jkndwUd1T0b7uyBE/tIFdcdM/1j6DkNoUoZCJOkT+lHtbNQkFfTNyyl6M60
         G02rnPI32WXCWOKdVbTp0vUp01cx/T3/5TBVBZyYKAEUcH3mFm/bzI7qxMPTI/12+yPZ
         fcp9dBCKXwpVfkdsUImWHjN/+r6VTP5ae6P2AV9OCTbkg9xlUVbQsBhcZmQkB+gkJLoW
         TP/A==
X-Forwarded-Encrypted: i=1; AJvYcCWwVWMCdOm8U048Tm3CTOtBjHJWOOLhAftosaXGtLtKXA+eWt+bUmc8OetjSm1Zip21W9NS9db9@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbZqfUuWqe56GaB1Ok5ssop4zESPTnNuJa8W+VeSvx5T268Yn
	FNgVhq5rK5I2n5vsph83UXPJ+nCE/i2RZMtZoqXcXKS1dofRVFqA2KZdHUV3C7E8d+216DKyYzK
	9kSW2U2jXgMNRJTgUnJ8OPGUsrhyEXl2Ztk0lnl9AFVVRLWaevvau+RY=
X-Gm-Gg: ASbGncs0Ak3UE3oiUfqm88u+flzIiyxDLrX0lO/IT+M8Pllwiu3eQsv/UOOKBewd83D
	m4X6CNFGpECvylFjSz93MJgkLcyizgwJCT30BH/70u4H8RCrgm5Ap2XAOyH0jnjYJWn7sV8f2Po
	dNA+V1nXr5e3LM4dpt8ewPRKMHSEOJMg1OyFCILnwTn7VNNlvEsbXcoPhB3YS9RkapBNAVTHIC7
	hfHMdMTcAw6ZrfJJ/5K7XIuJq56Z2jDwhRCUjiUzRSA4PvmYp9PcaPSwwuOXpKkJ/TeJkBlK78c
	o2vM71eE5QXWUqj8qCWBgFSaD9js50OSQcamPsecfOI0lZxu+7p85fYX
X-Received: by 2002:a17:90b:498d:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-2ff497c2d0emr10556694a91.29.1741248351822;
        Thu, 06 Mar 2025 00:05:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFghhZJ6hJ03P55TszXkhl1RHqrLspBbkqSZ0788NKuhOP6cl7iYJ571WZJEyXncXMdqfFezA==
X-Received: by 2002:a17:90b:498d:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-2ff497c2d0emr10556648a91.29.1741248351324;
        Thu, 06 Mar 2025 00:05:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6935335asm655358a91.13.2025.03.06.00.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:05:50 -0800 (PST)
Date: Thu, 6 Mar 2025 16:05:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] check: disable HAVE_PRIVATENS by default
Message-ID: <20250306080546.prri7tytjjcrnv72@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250303205046.667838-1-zlang@kernel.org>
 <20250304200458.GA2803771@frogsfrogsfrogs>
 <20250304204301.6dbp4hijwaehxzqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250304205942.GB2803771@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304205942.GB2803771@frogsfrogsfrogs>

On Tue, Mar 04, 2025 at 12:59:42PM -0800, Darrick J. Wong wrote:
> On Wed, Mar 05, 2025 at 04:43:01AM +0800, Zorro Lang wrote:
> > On Tue, Mar 04, 2025 at 12:04:58PM -0800, Darrick J. Wong wrote:
> > > On Tue, Mar 04, 2025 at 04:50:46AM +0800, Zorro Lang wrote:
> > > > Currently we have 3 ways to run a test case in _run_seq():
> > > > 
> > > >   if [ -n "${HAVE_PRIVATENS}" ]; then
> > > >       ./tools/run_privatens "./$seq"
> > > >       ...
> > > >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> > > >       systemd-run --quiet --unit "${unit}" --scope \
> > > >              ./tools/run_setsid "./$seq" &
> > > >       ...
> > > >   else
> > > >       ./tools/run_setsid "./$seq" &
> > > >       ...
> > > >   fi
> > > > 
> > > > The "privatens" way brings in some regressions. We need more time
> > > > to develop and test this way, it's not time let it to be the
> > > > first default choice, so isolate the HAVE_PRIVATENS initialization
> > > > by a TRY_PRIVATENS parameter, and disable it by default.
> > > > 
> > > > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > > > old ways. This patch can be removed after "privatens" way is stable.
> > > 
> > > I think it's ok to turn off privatens for now, seeing as it's clearly
> > > caused some regressions that I don't know how to fix.  The ones I know
> > > about are:
> > > 
> > > 1. The btrfs/14[01] use of BASHPID (not fixed)
> > > 2. The weird flock thing in generic/504 (fixed)
> > 
> > And a bug report when /tmp isn't a mount point.
> 
> Oh yeah.  Forgot that one.  We could fix it this way:
> 
> diff --git a/check b/check
> index ea92b0d62a..7196cfbfea 100755
> --- a/check
> +++ b/check
> @@ -821,6 +821,20 @@ function run_section()
>  		echo "SECTION       -- $section"
>  	fi
>  
> +	# If we're running in a private mount namespace, /tmp is a private
> +	# directory.  We /could/ just mkdir it, but we'd rather have people
> +	# set those paths elsewhere.
> +	if [ "$HAVE_PRIVATENS" = yes ] && [[ $TEST_DIR =~ ^\/tmp ]]; then
> +		echo "$TEST_DIR: TEST_DIR must not be in /tmp"
> +		status=1
> +		exit
> +	fi
> +	if [ "$HAVE_PRIVATENS" = yes ] && [[ $SCRATCH_MNT =~ ^\/tmp ]]; then
> +		echo "$SCRATCH_MNT: SCRATCH_MNT must not be in /tmp"
> +		status=1
> +		exit
> +	fi
> +
>  	sect_start=`_wallclock`
>  	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
>  		echo "RECREATING    -- $FSTYP on $TEST_DEV"

Oh, I didn't describe clearly, I mean this one bug:
https://lore.kernel.org/fstests/20250303064209.602577-1-naohiro.aota@wdc.com/

some systems might not have a tmpfs on /tmp ^^ I'll leave more review points
under that thread.

> 
> Or we could just have _begin_fstest mkdir them if they don't exist.
> 
> Unless it'd make more sense to have ./check define TEST_DIR and
> SCRATCH_MNT itself?  Imagine if it instead did this:
> 
> 	FSTESTS_RUN_DIR=/run/fstests-$$
> 	mkdir -p $FSTESTS_RUN_DIR
> 	mount -t tmpfs none $FSTESTS_RUN_DIR

Do you hope to have TEST_DIR and SCRATCH_MNT under a tmpfs?

> 	test -n "$TEST_DEV" && mkdir -p $FSTESTS_RUN_DIR/test
> 	test -n "$SCRATCH_MNT" && $FSTESTS_RUN_DIR/scratch
> 	mount -o remount,ro $FSTESTS_RUN_DIR
> 	test -n "$TEST_DEV" && TEST_DIR=$FSTESTS_RUN_DIR/test
> 	test -n "$SCRATCH_MNT" && SCRATCH_MNT=$FSTESTS_RUN_DIR/scratch
> 
> Now the user doesn't have to create the directories themselves, and
> since the underlying $FSTESTS_RUN_DIR is read only, mount failures will
> show up immediately as write failures instead of filling up the wrong
> filesystem.

I think we can talk about more details in another thread.

Thanks,
Zorro

> 
> --D
> 
> > > But then there's a bunch more complaints about "everything" being
> > > broken.  If things are still broken for you, please send detailed dumps
> > > and let Zorro and I figure that out.
> > > 
> > > Note that run_privatens is a lot cleaner than run_setsid -- as I've
> > > stated elsewhere, using a new unix process session id to run a test is
> > > very messy -- there's no longer a controlling tty, so SIGSTOP doesn't
> > > work and SIGINT is masked by default.
> > > 
> > > As I suggested elsewhere today, maybe the solution is to have the tests
> > > that *require* the global pid namespace (anything calling the
> > > btrfs*read*mirror* helpers) turn themselves off with a
> > > "_require_non_privatens"; and then ./check can select setsid for any
> > > test containing that phrase.
> > > 
> > > Thoughts on this part?
> > 
> > More likes a trick, anyway I think we can talk about the way to fix btrfs
> > BASHPID related problems later. And I still don't know if it's the same
> > root cause with Dave Sterba hit.
> > 
> > > 
> > > --
> > > 
> > > I'm ok with taking the quickest route to something that makes everyone
> > > happy so that we can push to master again, and merge other peoples'
> > > changes because I bet those have been backing up for a while.
> > > 
> > > It's clearly time to talk about reorganizing who's responsible for
> > > reviews and for pushing git tree changes, and to take pressure off
> > > Zorro.  Anand has been signalling interest in taking on some of the
> > > btrfs workload, and I think that should happen in some form because
> > > Zorro and I are clearly outmatched.
> > 
> > Acutally I've tried to test most of major fs which fstests supports,
> > before a release. Btrfs testing is supported by my test scripts now.
> > Currently only default btrfs be tested. If Anand would like to test
> > more for btrfs before each release, I think that helps btrfs more.
> > 
> > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > ---
> > > > 
> > > > Hi,
> > > > 
> > > > This patch aims to be talked. Refer to above commit log. This patch
> > > > is a workaround for 2 targets:
> > > > 1) Avoid the regressions of lastest xfstests release.
> > > > 2) Give us more time to improve the "privatens" method.
> > > > 
> > > > And compare with revert that commit directly, this patch trys to
> > > > give "privatens" method a chance to be enabled and tested (by
> > > > export TRY_PRIVATENS=yes).
> > > 
> > > Everyone else: do things work better if you manually patch out the
> > > run_privatens selection code so that run_setsid is always used?  The
> > > setsid code itself is also new; before that fstests just used killall.
> > 
> > If no one reports bugs to run_setsid, I'll think it's stable (temporarily),
> > then we'll pay more attention to "privatens".
> > 
> > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > >  check | 22 +++++++---------------
> > > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/check b/check
> > > > index ea92b0d62..33eb3e085 100755
> > > > --- a/check
> > > > +++ b/check
> > > > @@ -674,10 +674,13 @@ _stash_test_status() {
> > > >  	esac
> > > >  }
> > > >  
> > > > -# Can we run in a private pid/mount namespace?
> > > > -HAVE_PRIVATENS=
> > > > -./tools/run_privatens bash -c "exit 77"
> > > > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > > > +# Don't try "privatens" by default, it's experimental for now.
> > > > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > > > +	# Can we run in a private pid/mount namespace?
> > > > +	HAVE_PRIVATENS=
> > > > +	./tools/run_privatens bash -c "exit 77"
> > > > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > > > +fi
> > > >  # Can we run systemd scopes?
> > > >  HAVE_SYSTEMD_SCOPES=
> > > > @@ -692,15 +695,6 @@ function _adjust_oom_score() {
> > > >  }
> > > >  _adjust_oom_score -500
> > > >  
> > > > -warn_deprecated_sessionid()
> > > > -{
> > > > -	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
> > > > -		echo "WARNING: Running fstests without private pid/mount namespace"
> > > > -		echo "support is deprecated and will be removed in February 2026."
> > > > -		WARNED_DEPRECATED_SESSIONID=1
> > > > -	fi
> > > > -}
> > > > -
> > > >  # ...and make the tests themselves somewhat more attractive to it, so that if
> > > >  # the system runs out of memory it'll be the test that gets killed and not the
> > > >  # test framework.  The test is run in a separate process without any of our
> > > > @@ -900,8 +894,6 @@ function run_section()
> > > >  	seqres="$check"
> > > >  	_check_test_fs
> > > >  
> > > > -	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
> > > > -
> > > 
> > > Removal of the deprecation should be a separate patch, for which I will
> > > pre-offer a
> > > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> > 
> > Ok, I'll splite this patch and send a v2. Thanks your reviewing!
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > >  	loop_status=()	# track rerun-on-failure state
> > > >  	local tc_status ix
> > > >  	local -a _list=( $list )
> > > > -- 
> > > > 2.47.1
> > > > 
> > > 
> > 
> 

