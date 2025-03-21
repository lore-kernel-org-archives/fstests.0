Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7C189906
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571354; cv=none; b=NUi2RAlQ5BqaeMs2+DdzR7U7YFBaztBwjMBSiNorcbjOXljOQvBISYsVsz7TMMstZaDzmCZcuZrNXrGEh9elLmP1kQ/MDcI9jdwUo6+tVrCg9Bgdzv2gFiZIkR/8hmxTP59M565Gjc2WCi8PXlR9BdkTLVOW5DzYcZNA6Ftah9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571354; c=relaxed/simple;
	bh=FouT0cITszImWWv0i0J/HopshyMgGaYYo7faWUCYsyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UejUJ4+Ws5OFTdhkMYw57oecnYmg2WNz/O3VQbt9FJGu6WoRopvxLibUl83TpFnFU33uaOydwg6nYhiWmOInra4uU+zAvaQpD3YO+EBKGr/lT8Ja5e/fp6g/zbIK4TaccRo8Wli8lNQDynLTWUWrRWw2ny7OvFCfjz3KgovZ5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjbrohtU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjbrohtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9592C4CEE3;
	Fri, 21 Mar 2025 15:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742571353;
	bh=FouT0cITszImWWv0i0J/HopshyMgGaYYo7faWUCYsyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QjbrohtUZa1X5GmsIZThSbY0wyes6tltsjChjmEIdpEyR4uzbzaDQLFZDuLbfcbyR
	 +9BalH5And32wYzpkLhD/vgd8TVVXDbFBJbPZJwwQgAgSvoqhmWRHPUhTw/ag1TYTM
	 xyJ1eSoA7XzYY9OG2Um0VwUu3fJ5CkUnMjbxbQ8zXbxJD2s05yugWKm6l/lzdsJlFE
	 RE2cCfxOUOqGfszbEvhVXN/mLuJpaPji3G2flcJH8MDDKD4fs6wn/hJEW2mNIHUD5c
	 lMq5BLolkF4JWAWNgNOfnzE+y7TFqwseZAzWrGtfJJApZ503aS+rVVburv1OVMfCu0
	 AraZlBCO7ZMiA==
Date: Fri, 21 Mar 2025 08:35:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] fstests: remove privatens test way from check
Message-ID: <20250321153553.GC4001511@frogsfrogsfrogs>
References: <20250320192812.782380-1-zlang@kernel.org>
 <20250320192812.782380-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320192812.782380-2-zlang@kernel.org>

On Fri, Mar 21, 2025 at 03:28:11AM +0800, Zorro Lang wrote:
> This patch totally revert:
>   ce7f796ad check: remove the deprecation of sessionid
>   336784e3d check: disable HAVE_PRIVATENS by default
>   949bdf8ea check: deprecate using process sessions to isolate test instances
> and partially revert:
>   247ab01fa check: run tests in a private pid/mount namespace
> 
> So it does:
> 1. Remove "run_privatens" related things from xfstests/check, due to
>    check doesn't need that test way.
> 2. Keep run_privatens script and related changes for check-parallel.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Seems to run fine here, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  check     | 37 +++++++++++--------------------------
>  common/rc | 12 ++----------
>  2 files changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/check b/check
> index 33eb3e085..ba853ae85 100755
> --- a/check
> +++ b/check
> @@ -674,14 +674,6 @@ _stash_test_status() {
>  	esac
>  }
>  
> -# Don't try "privatens" by default, it's experimental for now.
> -if [ "$TRY_PRIVATENS" = "yes" ];then
> -	# Can we run in a private pid/mount namespace?
> -	HAVE_PRIVATENS=
> -	./tools/run_privatens bash -c "exit 77"
> -	test $? -eq 77 && HAVE_PRIVATENS=yes
> -fi
> -
>  # Can we run systemd scopes?
>  HAVE_SYSTEMD_SCOPES=
>  systemctl reset-failed "fstests-check" &>/dev/null
> @@ -699,29 +691,22 @@ _adjust_oom_score -500
>  # the system runs out of memory it'll be the test that gets killed and not the
>  # test framework.  The test is run in a separate process without any of our
>  # functions, so we open-code adjusting the OOM score.
> +#
> +# If systemd is available, run the entire test script in a scope so that we can
> +# kill all subprocesses of the test if it fails to clean up after itself.  This
> +# is essential for ensuring that the post-test unmount succeeds.  Note that
> +# systemd doesn't automatically remove transient scopes that fail to terminate
> +# when systemd tells them to terminate (e.g. programs stuck in D state when
> +# systemd sends SIGKILL), so we use reset-failed to tear down the scope.
> +#
> +# Use setsid to run the test program with a separate session id so that we
> +# can pkill only the processes started by this test.
>  _run_seq() {
>  	local res
>  	unset CHILDPID
>  	unset FSTESTS_ISOL	# set by tools/run_seq_*
>  
> -	if [ -n "${HAVE_PRIVATENS}" ]; then
> -		# If pid and mount namespaces are available, run the whole test
> -		# inside them so that the test cannot access any process or
> -		# /tmp contents that it does not itself create.  The ./$seq
> -		# process is considered the "init" process of the pid
> -		# namespace, so all subprocesses will be sent SIGKILL when it
> -		# terminates.
> -		./tools/run_privatens "./$seq"
> -		res=$?
> -	elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> -		# If systemd is available, run the entire test script in a
> -		# scope so that we can kill all subprocesses of the test if it
> -		# fails to clean up after itself.  This is essential for
> -		# ensuring that the post-test unmount succeeds.  Note that
> -		# systemd doesn't automatically remove transient scopes that
> -		# fail to terminate when systemd tells them to terminate (e.g.
> -		# programs stuck in D state when systemd sends SIGKILL), so we
> -		# use reset-failed to tear down the scope.
> +	if [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
>  		local unit="$(systemd-escape "fs$seq").scope"
>  		systemctl reset-failed "${unit}" &> /dev/null
>  		systemd-run --quiet --unit "${unit}" --scope \
> diff --git a/common/rc b/common/rc
> index e51686389..55c384a63 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -33,11 +33,7 @@ _test_sync()
>  # Kill only the processes started by this test.
>  _pkill()
>  {
> -	if [ "$FSTESTS_ISOL" = "setsid" ]; then
> -		pkill --session 0 "$@"
> -	else
> -		pkill "$@"
> -	fi
> +	pkill --session 0 "$@"
>  }
>  
>  # Find only the test processes started by this test
> @@ -2796,11 +2792,7 @@ _require_user_exists()
>  # not, passing $SHELL in this manner works both for "su" and "su -c cmd".
>  _su()
>  {
> -	if [ "$FSTESTS_ISOL" = "setsid" ]; then
> -		su --session-command $SHELL "$@"
> -	else
> -		su "$@"
> -	fi
> +	su --session-command $SHELL "$@"
>  }
>  
>  # check if a user exists and is able to execute commands.
> -- 
> 2.47.1
> 
> 
