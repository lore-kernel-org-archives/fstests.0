Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB527466
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652299; cv=none; b=cMhnX13pE99vCXgBj0CDivrp5DBPQeh6rUNiqDWZVEPWyUPsu+f92v0wKeErV56EYqLKi+MLZ5nvrCt3dNXVVjWUsc3IxGZzcKdKURv6I98Z+1R6kvQuPmMfvJE/C2JZJnPODYSErCQPOkN2GYD/OhFvXFJebAqcLPHqySqRkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652299; c=relaxed/simple;
	bh=sdyhR/c37YyoFAEyNG4mGNHZ9PVW+D9oE7T1pnwh2OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4XtNfHeaiH9qDj4LwHRPK49EessLuShniIJcIUC4UID8dTjq0yg3qIaFKEJwpP/E4Sb2Ft+yN7FNf5ARj7KSQnCumFE4bDLvSJp3yUATtLTpSGh5HcFnRPX2cJ+uLDpexU+YTXA/ICh9WNCTGnu2Hyn/inz30FNGalORsS7Utc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iv3J/WEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iv3J/WEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D39C4CEE3;
	Wed, 11 Jun 2025 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652299;
	bh=sdyhR/c37YyoFAEyNG4mGNHZ9PVW+D9oE7T1pnwh2OA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iv3J/WExoh1wlMiOuCJbwpaoVlq3iXYIzyrZNsw+2/fFSL3rm+NwttTkw2UtYSsfE
	 v8Hg8jlxiLtRQwT52zHBoQmJFcllK8tS8zkl+UOf2czCcdurTP/xGRCG0EN1CajsJz
	 UM9dQ4y06wdom+iFKX9oRt/SIqHndisooqlwgsXsHP8TFZcdrVCHByRjFodesZsu+p
	 h7qpEvZu//VYGnpOhg6USRgzGWBO6T8Gra7a24KwdR73AfoIbNM97VEGT8odLHhx+h
	 T5dpMCCGX/N6Ib38+qs0Z8Zt+bpNANuaQXpGct1h/1FUhlt2jAsEnVO4Z2lTiPXA42
	 rHJfTe7mJosWg==
Date: Wed, 11 Jun 2025 07:31:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 02/12] common/rc: Add a helper to run fsx on a given file
Message-ID: <20250611143138.GG6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <0a0604215a992f0aaa4d8d6821b8c8051a0f8d80.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0604215a992f0aaa4d8d6821b8c8051a0f8d80.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:45PM +0530, Ojaswin Mujoo wrote:
> Currently run_fsx is hardcoded to run on a file in $TEST_DIR.
> Add a helper _run_fsx_on_file so that we can run fsx on any
> given file including in $SCRATCH_MNT. Also, refactor _run_fsx
> to use this helper.
> 
> No functional change is intended in this patch.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index cfbe2a5f..a5d811a1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5115,13 +5115,22 @@ _require_hugepage_fsx()
>  		_notrun "fsx binary does not support MADV_COLLAPSE"
>  }
>  
> -_run_fsx()
> +_run_fsx_on_file()
>  {
> +	local testfile=$1
> +	shift
> +
> +	if ! [ -f $testfile ]
> +	then
> +		echo "_run_fsx_on_file: $testfile doesn't exist. Creating" >> $seqres.full
> +		touch $testfile
> +	fi
> +
>  	echo "fsx $*"
>  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> -	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
> +	set -- $FSX_PROG $args $FSX_AVOID $testfile

	local testfile="${1:-$TEST_DIR/junk}"
	...
	set -- $FSX_PROG $args $FSX_AVOID $testfile

Then you don't need the extra helper.

--D

>  	echo "$@" >>$seqres.full
> -	rm -f $TEST_DIR/junk
> +	rm -f $testfile
>  	"$@" 2>&1 | tee -a $seqres.full >$tmp.fsx
>  	local res=${PIPESTATUS[0]}
>  	if [ $res -ne 0 ]; then
> @@ -5133,6 +5142,12 @@ _run_fsx()
>  	return 0
>  }
>  
> +_run_fsx()
> +{
> +	_run_fsx_on_file $TEST_DIR/junk $@
> +	return $?
> +}
> +
>  # Run fsx with -h(ugepage buffers).  If we can't set up a hugepage then skip
>  # the test, but if any other error occurs then exit the test.
>  _run_hugepage_fsx() {
> -- 
> 2.49.0
> 
> 
