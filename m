Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1472AE84
	for <fstests@vger.kernel.org>; Fri, 21 Mar 2025 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571416; cv=none; b=cp04FnMabG9Jimobr+EfP2iYdcFORHW0eb/rGyTtUyff10tsu8Q3S5gLHgCcya/OOnpyLIzvI5EVXgfiuqntxaazYiS9pEKdnEdhp2eX1USV+CTCCV969DCEPKN3o6fKm6x+LDEc18ufBUKdnnmQDezmENOBq7x7sZeTsDDCtvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571416; c=relaxed/simple;
	bh=Vbs4UFmaY1ENdhPZugNOs/8syJ4xwXtOh8pO7YmpFDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCPjtxerhvb+JXEsz1hhbSLL5Ymc9mydrLrNOziA8QEAL5eCTwh6K83lgxwovOSdeg3jQxqvQLZCsn0OCanT7rqnEOtPCQecuAU2cJQp48cLpODuRI7lO5OYoaO1/iPh0Eo6eCKjCLJc8G+WwmfXSALMQG5aKY6nj0t6XVM7Q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj/5kG7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj/5kG7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7ADC4CEE3;
	Fri, 21 Mar 2025 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742571415;
	bh=Vbs4UFmaY1ENdhPZugNOs/8syJ4xwXtOh8pO7YmpFDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bj/5kG7D6RshiNvLKmFshFU8JTh7o5vvxhnlmXyRuZZLtUPtxMtVuGg0yjYqo1tdF
	 A3qilSwPyDqMETsRH5HqYlQ7uf97AOdsx3fQonPsg70zFlRb/hYiUCCTXVGsM5+IVK
	 +S2YAKrKlDbGqwLpwhVwjIpBBpD4EUVkjTEGiJ4G3nHVolX7AtQsmlpF4EgBbCviwg
	 D85G7UxClOz7DM1Py7FtciqLCccY4Lx4It/v2UKm71oeLx4/9l4QoIML1xzz8BfBEu
	 z7p0jl0XOBY06Jh345ZB0hsc07yBPIaiT3i7aMqER4rH0Tkts3lnb3nz1gS5JvZgm9
	 4tgpOAyEm8FDw==
Date: Fri, 21 Mar 2025 08:36:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] fstests: remove run_setsid test way from check
Message-ID: <20250321153655.GD4001511@frogsfrogsfrogs>
References: <20250320192812.782380-1-zlang@kernel.org>
 <20250320192812.782380-3-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320192812.782380-3-zlang@kernel.org>

