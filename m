Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C755335BA
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121984; cv=none; b=Rf5x9Vk5ANQFQqEzEkfgxlWkjVXsYh5LVB60eIBIYKqOvwHynGcioBdkgOL45+E5SAr9AII9/A42adFXVGsI85Pb868lw5flxzPr8v7wGSMLWqSqGanjvE8t3xtoVoYwGDhikDiN5etohiPlDma0a9nYIoF00k7/zmDGlr86RTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121984; c=relaxed/simple;
	bh=iKZWZiKWl2pJhwxLayRh6L+jNl7eoaMKmCAD13wpXnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHvnVuaHhoBISdvD6nsQKYrlBFlQxBkmP6EI5JZysQZk0/JXg0AMYJiy6xiUS4cGg0MFNT3LxWPXgRJmvMilU/B4gMyiXlqH1sxTO6/gDJCJA+uBTlQHHPck0SZiNaKexrfJC9Iyi8XmrSh/ySrsiChHaFtmWoBg+JsVhbD1AuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ij1ptgtE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ij1ptgtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D609C4CEE5;
	Tue,  4 Mar 2025 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741121983;
	bh=iKZWZiKWl2pJhwxLayRh6L+jNl7eoaMKmCAD13wpXnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ij1ptgtEYqAGR/QO/F3P6APHir869VRC6POD9aPZ2hqPMhi960qu0FcJHODwkvxy4
	 hlzaPCmAX/gDPANnCjiISgfcfzhhNiDlqAahAwubiVIFn9nE/wyLFLw/v2UeYvsjza
	 JmlWeVloVInZFisc4bTkofaez2UzIcb7aQZrPZtlCUJeJvPUbdivzGdYi7t1HZI2Nd
	 FFVlJepxsSHtJWne3ktJqPCwcdR5uySYTbBuJ6a5CEhzb06DZos4cMgx7jTkg7PLpW
	 7NMeKX3htRZ6VlU+afaSY3wsvPPdF+aENRNp1ESjKGZ6izEDCzN5Jt0XFVUzsTx+89
	 uBhoKrmTviw6A==
Date: Tue, 4 Mar 2025 12:59:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] check: disable HAVE_PRIVATENS by default
Message-ID: <20250304205942.GB2803771@frogsfrogsfrogs>
References: <20250303205046.667838-1-zlang@kernel.org>
 <20250304200458.GA2803771@frogsfrogsfrogs>
 <20250304204301.6dbp4hijwaehxzqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304204301.6dbp4hijwaehxzqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Wed, Mar 05, 2025 at 04:43:01AM +0800, Zorro Lang wrote:
> On Tue, Mar 04, 2025 at 12:04:58PM -0800, Darrick J. Wong wrote:
> > On Tue, Mar 04, 2025 at 04:50:46AM +0800, Zorro Lang wrote:
> > > Currently we have 3 ways to run a test case in _run_seq():
> > > 
> > >   if [ -n "${HAVE_PRIVATENS}" ]; then
> > >       ./tools/run_privatens "./$seq"
> > >       ...
> > >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> > >       systemd-run --quiet --unit "${unit}" --scope \
> > >              ./tools/run_setsid "./$seq" &
> > >       ...
> > >   else
> > >       ./tools/run_setsid "./$seq" &
> > >       ...
> > >   fi
> > > 
> > > The "privatens" way brings in some regressions. We need more time
> > > to develop and test this way, it's not time let it to be the
> > > first default choice, so isolate the HAVE_PRIVATENS initialization
> > > by a TRY_PRIVATENS parameter, and disable it by default.
> > > 
> > > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > > old ways. This patch can be removed after "privatens" way is stable.
> > 
> > I think it's ok to turn off privatens for now, seeing as it's clearly
> > caused some regressions that I don't know how to fix.  The ones I know
> > about are:
> > 
> > 1. The btrfs/14[01] use of BASHPID (not fixed)
> > 2. The weird flock thing in generic/504 (fixed)
> 
> And a bug report when /tmp isn't a mount point.

Oh yeah.  Forgot that one.  We could fix it this way:

diff --git a/check b/check
index ea92b0d62a..7196cfbfea 100755
--- a/check
+++ b/check
@@ -821,6 +821,20 @@ function run_section()
 		echo "SECTION       -- $section"
 	fi
 
+	# If we're running in a private mount namespace, /tmp is a private
+	# directory.  We /could/ just mkdir it, but we'd rather have people
+	# set those paths elsewhere.
+	if [ "$HAVE_PRIVATENS" = yes ] && [[ $TEST_DIR =~ ^\/tmp ]]; then
+		echo "$TEST_DIR: TEST_DIR must not be in /tmp"
+		status=1
+		exit
+	fi
+	if [ "$HAVE_PRIVATENS" = yes ] && [[ $SCRATCH_MNT =~ ^\/tmp ]]; then
+		echo "$SCRATCH_MNT: SCRATCH_MNT must not be in /tmp"
+		status=1
+		exit
+	fi
+
 	sect_start=`_wallclock`
 	if $RECREATE_TEST_DEV || [ "$OLD_FSTYP" != "$FSTYP" ]; then
 		echo "RECREATING    -- $FSTYP on $TEST_DEV"

Or we could just have _begin_fstest mkdir them if they don't exist.

