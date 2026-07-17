Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD4330301
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308646; cv=none; b=qZg1DBEVJ9Mp2xw8zhLvZB9+HF2X32actl5rUBLhuXsIlO9IRsO9q2VvomJry5JAuaBuaJs4qnrWlN1deYTONcSjOajjZeVUKDDJb0dnC8+XoyDdU49A3/TLDrbkHrwzkiOHffSETPeZ5sBiZJrIu4zwMDjZ1qfW6sVKrvqVhoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308646; c=relaxed/simple;
	bh=vjOicyjPgoNaWnQPOWcrYxGMfuIFYJbvap2xMjTvAM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auQHH/qcgcTAi8V675wtRlS7Ftyk+sH8mGv7M8d8cZhZfZoZ3YfG+d/rv1s/owmSRoC235beSlKgeOordP9wltKU6b1hnqUW85rFdBpDBCILxbYbUhXXi6S18yeEmG8qw4rzr/3PDri85g8rJeQzI5Nx2uNj1RuExEgcnxYMNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyYWpwy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyYWpwy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F01F000E9;
	Fri, 17 Jul 2026 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784308644;
	bh=qiQexxhhbOVcSlqeWuIaTGOMyeNrvPTA28GoRlL8amI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HyYWpwy5JvaWyC4DfeFs8Uct5P880hItZrBQdfRI8M3aAEF9HR8mzFngIfJVMcbE3
	 3TpCIKM493FWb7+8+dTkCr11/b26PNitG0ANXhSoh6zSzUZpMiEEIRppG15O/w6BvA
	 QutM4NKSintx0M58OaTNj6Fk4/4Og4lEnZQ4n1apupgpwUWx9iDXL/+2Q9NNm3nox8
	 isiC/qJVy9h0gfRyFYvxjVHV4UKtUdpvPV2VO8/i7hZdk8egQxhPG/jeHobU/Bifzd
	 bszsEYoUcXXJrzY7JCtgP8spZxagtmdSX8ASImFJcri3pyN6tLfa4g8651Z9bVd/Dz
	 PcOdr6zfTmEmQ==
Date: Sat, 18 Jul 2026 01:17:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] common: strip attr 2.6.0 --restore safety warnings
Message-ID: <alpihbK3XQn3I5vR@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	djwong@kernel.org, fstests@vger.kernel.org
References: <20260710234655.GC15202@frogsfrogsfrogs>
 <20260713135256.340261-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713135256.340261-1-avinesh.kumar@suse.com>

On Mon, Jul 13, 2026 at 03:52:56PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> attr 2.6.0 (CVE-2026-54371 hardening) makes "setfattr --restore" print a
> warning to stderr when neither -P nor -h is given, claiming it may
> traverse or dereference symlinks in the dump's pathnames [0]. This warning
> leaks into test output and breaks generic/062 and xfs/083 (via
> _scratch_populate).
> 
> Add a _setfattr_restore helper that runs "setfattr --restore", filters
> out just the expected warning line, and preserves any other (unexpected)
> stderr. Convert the callers in common/populate, common/overlay and
> generic/062 to use it.
> 
> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  common/overlay    | 2 +-
>  common/populate   | 4 ++--
>  common/rc         | 8 ++++++++
>  tests/generic/062 | 2 +-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index d32f3219..73841dd7 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -494,7 +494,7 @@ _overlay_trusted_to_user()
>  	local dir=$1
>  
>  	for file in `find $dir`; do
> -		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
> +		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | _setfattr_restore --restore=-
>  		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
>  			$SETFATTR_PROG -x $xattr $file;
>  		done
> diff --git a/common/populate b/common/populate
> index 1c0dd03e..f7fcd0c3 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -151,7 +151,7 @@ __populate_create_attr() {
>  		echo "# file: ${name}";
>  		seq --format "user.%08g=\"abcdefgh\"" 0 "${nr}"
>  		echo
> -	) | setfattr --restore -
> +	) | _setfattr_restore --restore=-
>  
>  	test -z "${missing}" && return
>  	seq 1 2 "${nr}" | while read d; do
> @@ -200,7 +200,7 @@ __populate_xfs_create_btree_attr() {
>  			seq --format "user.%08g=\"abcdefgh\"" "${nr}" "$((nr + incr + 1))"
>  			echo "user.v$(printf "%.08d" "$nr")=\"${bigval}\""
>  			echo
> -		) | setfattr --restore -
> +		) | _setfattr_restore --restore=-
>  	done
>  
>  	# ... and in the second loop we delete all the remote attrs to
> diff --git a/common/rc b/common/rc
> index 79189e7e..6234a580 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -132,6 +132,14 @@ _test_fsxattr_xflag()
>  	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>  }
>  
> +_setfattr_restore()
> +{
> +	$SETFATTR_PROG "$@" 2> $tmp.setfattr.$$

If the function name is _setfattr_restore (not _setfattr), I think it should run
`$SETFATTR_PROG --restore`, rather than a common $SETFATTR_PROG command.

Thanks,
Zorro

> +	local ret=$?
> +	cat $tmp.setfattr.$$ | sed -e '/--restore=.*unsafe.*without/d' 1>&2
> +	return $ret
> +}
> +
>  # This test requires extsize support on the  filesystem
>  _require_scratch_extsize()
>  {
> diff --git a/tests/generic/062 b/tests/generic/062
> index 89659040..3ef96da1 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -186,7 +186,7 @@ _create_test_bed
>  _extend_test_bed
>  
>  echo "*** restore everything"
> -setfattr -h --restore=$tmp.backup1
> +_setfattr_restore -h --restore=$tmp.backup1 2>&1 | _filter_scratch
>  _backup $tmp.backup2
>  
>  echo "AFTER RESTORE" >>$seqres.full
> -- 
> 2.54.0
> 