On Fri, Mar 21, 2025 at 03:28:12AM +0800, Zorro Lang wrote:
> This patch partially revert most of the 88d60f434 ("common: fix pkill
> by running test program in a separate session"), it does:
> 1. Remove run_setsid script
> 2. Remove all run_setsid related things from check
> 3. Keep the change in _scratch_xfs_stress_scrub_cleanup() which is a
>    bug fix for xfs_scrub test.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

This looks like a reasonable revert to me and it doesn't seem to break
anything so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  check            | 39 ++++++---------------------------------
>  common/rc        |  4 ++--
>  tools/Makefile   |  1 -
>  tools/run_setsid | 22 ----------------------
>  4 files changed, 8 insertions(+), 58 deletions(-)
>  delete mode 100755 tools/run_setsid
> 
> diff --git a/check b/check
> index ba853ae85..32890470a 100755
> --- a/check
> +++ b/check
> @@ -698,46 +698,19 @@ _adjust_oom_score -500
>  # systemd doesn't automatically remove transient scopes that fail to terminate
>  # when systemd tells them to terminate (e.g. programs stuck in D state when
>  # systemd sends SIGKILL), so we use reset-failed to tear down the scope.
> -#
> -# Use setsid to run the test program with a separate session id so that we
> -# can pkill only the processes started by this test.
>  _run_seq() {
> +	local cmd=(bash -c "test -w ${OOM_SCORE_ADJ} && echo 250 > ${OOM_SCORE_ADJ}; exec ./$seq")
>  	local res
> -	unset CHILDPID
> -	unset FSTESTS_ISOL	# set by tools/run_seq_*
>  
>  	if [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
>  		local unit="$(systemd-escape "fs$seq").scope"
>  		systemctl reset-failed "${unit}" &> /dev/null
> -		systemd-run --quiet --unit "${unit}" --scope \
> -			./tools/run_setsid "./$seq" &
> -		CHILDPID=$!
> -		wait
> +		systemd-run --quiet --unit "${unit}" --scope "${cmd[@]}"
>  		res=$?
> -		unset CHILDPID
>  		systemctl stop "${unit}" &> /dev/null
> +		return "${res}"
>  	else
> -		# bash won't run the SIGINT trap handler while there are
> -		# foreground children in a separate session, so we must run
> -		# the test in the background and wait for it.
> -		./tools/run_setsid "./$seq" &
> -		CHILDPID=$!
> -		wait
> -		res=$?
> -		unset CHILDPID
> -	fi
> -
> -	return $res
> -}
> -
> -_kill_seq() {
> -	if [ -n "$CHILDPID" ]; then
> -		# SIGPIPE will kill all the children (including fsstress)
> -		# without bash logging fatal signal termination messages to the
> -		# console
> -		pkill -PIPE --session "$CHILDPID"
> -		wait
> -		unset CHILDPID
> +		"${cmd[@]}"
>  	fi
>  }
>  
> @@ -746,9 +719,9 @@ _prepare_test_list
>  fstests_start_time="$(date +"%F %T")"
>  
>  if $OPTIONS_HAVE_SECTIONS; then
> -	trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
> +	trap "_summary; exit \$status" 0 1 2 3 15
>  else
> -	trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
> +	trap "_wrapup; exit \$status" 0 1 2 3 15
>  fi
>  
>  function run_section()
> diff --git a/common/rc b/common/rc
> index 55c384a63..fa0f02ac4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -33,7 +33,7 @@ _test_sync()
>  # Kill only the processes started by this test.
>  _pkill()
>  {
> -	pkill --session 0 "$@"
> +	pkill "$@"
>  }
>  
>  # Find only the test processes started by this test
> @@ -2792,7 +2792,7 @@ _require_user_exists()
>  # not, passing $SHELL in this manner works both for "su" and "su -c cmd".
>  _su()
>  {
> -	su --session-command $SHELL "$@"
> +	su "$@"
>  }
>  
>  # check if a user exists and is able to execute commands.
> diff --git a/tools/Makefile b/tools/Makefile
> index 2d502884f..af7adc2a6 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -7,7 +7,6 @@ include $(TOPDIR)/include/builddefs
>  
>  TOOLS_DIR = tools
>  helpers=\
> -	run_setsid \
>  	run_privatens
>  
>  include $(BUILDRULES)
> diff --git a/tools/run_setsid b/tools/run_setsid
> deleted file mode 100755
> index 5938f80e6..000000000
> --- a/tools/run_setsid
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -#!/bin/bash
> -
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2025 Oracle.  All Rights Reserved.
> -#
> -# Try starting things in a new process session so that test processes have
> -# something with which to filter only their own subprocesses.
> -
> -if [ -n "${FSTESTS_ISOL}" ]; then
> -	# Allow the test to become a target of the oom killer
> -	oom_knob="/proc/self/oom_score_adj"
> -	test -w "${oom_knob}" && echo 250 > "${oom_knob}"
> -
> -	exec "$@"
> -fi
> -
> -if [ -z "$1" ] || [ "$1" = "--help" ]; then
> -	echo "Usage: $0 command [args...]"
> -	exit 1
> -fi
> -
> -FSTESTS_ISOL=setsid exec setsid "$0" "$@"
> -- 
> 2.47.1
> 
> 
