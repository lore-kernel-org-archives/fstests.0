Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FC91F37C3
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118699; cv=none; b=pjUumPTks2Zcanpw7UbMX5pk/bt1vnuVrGh56JbL63YjyYkcWNrBdzx+9tSg1VgXfaUDZctm6/dlpc3oEaJqxSlqNss85/86SfZaLK29pxP8ByxMgBgr4rYWGk/3CM9hcrhhplQHMHqU4Nhjc6RssSh5U3SUSgwgqmaabhFz8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118699; c=relaxed/simple;
	bh=AhVJGCRXyeIAB30eXu4t894gaeffYQPvqpo8zqU80l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmFkB60NDa+qpKgm1l24VNeFcnbCc84pbwUcXqutrR5Kd+BlyKPLA4tbT9vEa1yiJvE8C96919XPjpXzSist3zJtHGOD5uBXqPn3jRBfEunwktBdLIF3CgZENn3d+kULeooSuPihNutFnb+nyQ+jq++0sXYtBFyO5D+tELGR3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooaIREmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooaIREmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9165C4CEE5;
	Tue,  4 Mar 2025 20:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741118698;
	bh=AhVJGCRXyeIAB30eXu4t894gaeffYQPvqpo8zqU80l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooaIREmKC3h75TbtdTPH0rHgDWMrM4428cV8yzQcj2f9iceAbOzX1XrW5JNl+gIdJ
	 cLCpIE0KanOBLi9BbAO3QpoOj+3rAeHqY1fK7BhaZV+w9/eeYf41Rtv1spcqsbXxtJ
	 RkylfqLr8dNvb9B5Qhz5ZPxoYlcAmsow+Q5wWm1GOXsyf3YMzSBPhJ5kNXposjr4BY
	 d0dy32s5q+2UrJ94g9NtvymHwOfjsTyP4jC1Nb8xAAjk81I8avYVFxsct3++4rDm7A
	 YAlYCT6Tfo2C0/sHT+csHEs/jdFK12rvF5+UFYVSbtQ3IOTgNh2h9sPr9GZPRqqeYY
	 o62mvO29/r8NA==
Date: Tue, 4 Mar 2025 12:04:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] check: disable HAVE_PRIVATENS by default
Message-ID: <20250304200458.GA2803771@frogsfrogsfrogs>
References: <20250303205046.667838-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303205046.667838-1-zlang@kernel.org>

On Tue, Mar 04, 2025 at 04:50:46AM +0800, Zorro Lang wrote:
> Currently we have 3 ways to run a test case in _run_seq():
> 
>   if [ -n "${HAVE_PRIVATENS}" ]; then
>       ./tools/run_privatens "./$seq"
>       ...
>   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
>       systemd-run --quiet --unit "${unit}" --scope \
>              ./tools/run_setsid "./$seq" &
>       ...
>   else
>       ./tools/run_setsid "./$seq" &
>       ...
>   fi
> 
> The "privatens" way brings in some regressions. We need more time
> to develop and test this way, it's not time let it to be the
> first default choice, so isolate the HAVE_PRIVATENS initialization
> by a TRY_PRIVATENS parameter, and disable it by default.
> 
> Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> old ways. This patch can be removed after "privatens" way is stable.

I think it's ok to turn off privatens for now, seeing as it's clearly
caused some regressions that I don't know how to fix.  The ones I know
about are:

1. The btrfs/14[01] use of BASHPID (not fixed)
2. The weird flock thing in generic/504 (fixed)

But then there's a bunch more complaints about "everything" being
broken.  If things are still broken for you, please send detailed dumps
and let Zorro and I figure that out.

Note that run_privatens is a lot cleaner than run_setsid -- as I've
stated elsewhere, using a new unix process session id to run a test is
very messy -- there's no longer a controlling tty, so SIGSTOP doesn't
work and SIGINT is masked by default.

As I suggested elsewhere today, maybe the solution is to have the tests
that *require* the global pid namespace (anything calling the
btrfs*read*mirror* helpers) turn themselves off with a
"_require_non_privatens"; and then ./check can select setsid for any
test containing that phrase.

Thoughts on this part?

--

I'm ok with taking the quickest route to something that makes everyone
happy so that we can push to master again, and merge other peoples'
changes because I bet those have been backing up for a while.

It's clearly time to talk about reorganizing who's responsible for
reviews and for pushing git tree changes, and to take pressure off
Zorro.  Anand has been signalling interest in taking on some of the
btrfs workload, and I think that should happen in some form because
Zorro and I are clearly outmatched.

> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> This patch aims to be talked. Refer to above commit log. This patch
> is a workaround for 2 targets:
> 1) Avoid the regressions of lastest xfstests release.
> 2) Give us more time to improve the "privatens" method.
> 
> And compare with revert that commit directly, this patch trys to
> give "privatens" method a chance to be enabled and tested (by
> export TRY_PRIVATENS=yes).

Everyone else: do things work better if you manually patch out the
run_privatens selection code so that run_setsid is always used?  The
setsid code itself is also new; before that fstests just used killall.

> Thanks,
> Zorro
> 
>  check | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/check b/check
> index ea92b0d62..33eb3e085 100755
> --- a/check
> +++ b/check
> @@ -674,10 +674,13 @@ _stash_test_status() {
>  	esac
>  }
>  
> -# Can we run in a private pid/mount namespace?
> -HAVE_PRIVATENS=
> -./tools/run_privatens bash -c "exit 77"
> -test $? -eq 77 && HAVE_PRIVATENS=yes
> +# Don't try "privatens" by default, it's experimental for now.
> +if [ "$TRY_PRIVATENS" = "yes" ];then
> +	# Can we run in a private pid/mount namespace?
> +	HAVE_PRIVATENS=
> +	./tools/run_privatens bash -c "exit 77"
> +	test $? -eq 77 && HAVE_PRIVATENS=yes
> +fi
>  # Can we run systemd scopes?
>  HAVE_SYSTEMD_SCOPES=
> @@ -692,15 +695,6 @@ function _adjust_oom_score() {
>  }
>  _adjust_oom_score -500
>  
> -warn_deprecated_sessionid()
> -{
> -	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
> -		echo "WARNING: Running fstests without private pid/mount namespace"
> -		echo "support is deprecated and will be removed in February 2026."
> -		WARNED_DEPRECATED_SESSIONID=1
> -	fi
> -}
> -
>  # ...and make the tests themselves somewhat more attractive to it, so that if
>  # the system runs out of memory it'll be the test that gets killed and not the
>  # test framework.  The test is run in a separate process without any of our
> @@ -900,8 +894,6 @@ function run_section()
>  	seqres="$check"
>  	_check_test_fs
>  
> -	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
> -

Removal of the deprecation should be a separate patch, for which I will
pre-offer a
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  	loop_status=()	# track rerun-on-failure state
>  	local tc_status ix
>  	local -a _list=( $list )
> -- 
> 2.47.1
> 