Unless it'd make more sense to have ./check define TEST_DIR and
SCRATCH_MNT itself?  Imagine if it instead did this:

	FSTESTS_RUN_DIR=/run/fstests-$$
	mkdir -p $FSTESTS_RUN_DIR
	mount -t tmpfs none $FSTESTS_RUN_DIR
	test -n "$TEST_DEV" && mkdir -p $FSTESTS_RUN_DIR/test
	test -n "$SCRATCH_MNT" && $FSTESTS_RUN_DIR/scratch
	mount -o remount,ro $FSTESTS_RUN_DIR
	test -n "$TEST_DEV" && TEST_DIR=$FSTESTS_RUN_DIR/test
	test -n "$SCRATCH_MNT" && SCRATCH_MNT=$FSTESTS_RUN_DIR/scratch

Now the user doesn't have to create the directories themselves, and
since the underlying $FSTESTS_RUN_DIR is read only, mount failures will
show up immediately as write failures instead of filling up the wrong
filesystem.

--D

> > But then there's a bunch more complaints about "everything" being
> > broken.  If things are still broken for you, please send detailed dumps
> > and let Zorro and I figure that out.
> > 
> > Note that run_privatens is a lot cleaner than run_setsid -- as I've
> > stated elsewhere, using a new unix process session id to run a test is
> > very messy -- there's no longer a controlling tty, so SIGSTOP doesn't
> > work and SIGINT is masked by default.
> > 
> > As I suggested elsewhere today, maybe the solution is to have the tests
> > that *require* the global pid namespace (anything calling the
> > btrfs*read*mirror* helpers) turn themselves off with a
> > "_require_non_privatens"; and then ./check can select setsid for any
> > test containing that phrase.
> > 
> > Thoughts on this part?
> 
> More likes a trick, anyway I think we can talk about the way to fix btrfs
> BASHPID related problems later. And I still don't know if it's the same
> root cause with Dave Sterba hit.
> 
> > 
> > --
> > 
> > I'm ok with taking the quickest route to something that makes everyone
> > happy so that we can push to master again, and merge other peoples'
> > changes because I bet those have been backing up for a while.
> > 
> > It's clearly time to talk about reorganizing who's responsible for
> > reviews and for pushing git tree changes, and to take pressure off
> > Zorro.  Anand has been signalling interest in taking on some of the
> > btrfs workload, and I think that should happen in some form because
> > Zorro and I are clearly outmatched.
> 
> Acutally I've tried to test most of major fs which fstests supports,
> before a release. Btrfs testing is supported by my test scripts now.
> Currently only default btrfs be tested. If Anand would like to test
> more for btrfs before each release, I think that helps btrfs more.
> 
> > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > > 
> > > Hi,
> > > 
> > > This patch aims to be talked. Refer to above commit log. This patch
> > > is a workaround for 2 targets:
> > > 1) Avoid the regressions of lastest xfstests release.
> > > 2) Give us more time to improve the "privatens" method.
> > > 
> > > And compare with revert that commit directly, this patch trys to
> > > give "privatens" method a chance to be enabled and tested (by
> > > export TRY_PRIVATENS=yes).
> > 
> > Everyone else: do things work better if you manually patch out the
> > run_privatens selection code so that run_setsid is always used?  The
> > setsid code itself is also new; before that fstests just used killall.
> 
> If no one reports bugs to run_setsid, I'll think it's stable (temporarily),
> then we'll pay more attention to "privatens".
> 
> > 
> > > Thanks,
> > > Zorro
> > > 
> > >  check | 22 +++++++---------------
> > >  1 file changed, 7 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/check b/check
> > > index ea92b0d62..33eb3e085 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -674,10 +674,13 @@ _stash_test_status() {
> > >  	esac
> > >  }
> > >  
> > > -# Can we run in a private pid/mount namespace?
> > > -HAVE_PRIVATENS=
> > > -./tools/run_privatens bash -c "exit 77"
> > > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > > +# Don't try "privatens" by default, it's experimental for now.
> > > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > > +	# Can we run in a private pid/mount namespace?
> > > +	HAVE_PRIVATENS=
> > > +	./tools/run_privatens bash -c "exit 77"
> > > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > > +fi
> > >  # Can we run systemd scopes?
> > >  HAVE_SYSTEMD_SCOPES=
> > > @@ -692,15 +695,6 @@ function _adjust_oom_score() {
> > >  }
> > >  _adjust_oom_score -500
> > >  
> > > -warn_deprecated_sessionid()
> > > -{
> > > -	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
> > > -		echo "WARNING: Running fstests without private pid/mount namespace"
> > > -		echo "support is deprecated and will be removed in February 2026."
> > > -		WARNED_DEPRECATED_SESSIONID=1
> > > -	fi
> > > -}
> > > -
> > >  # ...and make the tests themselves somewhat more attractive to it, so that if
> > >  # the system runs out of memory it'll be the test that gets killed and not the
> > >  # test framework.  The test is run in a separate process without any of our
> > > @@ -900,8 +894,6 @@ function run_section()
> > >  	seqres="$check"
> > >  	_check_test_fs
> > >  
> > > -	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
> > > -
> > 
> > Removal of the deprecation should be a separate patch, for which I will
> > pre-offer a
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Ok, I'll splite this patch and send a v2. Thanks your reviewing!
> 
> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > >  	loop_status=()	# track rerun-on-failure state
> > >  	local tc_status ix
> > >  	local -a _list=( $list )
> > > -- 
> > > 2.47.1
> > > 
> > 
> 
