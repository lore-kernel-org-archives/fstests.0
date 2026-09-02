Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA54534A9
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361999; cv=none; b=JuzIOCWPJBA3pMGXsJov/A1ygEnfrm9ZRJYSVaFEcETVXeAX/cExNcunSjIT8L6Md5fGQnPw/kPFHtz0bbraZWzy1QSqYYVRmxHl28b1cTY3zHx1lrbpgqzYW5iBYpTY2o3mCNlTRlkbTo206QR5J/+Ex0LWIWQo8vLQ1RZQkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361999; c=relaxed/simple;
	bh=2fJkgHommp1XLRXcmRTpaBX3i3ptf/PPZcYbPbEGxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdlvlTCBNyIYaUYEsJYlouLslyRFrrIoKZsXvca0SZxqRsrs5JAFBwhH5ImZlfefa70RG3yR0Vts3IKgQ3xnNGiqel7JmIK199NbVJhQmy+dZtDsSDvlrfyutCrMSEEjeMLrXozMSPqaKL7qKdUX0VaAra8PNb3geFeAHEuf9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+d/3yNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+d/3yNA"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 592E11F000E9;
	Wed,  2 Sep 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361997;
	bh=QSCDF20/hcGolWWhfuD8INncJm6LkpHXLP7hBjs3Kbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+d/3yNAdiz+2SD4erVQ1P8sUQRHS43RiRhwt5SSRy4/0NiqLVqYDK3W29H9Wl2m2
	 f0HApp6IgTEV9P3kaWurDnU5DISFifEwRPlB5B1jIkzKemKEuKPz46VrPZYj57Jj2L
	 wUdxIghmurWoOOmKYkPwH0h111/AcPjKUNyZ7UqxgZZJ5xZe7ioNledd9/AG4axvFi
	 2UCuYr2fBuRORGk5Ei6v2qyoTiwRMmJiUpBXBawgc/vcmzIFyKxu9FtLktlOikPNte
	 wyPORMHNWFKARxMB0B5gzNeLNBHxnkzesOrKb8k/9Du5kkpeJXhuFHAXU+5Dtn4nWU
	 SR6nK6p5dUBRQ==
Date: Wed, 2 Sep 2026 08:13:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Subject: Re: [PATCH] generic/795: add missing _require_scratch check
Message-ID: <20260902151316.GJ839663@frogsfrogsfrogs>
References: <20260902050139.2426-1-prabhakar.pujeri@dell.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902050139.2426-1-prabhakar.pujeri@dell.com>

On Wed, Sep 02, 2026 at 05:01:39AM +0000, Prabhakar Pujeri wrote:
> The test runs _scratch_mkfs and _scratch_mount without first requiring a scratch device, so it fails messily instead of skipping when no scratch device is configured.
> 
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Looks ok, though if you're going to write more of these patches you
might want to put them all under a single patchset...

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/795 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/795 b/tests/generic/795
> index fa5474c5..4c0e7bdb 100755
> --- a/tests/generic/795
> +++ b/tests/generic/795
> @@ -27,6 +27,8 @@ _cleanup()
>  
>  . ./common/filter
>  
> +_require_scratch
> +
>  fsv_file_size=10000000
>  nproc_enabler=$((4 * LOAD_FACTOR))
>  nproc_reader=$((6 * LOAD_FACTOR))
> -- 
> 2.55.0
> 
> 
