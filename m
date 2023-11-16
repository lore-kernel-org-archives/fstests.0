Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD97828361
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3O2eEmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C238C433C7;
	Thu, 16 Nov 2023 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700154004;
	bh=H9G4WBFlDQ+0r2z7RmHCDiwXXjR+XC4wXuXVXzPRTig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z3O2eEmK/kPEjWd4gQNPURmecGdSRrRgZ8bJLXkI0piZnyDAJHLXk5t/p6gq3hZmT
	 1iygIIW30ERlIasQXBIS8hOl+XXhAahK2Io4ooULou9YzvWeDOjobe9oI5wqesRYZt
	 UKzaXo9h7MwGW0BFm1gVLtzLnHA8/XJ1AEhsWSwm4RR3RIJew1C9EQxCyQJjroYdgk
	 qU4h3OLGR9WS+MbUFjpPD1DEcdIcJtwKY7vBd0aNc67Lh/LkTA5mCFdFDqnflgET6O
	 4fkNAIzi+Pe5S5u2slZZC9cgXsaQJgtXL0WSoW84sPd9swsuBKNJ60FfCTyimdrzpu
	 GtYCNV0MmDMwg==
Date: Thu, 16 Nov 2023 09:00:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs/263: Remove mkfs.xfs data section argument
Message-ID: <20231116170003.GF36175@frogsfrogsfrogs>
References: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>

On Thu, Nov 16, 2023 at 02:33:15AM -0500, Yang Xu wrote:
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
> But, since xfstests commit baaa392c("xfs/263: don't hardcode inode numbers in output"),
> we don't care the inode number. So let's remove this data section size argument
> instead of increasing this size to 1G, then we can solve this false
> positive.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/263 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index fadd6280..bce4e13f 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -72,12 +72,11 @@ function test_all_state()
>  }
>  
>  echo "==== NO CRC ===="
> -# Control size to control inode numbers
> -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> +_scratch_mkfs_xfs "-m crc=0 -n ftype=0" >> $seqres.full
>  test_all_state
>  
>  echo "==== CRC ===="
> -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1" >>$seqres.full
>  test_all_state
>  
>  status=0
> -- 
> 2.39.1
> 
> 
