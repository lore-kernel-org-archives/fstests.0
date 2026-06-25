Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9332B113
	for <fstests@vger.kernel.org>; Thu, 25 Jun 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412981; cv=none; b=bZIcm94KuXsrndhnM52QSDAo12OUbg+IWzh+gMLOwi9jeKuLI7BLdzUC/uxqpszZfzbcMOqDALE4g4T9n7oB1qSvhxzpIs2e0wpsl9jmbwneTpnVf8qf1heFmnxA2sRNDZbPCCdio/3KWWFUBvdsmdpUf8a6Hey/WtZg5Gly2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412981; c=relaxed/simple;
	bh=lRoCf8FtOyZeghTZ2YHmbCBqNGRqyDPBiJrcjmHARU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS6Cm43mLQG0WFCBVh9MxDzUrIuq4wvszOypaJJFLKUIUJ+F+gvd2Je8MwOKsxyAyPT5AuHab3Vqrwsz6l7C1338PIIM/lOMAf01cXOHPsIhGoEhi/BskHwMxdiEUpoJemxYIiGIVJ9t4yJhbB78iAxEaYMItXkFNoMb5jSuL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI4UoEaT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI4UoEaT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 822AF1F000E9;
	Thu, 25 Jun 2026 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782412980;
	bh=YBTEDM8VSdUY/q3LRrA0neo0b/AjBm30uZgqH3n0xRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jI4UoEaTrN3cHD+LiC9oER7WFsNCalm5BsD2dRAB/2i+haSHgO8/3obvX43ScJohp
	 OJKYIoG8BHZhCoaxKmkbA6yKj0LLFO6P3H7W0yYLYGJY706hInHXB4Rf0oGfrlMob+
	 f8deuAxAhtNtQt4vIAls9RbWSFEjWkAJTll8okDK5njBAv/Hc+aQzGOa4eFGbS8vuN
	 u4kV0F1TDGmSc4JadHr+/NjisG8YH8K2mI6XkKuBun50yY8h26IArj3a6+Q6qna+uV
	 YrjYtvX0jT775MS98RIjWhg16Tfuz+az92YMbn6grSzp++ZQHREMNEfqgL0aLQv/rC
	 saWQJg8qp1KqA==
Date: Thu, 25 Jun 2026 11:42:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH] generic/645: Confirm availability of free inodes
Message-ID: <20260625184259.GP6070@frogsfrogsfrogs>
References: <20260617054216.3186441-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617054216.3186441-1-ojaswin@linux.ibm.com>

On Wed, Jun 17, 2026 at 11:12:16AM +0530, Ojaswin Mujoo wrote:
> When running generic/645 with ext4 using 64k block size + bigalloc, the
> test fails with ENOSPC because the filesystem runs out of inodes before
> the test completes.
> 
> The test creates approximately 10,001 files, however, in this particular
> configuration a standard 5G FS only has around ~5100 inodes resulting in
> the ENOSPC failure.
> 
> Add a check using _get_free_inode() to verify sufficient inodes are
> available before running the test, else skip it.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/645 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/645 b/tests/generic/645
> index d6eb75e6..944b33db 100755
> --- a/tests/generic/645
> +++ b/tests/generic/645
> @@ -19,6 +19,12 @@ _require_chown
>  _wants_kernel_commit dacfd001eaf2 \
>  	"fs/mnt_idmapping.c: Return -EINVAL when no map is written"
>  
> +_free_inodes=$(_get_free_inode $TEST_DIR)
> +if [ $_free_inodes -ne 0 ] && [ $_free_inodes -lt 10001 ]; then

I'm assuming the > 0 check here is to cover weird filesystems like fat
that don't advertise any inodes?  /me wonders if that ought to be a
common helper where we can record that justification:

_require_free_inodes() {
	local path="$1"
	local nr="$2"

	local _free_inodes=$(_get_free_inode "$path")

	# Weird filesystems like vfat don't report any inodes, so we
	# can't check for sufficient free inodes; IOWs, FAFO.
	test "$_free_inodes" -eq 0 && return

	test "$_free_inodes" -lt "$nr" && \
		_notrun "Insufficient free inodes ($_free_inodes), need at least $nr"
}


_require_free_inodes $TEST_DIR 10001

(maybe clean up the comment a bit)

--D

> +	_notrun "Insufficient free inodes ($_free_inodes), need at least 10001"
> +fi
> +
>  echo "Silence is golden"
>  
>  $here/src/vfs/vfstest --test-nested-userns \
> -- 
> 2.53.0
> 
> 
