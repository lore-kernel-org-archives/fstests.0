Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7949893
	for <fstests@vger.kernel.org>; Mon, 18 Dec 2023 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1tN1J1K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DE8C433C8;
	Mon, 18 Dec 2023 22:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702939526;
	bh=bwwLoWdk7PKv8eJmZg2fniRhpuqsWxFC9kt58gy1heU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1tN1J1KCkZcRBIO4iM2YUDnNHt10nqdyEtiwLfm92S4GxqAM6W2XFIDKPJ7Aq7ql
	 LGZ1mAk8NosvetTSfbLvDg3kY0OFepzcQXnoLv2wwhUUDvHBXn3gtxI4y8kfTZh6EO
	 kk4jUMnp7irseORlCoWis6orYD2OWPCeDyPKbD5gcWxB8tY/+/eDuuI9CpVclYZQ4m
	 92v3/5Adc3PrDTqPeC8vkBGWu7hCmoHq1PUdNoVzm0/+c53hpgvFRe/UY7R47GmdJy
	 eNnEDtv602ZMZeKKLpThMRNeNLkSj0wYQwyu3I8Tvxf7lB5Hxpu4hjY12b3hTY3eyX
	 JTtuZluNzZFHQ==
Date: Mon, 18 Dec 2023 14:45:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alexander Patrakov <patrakov@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v3] _require_sparse_files: rewrite as a direct test
 instead of a black list
Message-ID: <20231218224526.GA108281@frogsfrogsfrogs>
References: <CAN_LGv2u5qRq_Zmp+qPGXz-PXdO7Bu33CKn+ycmQX1dzbDRFvw@mail.gmail.com>
 <20231218205720.3498-1-patrakov@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218205720.3498-1-patrakov@gmail.com>

On Tue, Dec 19, 2023 at 04:57:20AM +0800, Alexander Patrakov wrote:
> _require_sparse_files was implemented as a list of filesystems known not to
> support sparse files, and therefore it missed some cases.
> 
> However, if sparse files do not work as expected during a test, the risk
> is that the test will write out to the disk all the zeros that would
> normally be unwritten. This amounts to at least 4 TB for the generic/129
> test, and therefore there is a significant media wear-out concern here.
> 
> Adding more filesystems to the list of exclusions would not scale and
> would not work anyway because CIFS backed by SAMBA is safe, while CIFS
> backed by Windows Server 2022 is not (because the specific write
> patterns found in generic/014 and generic/129 cause it to ignore the
> otherwise-supported request to make a file sparse).
> 
> Mitigate this risk by rewriting the check as a small-scale test that
> reliably triggers Windows misbehavior. The black list becomes unneeded
> because the same test creates and detects non-sparse files on exfat and
> hfsplus.
> 
> Signed-off-by: Alexander Patrakov <patrakov@gmail.com>

Looks good, thanks for replacing the FSTYP test with a functional test.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index cc92fe06..a9e0ba7e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2870,17 +2870,30 @@ _require_fs_space()
>  #
>  # Check if the filesystem supports sparse files.
>  #
> -# Unfortunately there is no better way to do this than a manual black list.
> +# Filesystems (such as CIFS mounted from a Windows server) that generally
> +# support sparse files but are tricked into creating a non-sparse file by one
> +# of the tests are treated here as not supporting sparse files. This special
> +# treatment is done due to media wear-out concerns -- e.g., generic/129 would
> +# write multiple terabytes of zeros if allowed to run on a filesystem that
> +# ignores the request to make a file sparse.
>  #
>  _require_sparse_files()
>  {
> -    case $FSTYP in
> -    hfsplus|exfat)
> -        _notrun "Sparse files not supported by this filesystem type: $FSTYP"
> -	;;
> -    *)
> -        ;;
> -    esac
> +    local testfile="$TEST_DIR/$$.sparsefiletest"
> +    rm -f "$testfile"
> +
> +    # The write size and offset are specifically chosen to trick the Windows
> +    # SMB server implementation into dishonoring the request to create a sparse
> +    # file, while still fitting into the 64 kb SMB1 maximum request size.
> +    # This also creates a non-sparse file on vfat, exfat, and hfsplus.
> +    $XFS_IO_PROG -f -c 'pwrite -b 51200 -S 0x61 1638400 51200' "$testfile" >/dev/null
> +
> +    resulting_file_size_kb=$( du -sk "$testfile" | cut -f 1 )
> +    rm -f "$testfile"
> +
> +    # The threshold of 1 MB allows for filesystems with such large clusters.
> +    [ $resulting_file_size_kb -gt 1024 ] && \
> +	_notrun "Sparse files are not supported or do not work as expected"
>  }
>  
>  _require_debugfs()
> -- 
> 2.43.0
> 
> 
