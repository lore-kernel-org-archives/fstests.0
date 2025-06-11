Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478033E7
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652206; cv=none; b=OlU6vVbi9MzDFAXQPAZjeIFqJg5vYtCmY2ETuBCZSRelwOgYZfyUQVp8rJza/4UW5lnagYRo7rcrPZ48xcGtgNqeupTmsFR9+9FX9u0H5n+NNw/qGpYJVT6qn6aKJZRCRbJiaLNYtKt+WFZ0Tu9Bf2EeLMvsy96t9xcx90hNjNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652206; c=relaxed/simple;
	bh=UJtmryy9QsYwycIgZjdkowM5GHbvOsTLRwjEv/uFWh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9WrFMVYIqYPBFw9XCDvTPV3klGciG/G146Ue+0Mn2eGMpdSDNscfSRuoTg+2zHKnk0ZOchsXAdBXGaM/1kHHRQ1yplrMo9C5MSsrqOwz6XVCctsbpYpqbrfF8l3Pgo23umblamCstGbAW2mDfHmfMKpla35M1IcpTWAa94e87Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNdgl01H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNdgl01H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86415C4CEE3;
	Wed, 11 Jun 2025 14:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652206;
	bh=UJtmryy9QsYwycIgZjdkowM5GHbvOsTLRwjEv/uFWh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNdgl01HH2759doPEGQgyeBKOxXRDwjMciqu9YLVFKK5e8a3tqLnvx+/BspKMmzzF
	 Klg2HLxrojERujv5+hys+nOLmJHqe0JeGuITRDvrvx0FGzE7606dDh1YiuxphSBSh4
	 DGoHnfUvrKXsLbmOzNSCLkCa6exk0IT/GCPLlRkzYNf5HHas1sSF+eLREWzwW3tVWF
	 XTqYKAMxqfQvcM7JKYjLCW3MKFFvE27TqGPG2+LOFEI7UYbZXyXbshafPZdSPcHHtv
	 cFPt54McFbg4l2EOuu3FXHEJ6tudNJSdqtMdsWbdLh+Sg2Y2pGRoXaz8WtDl7lqV2L
	 Ugf20mbL6QzeQ==
Date: Wed, 11 Jun 2025 07:30:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250611143005.GF6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Insert range and collapse range only works with bigalloc in case
> the range is cluster size aligned, which fsx doesnt take care. To
> work past this, disable insert range and collapse range on ext4, if
> bigalloc is enabled.

Hmmm, insert/collapse-range have the same behavior on xfs realtime,
maybe we should amend test() in fsx to round to the allocation unit
size?

Querying that programmatically might be ... interesting though.  Is
there a good way to do that for ext4 bigalloc?

(See detect_xfs_alloc_unit in punch-alternating.c)

--D

> This is achieved by defining a new function _setup_fs_options
> which can serve as a mechanism to apply FS-wide options to
> the tests.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/preamble | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/common/preamble b/common/preamble
> index ba029a34..2bccff74 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -24,6 +24,20 @@ _register_cleanup()
>  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
>  }
>  
> +# setup FS options only to be available for each test run
> +_setup_fs_options() {
> +	case "$FSTYP" in
> +	"ext4")
> +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> +			export FSX_AVOID="-I -C"
> +		fi
> +		;;
> +	# Add other filesystem types here as needed
> +	*)
> +		;;
> +	esac
> +}
> +
>  # Prepare to run a fstest by initializing the required global variables to
>  # their defaults, sourcing common functions, registering a cleanup function,
>  # and removing the $seqres.full file.
> @@ -55,4 +69,6 @@ _begin_fstest()
>  	# remove previous $seqres.full before test
>  	rm -f $seqres.full $seqres.hints
>  
> +	# setup filesystem options for a given test execution
> +	_setup_fs_options
>  }
> -- 
> 2.49.0
> 
> 
