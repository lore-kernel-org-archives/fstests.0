Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAF33A9E9
	for <fstests@vger.kernel.org>; Thu,  7 May 2026 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778183465; cv=none; b=jdDuLrIOb6Qwks8TGHsZ6ICKzkBz6KDrGq6Ohw1oWzSQ+2Al+0daSukfH5uJTtX/6GxrMXdrNGHSk65W5YysdhW2Hta8QbuWQg9Vk0PF/Mwi8fL3teQQ2RGQ8xH7xvzi8NgyUfxMQyer0wOTOtkAtXwWc3kbfXrUpo2CiAam/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778183465; c=relaxed/simple;
	bh=mKVaAoi78zdlXziPWkDWoexw3BCJpwHyxrNAWbIq2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMRGzjvgWIoFKghShGDWc5xBCUa+TxK/D5mbJ32PwyLp0a3maN2906vITf531EfqPDRXWZ1BTeiL8CWMxveM/DUpniwfTtWBNTHt/sGG+pnUeNOz8AKfH1443D3XF7cKJC4Q2FJz8xPa3kKA3dcvmy7+kI+cia6K2tAxl/JDAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIG8aTWt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIG8aTWt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AB4C2BCB2;
	Thu,  7 May 2026 19:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778183464;
	bh=mKVaAoi78zdlXziPWkDWoexw3BCJpwHyxrNAWbIq2so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIG8aTWtxayIrccKsexBvl8XSthxCoxLpU3IZ3zYwN59Ip3lRLY1YZpaRQ4SJj/nH
	 JSQyWnFzdDF4MyDKhrR5XZA7NaPTfHonamMrwkxIjoRcxgA/L510ibv5c2QFtl99Dj
	 A5O1D5adiQ0K++CK5Q8zfxq9NiyiEB0G/vZIaCag7veikAHBjv6BMC/GuXYIWli92b
	 5gtAaf8rE9cncsScXLXPrFKY6l3zjT2Hx5NPXYvWCEKFz/l5T2BfWtVLnOW36eSKg2
	 eN9xpDVb1ORp4JCLhk3Jgpj6yaGOMY6PLow5if4CBkmMHguQ678JsLqlNSD+rf/nNZ
	 Q9uENg/v6WRgw==
Date: Fri, 8 May 2026 03:50:58 +0800
From: Zorro Lang <zlang@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH RFC] check: add new option "--loop <n>" which runs each
 test multiple times
Message-ID: <afzmt7SFA4jWhi6U@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
References: <20260415213248.1795275-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415213248.1795275-1-tytso@mit.edu>

On Wed, Apr 15, 2026 at 05:32:48PM -0400, Theodore Ts'o wrote:
> Teach the check script a new option --loop, which re-run each test
> multiple times.  This works very similarly to to -L, which will retry
> a particular test after it first fails, except that the test is rerun
> unconditionally.
> 
> This differs from the "-i <n>" option, which iterates each set of
> tests <n> times instead of each test.  The -i option is problematic in
> two ways.  First, doesn't save the test artifacts from each test run.
> This is unfortunate because when the developer is trying to debug a
> flaky test failure, running "check -i 100" will run a test 100 times,
> but if only the 42nd test fails, the NNN.out.bad file for that failing
> test run is not preserved.  The second difference between --loop and
> -i is the result.xml file is rewritten after each test set, so we do
> not have the cumulative statistics of the 100 test runs in the junit
> XML file.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Hi Ted,

