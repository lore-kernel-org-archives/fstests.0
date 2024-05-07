Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2078C76
	for <fstests@vger.kernel.org>; Tue,  7 May 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121589; cv=none; b=RMarv8HXZKOs13iLdGM/vMftxyNns88+euBBBMS8DUiijH/fm6ExiPu52nvJY5O6suZ/CP1RP6gsFsIAUMgcRPrndgKZkQlHn5QlBq7EsPmusVhG5Fj3j+WnJWe1CgiB4n4WORj1ea1xFCGtbhOygT8kTuUUVyJpmTIl3g4FtSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121589; c=relaxed/simple;
	bh=vLNAfSLPbgYTqbLgo2Ary2P5sKAK2h89YC2UyQSiBZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvwA+K8UpoFVZgwdoK6dcUuNjWDeT7aZuFDxjFd2VVmTbiwHp7KR/Dgwph5u/SU6ZvZoKMiw19UfZVit1mCqpHLW4ds4ks0ODeTkIMkBb2fm6Ei/40Vzcpq/5t2d3/DJcF4CbGkYD1e+yQaOfx2JJoNZRb3hvipG5qqaUtYBtbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHgX9Gos; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHgX9Gos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E314CC3277B;
	Tue,  7 May 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715121589;
	bh=vLNAfSLPbgYTqbLgo2Ary2P5sKAK2h89YC2UyQSiBZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHgX9GoswbzQBhbGUKBhKNZ2c5EqQUiEDgUfuoenNjpRaIH/Y8xyF8SV7n9sobjiX
	 oTms1gpyb/6zIgX5RFT7FlXhIcEgikK8COOMdRA13LdVU3Ezb5lgIgpGDj/QIZCYq3
	 L4VI87whxwS3jkypV3rmSpoC4WxTtGiLy+chRqoFIxQCMXZau2C8tsNlctespVPbIv
	 57Hf6lG+wYvkSxK/3KCEv/nkXmYaFPjVtyVTAr8EFdiroie8O6udbHSEXI/P3NhNQe
	 svRGxA66ACiebjNHubvbfIpQAMxH09IT4Mq4tyUQ6c0AoMG5RyRylclnqa/pFn6lUE
	 g3oUqBlORChiA==
Date: Tue, 7 May 2024 15:39:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 0/4] Move test cased from shared to generic
Message-ID: <20240507223948.GF360908@frogsfrogsfrogs>
References: <cover.1715108589.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715108589.git.dsterba@suse.com>

On Tue, May 07, 2024 at 09:07:28PM +0200, David Sterba wrote:
> Hi,
> 
> as discussed recently, the tests in shared should be in generic.
> 
> Based on branch patches-in-queue, commit e098483c662d8f0b7583edca1501d8addd3b7549.

I'm glad to get rid of shared/ finally.  Modulo my question about the
.out files, I agree with this change.

Acked-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> David Sterba (4):
>   Move shared/298 to generic/740
>   Move shared/002 to generic/745
>   Move shared/298 to generic/746
>   Remove rest of shared/
> 
>  check                                     |  2 +-
>  tests/{shared/032 => generic/740}         |  2 +-
>  tests/{shared/032.out => generic/740.out} |  0
>  tests/{shared/002 => generic/745}         |  2 +-
>  tests/{shared/002.out => generic/745.out} |  0
>  tests/{shared/298 => generic/746}         |  2 +-
>  tests/{shared/298.out => generic/746.out} |  0
>  tests/shared/Makefile                     | 24 -----------------------
>  8 files changed, 4 insertions(+), 28 deletions(-)
>  rename tests/{shared/032 => generic/740} (99%)
>  rename tests/{shared/032.out => generic/740.out} (100%)
>  rename tests/{shared/002 => generic/745} (99%)
>  rename tests/{shared/002.out => generic/745.out} (100%)
>  rename tests/{shared/298 => generic/746} (99%)
>  rename tests/{shared/298.out => generic/746.out} (100%)
>  delete mode 100644 tests/shared/Makefile
> 
> -- 
> 2.44.0
> 
> 
