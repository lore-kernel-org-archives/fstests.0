Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529E44AB68
	for <fstests@vger.kernel.org>; Tue, 21 Jul 2026 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669215; cv=none; b=tnWUxo7sOZmHRu8j705aYUS7HxpRRYVjWO0uSEGS6tWXDc5k/T7pfx9wU/0xhyS+EgnEEx9cyxDf7xCx8g5t3Cn13rn51BCyH/ksvxXGBLlUr26vtfkNTLfZmKp3XyA9UgpyU9mcoyFzkR92jZzl3qwGo9V9SHJR9zX+U6HIorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669215; c=relaxed/simple;
	bh=RbcB7ZwaTdeo4CJni6eRWyjZZfD4iVx7gxlbF4rwxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbqhTRPvDoYmoT29JBB8ka2DP9DrKcMgNfk138/Dm07oYvWriQWbAe0zhz7+EuIESk/ktWx4bfLt+KbighUr+q8ZomPtQS4aOj9/OSuG9bP8aC7PwIpjl8MFeoERVHBdOioWt4tqCPeFkM6xFyV4ZLTMWRqF7ku3o2LONCxcDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiciD4TE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiciD4TE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C6B1F000E9;
	Tue, 21 Jul 2026 21:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784669213;
	bh=iFux/YDJi3KtkxYH86tRlnkhgldkcVKY+8kVRymBpxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IiciD4TEd0jHucpSFtKLZGvJ+Yv4wzQK366wZFx2fDGeG0XzWo2W+AoNgtVlk6r72
	 hEZBRANzjxfxE1G32spK4xCO3PuGeFqy2HuY9dFQnBXIi+kDNegVx/c5378Tf3yLsF
	 ZUSnvGJ+N5Rm2VSFyeHDoY5MXoNWsrP67IB3rDG41MY+tcMIdguZQej+/cM6w4ymxf
	 ih/PqyfIQwUhrmrT0AzkuL/hiaqJSJge05Eg6aOSAIOIKMcqcjFTOwh7hDBZAiKJYs
	 lPu2SLAuI+ujcoPtkALPDW75z/Iu6vWBkHG+B05JsCG6MnWNH7JokhzXRetQ8BZSMK
	 MtNejm7a0M4tw==
Date: Wed, 22 Jul 2026 05:26:49 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3] common: strip attr 2.6.0 --restore safety warnings
Message-ID: <al_jUSscUbp9HGVv@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	fstests@vger.kernel.org
References: <alpihbK3XQn3I5vR@zlang-mailbox>
 <20260721102059.93453-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721102059.93453-1-avinesh.kumar@suse.com>

On Tue, Jul 21, 2026 at 12:20:59PM +0200, Avinesh Kumar wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> attr 2.6.0 (CVE-2026-54371 hardening) makes "setfattr --restore" print a
> warning to stderr when options -P and -h are not given, claiming it may
> traverse or dereference symlinks in the dump's pathnames [0]. This warning
> leaks into test output and breaks generic/062 and xfs/083 (via
> _scratch_populate).
> 
> Add a _setfattr_restore helper that takes the restore source as its first
> argument, filters out just the expected warning line, and preserves any
> other (unexpected) stderr. Convert the callers in common/populate,
> common/overlay and generic/062 to use it.
> 
> [0] https://cgit.git.savannah.nongnu.org/cgit/attr.git/commit/?id=3fb06b9ba314d37035d0877e6de313de754f1ac8
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---

This patch looks good to me, but I've just merged your patch:

  [PATCH v2] generic/062: filter setfattr --restore symlink-safety warning

as a preliminary fix for g/062. So could you please rebase this patch onto
the latest for-next branch, then send again? Thanks a lot!


>  common/overlay    |  2 +-
>  common/populate   |  4 ++--
>  common/rc         | 15 +++++++++++++++
>  tests/generic/062 |  2 +-
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index d32f3219..8e89d6e4 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -494,7 +494,7 @@ _overlay_trusted_to_user()
>  	local dir=$1
>  
>  	for file in `find $dir`; do
> -		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | $SETFATTR_PROG --restore=-
> +		_getfattr --absolute-names -d -m '^trusted.overlay.(redirect|metacopy)$' $file  | sed 's/^trusted/user/' | _setfattr_restore -
>  		for xattr in `_getfattr --absolute-names -d -m '^trusted.overlay.' $file  | tail -n +2 | cut -d= -f1`; do
>  			$SETFATTR_PROG -x $xattr $file;
>  		done
> diff --git a/common/populate b/common/populate
> index 1c0dd03e..f3672c1a 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -151,7 +151,7 @@ __populate_create_attr() {
>  		echo "# file: ${name}";
>  		seq --format "user.%08g=\"abcdefgh\"" 0 "${nr}"
>  		echo
> -	) | setfattr --restore -
> +	) | _setfattr_restore -
>  
>  	test -z "${missing}" && return
>  	seq 1 2 "${nr}" | while read d; do
> @@ -200,7 +200,7 @@ __populate_xfs_create_btree_attr() {
>  			seq --format "user.%08g=\"abcdefgh\"" "${nr}" "$((nr + incr + 1))"
>  			echo "user.v$(printf "%.08d" "$nr")=\"${bigval}\""
>  			echo
> -		) | setfattr --restore -
> +		) | _setfattr_restore -
>  	done
>  
>  	# ... and in the second loop we delete all the remote attrs to
> diff --git a/common/rc b/common/rc
> index 79189e7e..38b77bef 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -132,6 +132,21 @@ _test_fsxattr_xflag()
>  	grep -q "fsxattr.xflags.*\[.*$2.*\]" <($XFS_IO_PROG -c "stat -v" "$1")
>  }
>  
> +# Restore xattrs from a getfattr-style dump given as $1 (a dump file, or "-"
> +# for stdin); any extra setfattr options follow.  attr 2.6.0 (CVE-2026-54371)
> +# makes --restore warn unless both -P and -h are given, so filter out just
> +# those warning lines, keep other unexpected stderr.
> +_setfattr_restore()
> +{
> +	local restore_from="$1"
> +	shift
> +
> +	$SETFATTR_PROG "$@" --restore="$restore_from" 2> $tmp.setfattr
> +	local ret=$?
> +	sed -e '/--restore=.*unsafe.*without/d' "$tmp.setfattr" 1>&2
> +	return $ret
> +}
> +
>  # This test requires extsize support on the  filesystem
>  _require_scratch_extsize()
>  {
> diff --git a/tests/generic/062 b/tests/generic/062
> index 89659040..845d62f2 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -186,7 +186,7 @@ _create_test_bed
>  _extend_test_bed
>  
>  echo "*** restore everything"
> -setfattr -h --restore=$tmp.backup1
> +_setfattr_restore "$tmp.backup1" -h 2>&1 | _filter_scratch
>  _backup $tmp.backup2
>  
>  echo "AFTER RESTORE" >>$seqres.full
> -- 
> 2.55.0
> 
