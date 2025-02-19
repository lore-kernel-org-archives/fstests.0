Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E06214221
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988407; cv=none; b=bt42Q4FQPvMMnVgSvBL5ktohef8GWA3MVdhz3filA+zFZIo9gNCOUw5F9wQA4BnS3xMK78FuQv90ZQltm/SkA0nSaRDB8sga1S3nRUYxttWRZu+FR/HfcJtwG/Nl0PVdMFMw1UC8ZimKdCCV64AZTnB2vl15eiKkk14QeyAzl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988407; c=relaxed/simple;
	bh=0AxOdRgdZrddig6GILPdExEPFJZ1Ybual5DQ4kOCg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5dpmod1nhrKG0l7M1A9JyoyLVOCIXlZRr2stUmHvN4jewUV/92VfE/yy8VnsLrHbGPULDSq+lB8X8fb7hz2t5fdEf+AUXjuHvXd841ZzveitEOGq0xQu4GZgfLFcEi437x4qQRNAedbusMtUu29MajLYmKsR+J+1vYeHvCRABM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkUH9eP4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkUH9eP4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957D2C4CED1;
	Wed, 19 Feb 2025 18:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739988406;
	bh=0AxOdRgdZrddig6GILPdExEPFJZ1Ybual5DQ4kOCg6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkUH9eP4g3xQXrqgUIxmhcqw+B1NEQZomXESYLcQhV5O4EUwSDvD9+WFdQm9jJMEQ
	 xGBcp2bT9hOqnLcUhXGWl3+NpojXfOGuEPOehGqpMsQOMdvaWQTYqE9JQ1jBNeCkYN
	 yzZMsmNPRwT7q8jdmBEm8tO19LgGqpsXdyoquqUYkwcsObgYcG7EbHI8WeETH71yJC
	 e7yz8320Wq28XHxbDGfLmBk8YjWnYBs5MhALmzx0UCIx6zQXjYPG+P3PFWb21KWphZ
	 YkXqb4xlD7VkdOyooF5Ydaa6Nma3Xw939YLmXKMutd/XShsykOudTgt1Ho5zSMVsO/
	 +NZbFY6EwnmJQ==
Date: Wed, 19 Feb 2025 10:06:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH fstests v2] generic/126: run it inside its own
 subdirectory
Message-ID: <20250219180645.GQ21799@frogsfrogsfrogs>
References: <20250219-generic126-v2-1-e7537f6c9607@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-generic126-v2-1-e7537f6c9607@kernel.org>

On Wed, Feb 19, 2025 at 12:57:55PM -0500, Jeff Layton wrote:
> I had been seeing some failures in generic/126 when running on NFS under
> kdevops.
> 
> The problem turned out to be that kdevops makes the root of the NFS
> export mode 01777 by default (i.e. with the sticky bit set). This causes
> some of these permission tests to fail because the open() is called with
> the O_CREAT bit set.
> 
> Make the outcome of this test not depend on the permissions on
> $TEST_DIR. Create a new directory to do these tests in, and clean it up
> when done.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me, thanks for the _cleanup fix!

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
> Changes in v2:
> - add commands to _cleanup() to clean up test directory (Thanks Darrick!)
> - Link to v1: https://lore.kernel.org/r/20250219-generic126-v1-1-018e4e60c811@kernel.org
> ---
>  tests/generic/126 | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb97db706bafd2152856ef0993c5c273441..1f17492ed2a395ed3798c71243f3098558a157dc 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -13,6 +13,7 @@ _begin_fstest perms auto quick
>  _cleanup()
>  {
>      cd /
> +    test -n "$testdir" && rm -rf "$testdir"
>  }
>  
>  # Import common functions.
> @@ -23,7 +24,13 @@ _require_chown
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> -cd $TEST_DIR
> +testdir="$TEST_DIR/generic-126.$$"
> +
> +mkdir $testdir
> +chown 0:0 $testdir
> +chmod 0755 $testdir
> +cd $testdir
> +
>  cp $here/src/testx ./testx.file
>  
>  # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
> @@ -46,7 +53,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
>  $QA_FS_PERMS 040 99 99 99 500 r 1
>  $QA_FS_PERMS 400 99 99 200 99 r 1
>  
> -rm -f ./testx.file
> +cd /
> +rm -rf $testdir
>  
>  status=0
>  exit
> 
> ---
> base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
> change-id: 20250219-generic126-f81b3022c4b7
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
> 
