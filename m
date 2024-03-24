Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD901A38F5
	for <fstests@vger.kernel.org>; Sun, 24 Mar 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299523; cv=none; b=mOTdEWkvVdlkWrxwKVQKsA/3O1fv59HbcOdIecscbHt7OOhIKA1jP/w6RT3p4NUK3d6D0Ds1/XqqgMNi9W+OanfyGov45O5oqLtu0jEN5nqtImrppmaPSQyUPCjR7tsGn8GNosvtdjb8Nk6dNeM7i2uZsCjBX55pWQaDnYeOtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299523; c=relaxed/simple;
	bh=EEu1yKTtLMxUOAEsqoJBkdSMEIvqd9Yt4Uc+wIVTeG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcfWCiwFFLepCx2JR7Lh6a1hM+WBaKLF7jReEsXnx4+MkNlDQ7GpPNx9JlWVG6R1mF5YbetRjUrlrqyyJJjOaOLSrzI5xf3BqXKJmyjqiGZrPFFOWgxapryN4ee3MagqzW1O1Ddj/N58mdV2zz2Z819afPPAZkL57tAUw7ZNm7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU/5BniE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU/5BniE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC05AC433F1;
	Sun, 24 Mar 2024 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299522;
	bh=EEu1yKTtLMxUOAEsqoJBkdSMEIvqd9Yt4Uc+wIVTeG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fU/5BniERWWAH7twIhpUV+D4zRCaBeCwsarSXaBIgESdFLEJ/cKhTSRIIY7fzIddo
	 a+nXNl0mudsNdWm1XXDA1th52VwtR3m8Dojsbo5q1B1t43a5GM2SlN/CjwSlLVhJIL
	 OeKXLVWdZtjl3PJPOKWARkxdrSirbsw3EwQMRks45BEcrHeAjTeGgq+k2NLrBH/yA9
	 Vb21BQ9Egm+kwt91ZbCiJ1dd7XuaW4PiZ0P91cq1sJZ7KN7Gl94c8GjxjCggWBnU5p
	 BIcc4lkaudDzVpfZMAenwuArvCuBuCmkuMuMPyRYTbwh1okUolcBzukldARXNW9M7k
	 aiIoT4SL645MQ==
Date: Sun, 24 Mar 2024 09:58:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: fix unknown _xfs_repair_test_fs function name
Message-ID: <20240324165842.GA6379@frogsfrogsfrogs>
References: <20240324141707.303321-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324141707.303321-1-zlang@kernel.org>

On Sun, Mar 24, 2024 at 10:17:07PM +0800, Zorro Lang wrote:
> Sometimes I hit below errors:
>   ./common/rc: line 1293: _xfs_repair_test_fs: command not found
>   ./common/rc: line 1298: _xfs_repair_test_fs: command not found
> 
> The _repair_test_fs trys to call _xfs_repair_test_fs(), but there's
> not that function in fstests. According to commit c7d81cdecbef,
> it brought in _test_xfs_repair, but called wrong name. So fix it.
> 
> Fixes: c7d81cdecbef ("check: try to fix the test device if it gets corrupted")
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 37d26bf2..47736dc3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1290,12 +1290,12 @@ _repair_test_fs()
>  			res=$?
>  			if [ $res -gt 0 ]; then
>  				echo "mount returns $res; zap log?" >>$tmp.repair
> -				_xfs_repair_test_fs -L >>$tmp.repair 2>&1
> +				_test_xfs_repair -L >>$tmp.repair 2>&1
>  				echo "log zap returns $?" >> $tmp.repair
>  			else
>  				umount "$TEST_DEV"
>  			fi
> -			_xfs_repair_test_fs "$@" >>$tmp.repair 2>&1
> +			_test_xfs_repair "$@" >>$tmp.repair 2>&1
>  			res=$?
>  		fi
>  		;;
> -- 
> 2.44.0
> 
> 
