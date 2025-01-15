Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E25E157485
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 06:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736922558; cv=none; b=YSEN+evYzKwyY6d1gjT7pU9hejyVeTlxiwD9Ogcu/g8va8wLSb4htaFvM/wsY2aieP88m6Fqh0e+LUVpmL25sx+lJwVb7WOoZRemwH4hMcDWMIlBGF6mCX/GMoSY+pKZrRF05kd0yvAHY6mvk2EXveWFHq60gkuAMm70bmrvI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736922558; c=relaxed/simple;
	bh=Ymekv8bGk+qcl2otHcodo4JS1Hz+J25qap6KQREcxoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7urWA4yf/bmkf59Wj38FU6HDSiLbfp2jenvjHA1yXreRtyrwJVWszzmoDVdQEUVLL1xw4M9NUJ+k5me1RmH66Jcz6rzKtXznsLj0TsFW04nnjdSEmmMmyo7b+NllN4xeQsP8qAuPswfoJ4TCyymU/fkrERMi1idazxh5FO7VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYIv1jDL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYIv1jDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F70C4CEDF;
	Wed, 15 Jan 2025 06:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736922556;
	bh=Ymekv8bGk+qcl2otHcodo4JS1Hz+J25qap6KQREcxoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WYIv1jDLr4poIrhpeLj78zVgpOW5KmjzD/V/Z/o6SwOysp5BGytC2eGYwpNhdfOls
	 iQ/SxKUXBk8DEbaZC5Vc0aElGGlIKkXgADkHOd19v1Tshd/oQQEFRlTIBHJ7iqYulM
	 mYFKDTyswBy4NjD6tcSWZefECL+oVH8iZQdNmuU1BnzuhgByUTH7sjtOYExhppQWzq
	 P4ov+ZAXw3OdCYLMJsG/QLIO7nzj7esYy+S6Lw8SrrwSLOZ7of6oezdLmnTtyWqcs8
	 hNUR8mA+kmETylaeosSy9GkJ1oUj7zBLWwBdc+IB+PMX/ao16OZBFNt/KC63aVnQTv
	 1nwjI3dXowvlw==
Date: Tue, 14 Jan 2025 22:29:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/5]: CLI and feature improvements for check-parallel
Message-ID: <20250115062916.GC3557695@frogsfrogsfrogs>
References: <20250115060258.3951185-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115060258.3951185-1-david@fromorbit.com>

On Wed, Jan 15, 2025 at 04:51:11PM +1100, Dave Chinner wrote:
> Hi folks,
> 
> This patchset brings some new functionality to check-parallel to
> make it easier to run across different machines and filesystems.
> The patch seti adds these features:
> 
> - auto-adjusts concurrency for the machine it is running on.
> - adds CLI support of selection of tests. These CLI parameters are
>   identical to the check CLI parameters and the test lists are built
>   using the same code.
> - adds support for logwrites devices so that all the test that use
>   dm-logwrites are now enabled
> - adds support for specifying the initial filesystem type to test
>   on the CLI. This makes it easy to select xfs, btrfs, ext4, etc as
>   the target filesystem type that is to be tested.
> - Only block device based filesystems can be used with
>   check-parallel, and this is now enforced at FSTYP selection time.

Can you please add a --help so that curious users don't have to go find
the calling conventions by reading the bash? :)

--D

> For example, testing the rw group on ext4 is now a simple matter of
> adding the "-f ext4" parameter to the command line like so:
> 
> $ time sudo ./check-parallel -D /mnt/xfs -f ext4 -g rw -x dump
> Runner 12 Failures:  ext4/308
> Runner 1 Failures:  generic/095
> Runner 21 Failures:  generic/042
> Runner 51 Failures:  generic/627
> Runner 8 Failures:  generic/032
> Runner 13 Failures:  generic/019
> Runner 34 Failures:  generic/347
> .....
> 
> Options like exclude files, groups and lists also work natively in
> check-parallel now, same as they do in check...
> 
> -Dave.
> 
