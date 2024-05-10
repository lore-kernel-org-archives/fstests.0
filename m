Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F35170842
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354534; cv=none; b=EA0FsiiMC0vreLAXugsT3KA65tkLaAJ1mQkRc1pN4zZmpm8Y/Pn6gGu7hbDHY76h530pd58VwTtJQ4cNxZT+uH/aYHp9cDC4wtQg6rBDygy8QkDSpQ9dy9wYQmLVZ7EWCsjeXtI7iv6BgD0msf3JNfHvP+EvYIpkhvf9no+7FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354534; c=relaxed/simple;
	bh=rriifnZcmC/Y3SPiZYwmeSkRDJGpOe8cUlHBbSQ7noA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/8laTZVGHKw9P7hBY4iS2Cs80YsKr5hYZG4HjskazqdgWG2ZfpTcZRS0CpoXeIEeXZsKIIZGiEok2WYeIFFDVHhcV0z4QPvr3aX1Le/6fuCfE8SnH6P5aytKxNrfvhqdInOfE4GrJz69pDL7jGCiaA+4MuScYu1cYVRCuWGrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpIo/fbZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpIo/fbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DFDC113CC;
	Fri, 10 May 2024 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715354533;
	bh=rriifnZcmC/Y3SPiZYwmeSkRDJGpOe8cUlHBbSQ7noA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpIo/fbZpLDZDX1PcgqICVWwG9O0oXvTZ8mghtl8yvGPh4tmQic++xRZ/vqomsIpm
	 3fFhafDmaLNuHsvQES+rlc6VOljtBPONMcZ75TlaaPNFxZZZfZzxZ4UqtK31WXP1bk
	 qsipafJWh33A6WyvxjxcoGzvvvWaHYMO2qPiBDoNHyY769s6/spCVRKB/drp/3mjhe
	 NBk36TmeW8qx7Jrvr3LhSKQTE0/wYjp0Eb0r62cDMTs6MXLTGJDWrpNLwdmr+qxvNM
	 sVDrgNlXTx0JsTg8ocNjyCpIlNSLt3ioT0mWp8GunKMqD/GmaKIvqTNr+1MWyM6ClM
	 01Hi/rZYr77cA==
Date: Fri, 10 May 2024 08:22:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] fstests: fix _require_debugfs and call it properly
Message-ID: <20240510152213.GI360908@frogsfrogsfrogs>
References: <20240510042945.1237711-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510042945.1237711-1-zlang@kernel.org>

On Fri, May 10, 2024 at 12:29:45PM +0800, Zorro Lang wrote:
> The old _require_debugfs helper doesn't work now, fix it to check
> a system supports debugfs. And then call this helper in cases which
> need $DEBUGFS_MNT.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> 
> V2 remove the changes on xfs/499, will do it in another patch.
> 
> Thanks,
> Zorro
> 
>  common/rc       | 10 ++++++++--
>  tests/btrfs/150 |  1 +
>  tests/ceph/001  |  2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 56f1afb6..6f0bdf60 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2978,8 +2978,14 @@ _require_sparse_files()
>  
>  _require_debugfs()
>  {
> -    #boot_params always present in debugfs
> -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> +	local type
> +
> +	if [ -d "$DEBUGFS_MNT" ];then
> +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> +		[ "$type" = "debugfs" ] && return 0
> +	fi
> +
> +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
>  }
>  
>  #
> diff --git a/tests/btrfs/150 b/tests/btrfs/150
> index a02bdafc..fd386d92 100755
> --- a/tests/btrfs/150
> +++ b/tests/btrfs/150
> @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
>  . ./common/fail_make_request
>  
>  _supported_fs btrfs
> +_require_debugfs
>  _require_scratch
>  _require_fail_make_request
>  _require_scratch_dev_pool 2
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index 060c4c45..79a5f58a 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
>  
>  # real QA test starts here
>  _supported_fs ceph
> -
> +_require_debugfs
>  _require_xfs_io_command "copy_range"
>  _exclude_test_mount_option "test_dummy_encryption"
>  _require_attrs
> -- 
> 2.44.0
> 
> 
