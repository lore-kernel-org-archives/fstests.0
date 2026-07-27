Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D93399372
	for <fstests@vger.kernel.org>; Mon, 27 Jul 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183522; cv=none; b=II8JoT0TqRBbGDVVPjUlRbfhTSkibfq1wX9PZEGhxdncEzKE+d1RIGvlgLNWfgdQI96OtX6bMscbwQqdPJez2UT9ePNvxUl1Phx0eeS5/nKuu4lLKJGmHzJPfaJ2RXQXSkdTzcP5kKvwAXpvnxIpaz7UdRkeTJ469B6AupkhXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183522; c=relaxed/simple;
	bh=M7UfQke8OIszKs2gDywIWkG65ons/vaa9MjLCVVVs4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4twGllxok/vTJ7VPNHNYPEHGjLxjHQKgaZGkA7vSIZ0af9rFYtihhfW7DLW3Qmom++foscKhszEQjWA9Vkpil/TdgcojhKmfFpEeYuqpdHsysoecfGAreYAagHDESnUPZG3+04QHh+2FNmuKPgeHn/CrBtIStdR0+9PpFirglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAMWnqm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAMWnqm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D7B1F00A3A;
	Mon, 27 Jul 2026 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183519;
	bh=a7QyN5Xo15f9l6EBUEbSlYlmdAlpYjeWYnyYD+aPIE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QAMWnqm45G5ZCIzppMuI/vHZMlVFBW4ac+jlhWwczjHf9ds9lmtmnWClT9ilZe9oy
	 PYKxQC+SfB/L95VOpCkd7abQDDlEzjLXYICCgCTmLifpoGC1FowqUztfjVsSIK01FJ
	 SD51RcKdr/JoCjqj4gXZEH3fo9TN5dQdzClOsUWwnpSj7eIVsQoWUfQjFmnCcW/HQ7
	 ne7VsKnHNxcibBqt/PcX+PEa5ZGiyzROQFX7eB0XyAHtpKuMjl8aXsFRaFmreKANJt
	 +JZuqmoeAgo6nHlZOl1fUb8ssmTmi9EOTU4Cj0N6Zv9GgIb/FHh+OQIe+hizZACx5j
	 24YuWep8bl7hA==
Date: Tue, 28 Jul 2026 04:18:34 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4] common: strip attr 2.6.0 --restore safety warnings
Message-ID: <ame8dTuRy-A_NjGV@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
References: <al_jUSscUbp9HGVv@zlang-mailbox>
 <20260722092020.202100-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722092020.202100-1-avinesh.kumar@suse.com>

On Wed, Jul 22, 2026 at 11:20:20AM +0200, Avinesh Kumar wrote:
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
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  common/overlay    |  2 +-
>  common/populate   |  4 ++--
>  common/rc         | 15 +++++++++++++++
>  tests/generic/062 |  9 ++-------
>  4 files changed, 20 insertions(+), 10 deletions(-)
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
> index 106f044a..f5673113 100644
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

How about:

  $SETFATTR_PROG "$@" --restore="$restore_from" 2>&1 | \
      sed -e '/--restore=.*unsafe.*without/d'
  return ${PIPESTATUS[0]}

Thanks,
Zorro

> +}
> +
>  # This test requires extsize support on the  filesystem
>  _require_scratch_extsize()
>  {
> diff --git a/tests/generic/062 b/tests/generic/062
> index ddf0a478..845d62f2 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -30,12 +30,7 @@ getfattr()
>  
>  setfattr()
>  {
> -    # attr >= 2.6.0 (CVE-2026-54371 fix) warns that "setfattr --restore" without
> -    # -P/--physical is unsafe because it can traverse symlinks. Older attr does
> -    # not accept -P, so just filter the warning to stay version-agnostic.
> -    $SETFATTR_PROG $@ 2>&1 | \
> -        sed -e '/^Warning: option --restore=file is unsafe without option/d' | \
> -        _filter_scratch
> +    $SETFATTR_PROG $@ 2>&1 | _filter_scratch
>  }
>  
>  _create_test_bed()
> @@ -191,7 +186,7 @@ _create_test_bed
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
