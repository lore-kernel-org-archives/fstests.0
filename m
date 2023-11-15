Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AA31720
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4hNczUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C79C433C8;
	Wed, 15 Nov 2023 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700064344;
	bh=2Yh5M+J31Gcy4vH4QNQGXXrTCG1+igUFmPsCcpz7sO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4hNczUZuxTgd80sXkn0cfhuxuDkA7H62dd/xs/f/jov1sRnMAv/6FcumzZxdUnEr
	 3Tw0O8r21j7qqQxtd6je/PnjYBwK2hx46XaubgzH9CdKnNvzg2HGXE6lH0Mw6jjG+H
	 qTVnyYvX22PxSjE+Fap8SEpl2vsr4O8dWMkZfbD1WESZMPHFJ0ss+CjsGA+a3UHUm+
	 5Hj8Hl097GV4ZopApec4aHKQ44d5T05eQubqgJs1nqyM14CRrpE1Ks+guCTU0tfSvU
	 OzQs/MdFnUn66tnxhL5zTWkmXx/uZ7MUpSN72aJNwam1J6Wo/tS4sKhCPtfV1yyZ7O
	 PXWCIJx0rqBmA==
Date: Wed, 15 Nov 2023 08:05:43 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/263: increase data section size to 1024M
Message-ID: <20231115160543.GD36175@frogsfrogsfrogs>
References: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115055659.2027-1-xuyang2018.jy@fujitsu.com>

On Wed, Nov 15, 2023 at 12:56:59AM -0500, Yang Xu wrote:
> On machine with using raid, this case will trigger
> the following error:
> ==== NO CRC ====
> +mkfs.xfs: small data volume, ignoring data volume stripe unit 512 and stripe width 512
> == Options: rw ==
> == Options: usrquota,rw ==
> 
> mkfs.xfs generates this error since xfsprogs commit 42371fb36
> ("mkfs: ignore data blockdev stripe geometry for small filesystems").
> It disables automatic detection of stripe unit and width if the
> data device is less than 1GB.
> 
> To slove false poistive, just increase data section size to 1G.

Is there a particular reason why this test needs -d size= at all?

There's a single comment about "Control size to control inode numbers"
but then filter_quota_state() seds the inode numbers to #XXX.  So
perhaps that part of the mkfs argument isn't necessary anymore?

--D

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/263 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index fadd6280..48581bac 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -73,11 +73,11 @@ function test_all_state()
>  
>  echo "==== NO CRC ===="
>  # Control size to control inode numbers
> -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> +_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=1024m" >> $seqres.full
>  test_all_state
>  
>  echo "==== CRC ===="
> -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1 -d size=1024m" >>$seqres.full
>  test_all_state
>  
>  status=0
> -- 
> 2.39.1
> 
> 
