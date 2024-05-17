Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643CA399
	for <fstests@vger.kernel.org>; Fri, 17 May 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960275; cv=none; b=L9bDJGTJtEbcRJ3+0Ze3NCrtadquEEzC7ovrrvhcHrgSaxuUbya3PdyxDQNXkhard8RhNCdTCQLtydoSfsh7ym9vdXNKf1zxTdFnSQx3hOYR1bPiDcsuoIHfi5yM3CZyB/sctckOizUyR9jrQNVoNeBgqQ8OMUivvSU1gfuV13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960275; c=relaxed/simple;
	bh=Df3RksSKuOwR3x9333GLgbZje0AHgBIM21+5fDLdyp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfL7EpPAwAHPx8gzFUUP+NslDvcaxrIxWdfpneWn6gmDi5rNc+qFK7wryz2l8r6NRA1aj+NB6NtW7p/96FN9pFDv8R8LIulLqAfj4PKdVWshRR9pxx6+so085cYIujNyvrOVWO6SHzwe7JgYHqeW6SNUSbH+mVRDBAPatdFWGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGDkqw8w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGDkqw8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8A8C2BD10;
	Fri, 17 May 2024 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715960274;
	bh=Df3RksSKuOwR3x9333GLgbZje0AHgBIM21+5fDLdyp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vGDkqw8w6YuXdQGzI+BR9ydqRw0uM3DIjg+KoDni5Zp7ozWaZ8TqXxRKhyzNIIv7N
	 b7Ye1oNjdkTkml5266eFKE3afAoE9pESgkc68I3WIfVKjWD2AvB3JOGWBmSCGV67YR
	 JktwvUnjH2xGC4DeYR4rw7on3hZyW7qrO00xqRIsYE0PRe5qFrrf2fVAiFrLNWIPzk
	 wzEh7NxEFqzkrJ7XqHUliCY37svAe2D3xK1ltQSQ77SKq5joziKuqwKJJoLOj0HxvG
	 may2+XIBRO1vUVfo8jhlMN6ox5+VF1n+4xnaeGGwJ5KOn72EO0tWSqkrvHqhz8NPol
	 ovGcLLY4mzP3A==
Date: Fri, 17 May 2024 08:37:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH 5/6] btrfs/011: mkfs the scratch dev before exiting
Message-ID: <20240517153754.GJ360908@frogsfrogsfrogs>
References: <cover.1715896529.git.dsterba@suse.com>
 <19804c4e3c319678768d5d24a15b000e05dd0af2.1715896529.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19804c4e3c319678768d5d24a15b000e05dd0af2.1715896529.git.dsterba@suse.com>

On Fri, May 17, 2024 at 12:12:50AM +0200, David Sterba wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> When testing encryption I started getting failures because the scratch
> dev didn't have a valid fs at the end of the test.  This is because for
> encryption we have to disable raid5/6, which changes how the test is
> run.
> 
> Normally with raid6 we end up cancelling the device replace, and thus
> $SCRATCH_DEV has a valid file system on it.  However with raid5/6
> disabled we end with a normal DUP profile, and the replace doesn't end
> up cancelled, so $SCRATCH_DEV is wiped.  Then when the test finishes we
> do the normal fsck and see that there's no fs on the $SCRATCH_DEV and
> error.
> 
> This test does all the fsck'ing during the workout period, so we don't
> need the final scratch check, simply re-make the $SCRATCH_DEV at the end
> as it could have been replaced during the test.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  tests/btrfs/011 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index bf63a72b11c42f..d99624fb941cce 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -258,6 +258,11 @@ for t in "-m single -d single:1 no 64" \
>  	fi
>  done
>  
> +# If we exclude certain RAID profiles we can end up where the scratch dev
> +# doesn't have a valid fs on it because it was replaced during workout, so mkfs
> +# the scratch device so we don't get _check_btrfs_filesystem errors
> +_scratch_mkfs > /dev/null 2>&1

/me wonders why the_require_scratch_nocheck at the top doesn't shut off
the post-test fsck?

--D

> +
>  echo "*** done"
>  status=0
>  exit
> -- 
> 2.45.0
> 
> 
