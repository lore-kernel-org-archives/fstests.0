Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E951C6FF5
	for <fstests@vger.kernel.org>; Fri, 18 Sep 2026 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723283; cv=none; b=t7jBtWUV0dPLICEeTb+0l+7hsJADA5yh26M8glnKKhcGK1SHGMVa8/x/BFT7u1lI9DaUDtckiKPPPS2i+CuBFCokxTgMN5HCSrM2aIhhXRfH86cOuyQ039cT0hHfD5kEPi4swGEHRITLmD+mFAVlIpvPfv4fa8xykDEC0Ys2hh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723283; c=relaxed/simple;
	bh=yfaSRDCzwohoEAOCCzf0mBY4CnJOKPv8GP64MOpQ55s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkrQelXvCHejIcOBXqLAsJIvgpy7d/dLK15591yCIHUUNeAXdN9djBBcAJpxMFIOdzQYpygSb2uyuiej2KQdKy43VngSIzgVQDv6f1XF6SwQk/JlY07GdgN6rBv5YKf+1WO37emcAeNsyRMisneh85ScvkeqKqb3FWLnhn1tXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j12mXp2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j12mXp2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F0C1F00893;
	Fri, 18 Sep 2026 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789723282;
	bh=tESYSpGxXKFgJx1+EjXEKFd5m629FnsIG6Hmd2arof8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j12mXp2pNX6dt8gWVslZLbuKf0mTqPi5B+qfDVcwElF021b64nnR9XbnF0lWPoogP
	 JX2fV1I5n1UvCOVa5QzusAU9vsUZsVPGhsGTIP56SO+hw40gvKU4B5mKOyUP45IvK4
	 LZ7dMih9Z0rgqRge7bW9t+x1Om3MiEPFRruzdn7sI241jLB9WMhK1lituNC1ATgqn+
	 bYRszZllN7CF/+ORBREfcTVv//GHIMpxSjP5Vp067gSFgh4LfBk8nw+pX8VMhzxjS3
	 0ZyGlHA8IrjhsgXrlcpOtKal/ltfz7R/7B7/NFCb9CqM1kTcwTWK7r2CAoNOR+ed8K
	 wLokC8XYJ7gwQ==
Date: Fri, 18 Sep 2026 17:21:17 +0800
From: Zorro Lang <zlang@kernel.org>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: djwong@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v5] common: strip attr 2.6.0 --restore safety warnings
Message-ID: <aq0ATjl5RxNEWJ7P@zlang-mailbox>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>, 
	djwong@kernel.org, fstests@vger.kernel.org
References: <ame8dTuRy-A_NjGV@zlang-mailbox>
 <20260914100834.117301-1-avinesh.kumar@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914100834.117301-1-avinesh.kumar@suse.com>

On Mon, Sep 14, 2026 at 12:08:34PM +0200, Avinesh Kumar wrote:
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

Thanks for this updating, this version is good to me now.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  common/overlay    |  2 +-
>  common/populate   |  4 ++--
>  common/rc         | 14 ++++++++++++++
>  tests/generic/062 |  9 ++-------
>  4 files changed, 19 insertions(+), 10 deletions(-)
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
> index 8add0eed..ccbc02b8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -132,6 +132,20 @@ _test_fsxattr_xflag()
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
> +	$SETFATTR_PROG "$@" --restore="$restore_from" 2>&1 | \
> +		sed -e '/--restore=.*unsafe.*without/d'
> +	return ${PIPESTATUS[0]}
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
