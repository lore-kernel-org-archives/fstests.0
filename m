Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58AE374D9
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlBCLDTU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E7BC433C7;
	Wed,  8 Nov 2023 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699479215;
	bh=q0BJeYJPqYpKAIKujdsXjfQnMJlCdRNCJ6r/QOLF268=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlBCLDTUoj7sDDLm/CIkpWvgAybaQ9aabAarpOjn0Y+F26RQAYJOniaOWw5SuUMQf
	 m0r2IhW6YwHq4dJzymkOtOJj3syteQnut54joIbqVGQRqqfWTvd68YfJzNWiJ9KQS6
	 dJDo40ooiqoKDk0GCf1OLhyrJphZAx2m/LuE3k6ls878/fcGD7g+Hq5Ejui9nU3C9g
	 a2EMxhQThhx4KX+eQ5BSDsmlhRmBURYAKEvLcwVdl6PzqyzclREePlMMcjplvB+d4+
	 apREJf3W2YCapbcIOjArshu1OpVoYAPHJ/x7/GxuH8sBRBjbM60zCVQCHtkiDFaN/h
	 RSZqQBl+PilKA==
Date: Wed, 8 Nov 2023 13:33:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common: fix _require_xfs_io_command for specific swapext
 versions
Message-ID: <20231108213334.GC1203404@frogsfrogsfrogs>
References: <20231108152401.432980-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108152401.432980-1-hch@lst.de>

On Wed, Nov 08, 2023 at 04:24:01PM +0100, Christoph Hellwig wrote:
> The xfs_io command (only in Darricks trees and not upstream yet)
> supports the -v switch to select the swapext version.  When the selected
> swapext version is not supported it reports a 'version must be $foo'
> message.  Parse that and don't _notfun the test cases.

Er... which _require_xfs_io_command call fails?  The only patch that
adds 'version must' adds both '-v swapext' and '-v exchrange', and
AFAICT all tests use one or the other if they specify a -v at all.

--D

> This fixes various generic tests trying to use the vfs version that
> doesn't exist in most branches implementing the swapext command.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/rc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 26a26085..d8a0b19b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2706,6 +2706,8 @@ _require_xfs_io_command()
>  			_notrun "xfs_io $command $param ioctl support is missing"
>  		echo $testio | grep -q "Operation not supported" && \
>  			_notrun "xfs_io $command $param kernel support is missing"
> +		echo $testio | grep -q "version must" && \
> +			_notrun "xfs_io $command $param kernel support is missing"
>  		rm -f $testfile.1
>  		param_checked="$param"
>  		;;
> -- 
> 2.39.2
> 
> 