> 
> Note: This commit adds a new command-line option instead of changing the
> behavior of -i because it's possible that *someone* actually likes the
> current behavior of the -i option, and changing how -i works might
> break their test runner infrastructure.
> 
> Speaking personally, I find the current -i option completely useless
> for the needs of xfstests-bld, and I would be happy to just change how
> the -i option works.  This would also require changing support for -I,
> but I was planning on adding an --loop-while-successful option
> eventually, since it would be faster for bisection (although I
> normally don't care about the junit XML file for NNN.out.bad files
> when bisecting, so I find -I much less objectionable than -i).
> 
>  check | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/check b/check
> index cd7a79347..923d81a28 100755
> --- a/check
> +++ b/check
> @@ -27,6 +27,8 @@ DUMP_OUTPUT=false
>  iterations=1
>  istop=false
>  loop_on_fail=0
> +loop_always=0
> +loop_count=0
>  exclude_tests=()
>  
>  # This is a global variable used to pass test failure text to reporting gunk
> @@ -85,6 +87,7 @@ check options
>      -s section		run only specified section from config file
>      -S section		exclude the specified section from the config file
>      -L <n>		loop tests <n> times following a failure, measuring aggregate pass/fail metrics
> +    --loop=<n>		loop tests <n> times, measuring aggregate pass/fail metrics
>  
>  testlist options
>      -g group[,group...]	include tests from these groups
> @@ -339,6 +342,12 @@ while [ $# -gt 0 ]; do
>  	--extra-space=*) export SCRATCH_DEV_EMPTY_SPACE=${r#*=} ;;
>  	-L)	[[ $2 =~ ^[0-9]+$ ]] || usage
>  		loop_on_fail=$2; shift
> +		loop_count=$loop_on_fail
> +		;;
> +	--loop=*) loop_always=${1#*=}

"${1#*=}", we're doing it the hard way... I really hope to rewrite the whole
arguments processing part with getopt or any other good way.

> +		[[ $loop_always =~ ^[0-9]+$ ]] || usage
> +		loop_count=$(( loop_always - 1))

OK, if --loop=0, loop_count=-1, then the test will be run once. So looks like
--loop=<n> is "loop tests an *additional* <n> times", right?

> +		set +vx
        ^^^^^^^

It seems a debug ghost is still haunting the code :)

Others look good to me.

Thanks,
Zorro

>  		;;
>  
>  	-*)	usage ;;
> @@ -604,7 +613,7 @@ _expunge_test()
>  }
>  
>  # retain files which would be overwritten in subsequent reruns of the same test
> -_stash_fail_loop_files() {
> +_stash_loop_files() {
>  	local seq_prefix="${REPORT_DIR}/${1}"
>  	local cp_suffix="$2"
>  
> @@ -629,9 +638,9 @@ _stash_test_status() {
>  
>  	if ((${#loop_status[*]} > 0)); then
>  		# continuing or completing rerun-on-failure loop
> -		_stash_fail_loop_files "$test_seq" ".rerun${#loop_status[*]}"
> +		_stash_loop_files "$test_seq" ".rerun${#loop_status[*]}"
>  		loop_status+=("$test_status")
> -		if ((${#loop_status[*]} > loop_on_fail)); then
> +		if ((${#loop_status[*]} > loop_count)); then
>  			printf "%s aggregate results across %d runs: " \
>  				"$test_seq" "${#loop_status[*]}"
>  			awk "BEGIN {
> @@ -651,9 +660,9 @@ _stash_test_status() {
>  
>  	case "$test_status" in
>  	fail)
> -		if ((loop_on_fail > 0)); then
> +		if ((loop_on_fail > 0 || loop_always > 0 )); then
>  			# initial failure, start rerun-on-failure loop
> -			_stash_fail_loop_files "$test_seq" ".rerun0"
> +			_stash_loop_files "$test_seq" ".rerun0"
>  			loop_status+=("$test_status")
>  		fi
>  		bad+=("$test_seq")
> @@ -661,7 +670,14 @@ _stash_test_status() {
>  	list|notrun)
>  		notrun+=("$test_seq")
>  		;;
> -	pass|expunge)
> +	pass)
> +		if (( loop_always > 0 )); then
> +			# start rerun loop
> +			_stash_loop_files "$test_seq" ".rerun0"
> +			loop_status+=("$test_status")
> +		fi
> +	        ;;
> +	expunge)
>  		;;
>  	*)
>  		echo "Unexpected test $test_seq status: $test_status"
> -- 
> 2.51.0
> 
> 
