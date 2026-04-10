Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07D3E1CE6
	for <fstests@vger.kernel.org>; Fri, 10 Apr 2026 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839816; cv=none; b=i2KFw1mFBYLQYQI2cPD+lhimtyxBY5ZOpW61Opyw56h+bGuBYiSMGzv3xI9gQ4kf9JyBkse5FY5rNl/9d1W6RUsbWJuuXSx4kzphElPYyX2xMWzt5sWLRqpYKCjXVB2wnXl4i75n8VOgknQxA8EFK2+Ay6lqAZB/PDdQXqbIYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839816; c=relaxed/simple;
	bh=1pqrTm32kGAkwBeJ9yLMTHjdgUxWd1pHkdspGWjc/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW2+JefPjYCOOpNqH1SOdVulamKDcyKQXicJJkFM5ob1eoUL3HtJ2XePEX9hmAeM3apcxOXPrymsgxuRVB/j6EjnKDgDWlml9R3CNHAE7bWJzy7mWdtQnI42PuQq4bwTfBtJcVuWAJbbW1MpERoLLymxs+dFbOqsjEhp+gM3ODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irjG/P4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irjG/P4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D88C19421;
	Fri, 10 Apr 2026 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775839815;
	bh=1pqrTm32kGAkwBeJ9yLMTHjdgUxWd1pHkdspGWjc/TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irjG/P4t3Z4Shdtjra4grVA0MS3+JU3QdghY4LKnSlooXYQ58Opy4SFitmz/LTm+p
	 CYHsN7LIJnT4sKN4Ys/x4q4keF6pAz5XhjSRz4pu5ZOZ8oyj5qTLELUZSI+qBMg/Bz
	 g9q3XZ3QoRebxC+Cv++EEhLme6T4otXkkdXcMCj+XSkXO8VqGl52U6sWwuC/NMmb6p
	 zF3hCd9xKN1s7aLBDuExGYjTdbqaVtvzWfL+BcJZ/3//A2Ql9XTP5iVIgrrwfQvRBB
	 SarsEuj/vmgsv6tzX2UfkU16BACKPvbYNhWuhNcBeX67Se85b6tXg/auNeuBvBJKoK
	 XtxkJ8iHl3Zpg==
Date: Fri, 10 Apr 2026 09:50:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	fdmanana@suse.com, ritesh.list@gmail.com, naohiro.aota@wdc.com,
	wqu@suse.com
Subject: Re: [PATCH 2/6] common/rc: Add _sysfs_queue_path helper with
 partition support
Message-ID: <20260410165014.GQ6212@frogsfrogsfrogs>
References: <cover.1775802601.git.ojaswin@linux.ibm.com>
 <b88d249da588e8caf671088b34ced493e494d595.1775802601.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b88d249da588e8caf671088b34ced493e494d595.1775802601.git.ojaswin@linux.ibm.com>

On Fri, Apr 10, 2026 at 12:06:02PM +0530, Ojaswin Mujoo wrote:
> Add a generic helper function to get the sysfs queue path for block
> devices, properly handling partitions. Partitions don't have their own
> queue directory in sysfs - they inherit from their parent device.
> 
> This helper checks if a device is a partition and returns the parent
> device's queue path accordingly, making it easier to access queue
> attributes for both whole disks and partitions.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Excellent!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  common/rc | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 5fe44e21..d7db5db1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5172,6 +5172,30 @@ _sysfs_dev()
>  	echo /sys/dev/block/$maj:$min
>  }
>  
> +# Get the sysfs queue path for a block device, handling partitions correctly.
> +_sysfs_queue_path()
> +{
> +	local dev parent
> +	dev=$(_short_dev "$1")
> +
> +	# For partitions, queue details are in the parent device's sysfs dir
> +	if [ -e "/sys/class/block/$dev/partition" ]; then
> +		parent=$(basename "$(readlink -f /sys/class/block/$dev/..)")
> +	else
> +		parent="$dev"
> +	fi
> +
> +	local queue_path="/sys/block/$parent/queue"
> +
> +	# Verify the path exists before returning
> +	if [ -e "$queue_path" ]; then
> +		echo "$queue_path"
> +		return 0
> +	else
> +		return 1
> +	fi
> +}
> +
>  # Get the minimum block size of a file.  Usually this is the
>  # minimum fs block size, but some filesystems (ocfs2) do block
>  # mappings in larger units.
> -- 
> 2.53.0
> 
> 
