Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E414A90
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380126; cv=none; b=aIKmXNNbxaRdx7qfKOXa9EWpRX31uipnPZC+moMTBD2JZ0lXWnP711ojiZm/TYuPg+oPuBR3tuCcx0RfOi0zRiMJw7OjxbP/yXUNzaZ3VotCqkoHswRw06AJNUu4C53FY+Zkyc9pnput+rmhWGmQ79CES9YPo6UNM2us/Fap93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380126; c=relaxed/simple;
	bh=Zr80LpVNuvtvcGUS/AzxigxFZwNCPbBjdnjs0EiRVXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmR2vl75BSWjLbgkHgbTzoVsaI575VtnjSUd5zAFjMJtyvxwSKu7Lg+2x1iH1btWb3CQ9DpwWbwjUCwN0mc6T3GSSmgHitQrXeNEtQB6CyCZAMTIThOsAILLOXOY10L5NVnlCsK/AFHtLZlG9nHoGWveuyPkDN0N190QsZ+1tDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoPX9T+2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoPX9T+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB6DC2BD10;
	Fri, 14 Jun 2024 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718380126;
	bh=Zr80LpVNuvtvcGUS/AzxigxFZwNCPbBjdnjs0EiRVXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoPX9T+2Gmqo8tjkLnKIOz8sX+pV2dXJLSuE5vk1cvs/1d7Px1Uug0ncRl96Fsa3q
	 jYVeN5T4OyROJz/eF4g31K7Ua3DmXHgZoTabnWTygiyI4aX0ZH6Mz5G/6Qm/PbHTLh
	 6FMn07qS9OAn/vN1KC59+sjlGddmobrsodYivbPpI6uYSbijAJnyORqkqyyoiXREAD
	 LjeREbgw/jWOav1qSWFW6Kli6YrmSgQM+Bu7Gnmk13aR+FuV/OBfF6aXWBey1sL6uy
	 nkXcuKEnh0isIkItDdZOY0mG5RtthlIGQ6ZyuKrvB8mjMWcNQnt0ShDitb72IfgaIE
	 sdGG1hH43gYdw==
Date: Fri, 14 Jun 2024 08:48:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 3/5] common/rc: add recreation support for tmpfs
Message-ID: <20240614154845.GD6110@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061727eucas1p20922542ef700d0f41dc9cc9628392518@eucas1p2.samsung.com>
 <20240614061722.1080-4-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-4-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:25AM +0000, Daniel Gomez wrote:
> Add support for test device recreation (RECREATE_TEST_DEV=true) for
> tmpfs. This allows to inherit the tmpfs profile extra mount options
> (TMPFS_MOUNT_OPTIONS) for the test device.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 163041fea..7f995b0fa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -457,7 +457,7 @@ _test_mount()
>      fi
>  
>      _test_options mount
> -    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
> +    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $TMPFS_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR

Same question as the last patch -- why is it ok to inject
TMPFS_MOUNT_OPTIONS here when FSTYP is not tmpfs?

--D

>      mount_ret=$?
>      [ $mount_ret -ne 0 ] && return $mount_ret
>      _idmapped_mount $TEST_DEV $TEST_DIR
> @@ -604,6 +604,9 @@ _test_mkfs()
>      pvfs2)
>  	# do nothing for pvfs2
>  	;;
> +	tmpfs)
> +	# do nothing for tmpfs
> +	;;
>      udf)
>          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
> -- 
> 2.43.0
> 
