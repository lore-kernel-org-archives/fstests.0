Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0A171E71
	for <fstests@vger.kernel.org>; Fri, 14 Jun 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379815; cv=none; b=OMn18aMlwr869JhZoHUEQ3Pu93fJnYLUMsUgHSetATCNl37DUd178KtPnFEtU1Mzg/Ulus4IXYc8Zixt1/AlrzryeM99FUQwY3xu0gI31/TS25xrWZGq+U6+AZfooPIN7ovTECVAnyK1ucNeqtGT5mGsiE/InJlZlieEQqmhDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379815; c=relaxed/simple;
	bh=SIzMWpu0PaG+Oxm6xIMWSGmCkpEdNJc2Z5cF9krkzzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOh9uMFbrAvkiIy2nQLW8fmCw4pqyvEd1VRmqYE2E9tFVlm1obUmM/QOXj0sl5C2EHcM3qsx1WKOrnrjLbLtkvnWof3Yb38XM/2hx5W17sxKGm/9DfNwtLzsCl0xXlYyl6asH/PnGEVRZkuEMp24pqsEqUo3ppNZzeYLdvqFcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A33jZ2Ia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A33jZ2Ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B43C2BD10;
	Fri, 14 Jun 2024 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379815;
	bh=SIzMWpu0PaG+Oxm6xIMWSGmCkpEdNJc2Z5cF9krkzzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A33jZ2Ia2hdjYXZGU0+A7La59K4bu5Bfcval8u57JC079AawP5eo2LBtn4FEMeOrj
	 tM4nANNjDbQC0TlZjhnU037SfkTDCu/v9QYYf6pj5V9kV78SnbXf734MuCE2iHzf//
	 cecI8gOsKs8hw/Pyei9eOXsbIQ/xOLd0jlTIieHxDyUAMUmDHKYYwAlaDhZbn7OiC9
	 2lFkYt/Z90zX7gPlUSWIvbCXau6LHJpb4Zir2hCs7EVJueX6fva0ykvfEnYJyUP44z
	 hEJH9A7rrCSnTeTN153qESUp9HICVhFkN6pQqTyYHA5Y8nWb2M58EAJ4G91N6I/vpD
	 6oG6A8cTajEJw==
Date: Fri, 14 Jun 2024 08:43:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	"hughd@google.com" <hughd@google.com>
Subject: Re: [PATCH 1/5] generic/449: not run on tmpfs earlier
Message-ID: <20240614154334.GA6110@frogsfrogsfrogs>
References: <20240614061722.1080-1-da.gomez@samsung.com>
 <CGME20240614061726eucas1p1adfe39fea57e14eeab2fe58a08392fd4@eucas1p1.samsung.com>
 <20240614061722.1080-2-da.gomez@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614061722.1080-2-da.gomez@samsung.com>

On Fri, Jun 14, 2024 at 06:17:24AM +0000, Daniel Gomez wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> Do not waste 14 minutes to discover that tmpfs succeeds in
> setting acls despite running out of space for user attrs.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  tests/generic/449 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/generic/449 b/tests/generic/449
> index 2b77a6a49..ffbad12e9 100755
> --- a/tests/generic/449
> +++ b/tests/generic/449
> @@ -23,6 +23,12 @@ _require_scratch
>  _require_test
>  _require_acls
>  _require_attrs trusted
> +_require_block_device $SCRATCH_DEV # hack to exclude tmpfs for now

If you're going to _notrun tmpfs below, why is this ^^^ hack needed?

> +if [ "$FSTYP" = "tmpfs" ]; then
> +	# Do not waste 14 minutes to discover this:
> +	_notrun "$FSTYP succeeds in setting acls despite running out of space for user attrs"

and this should explain /why/ this test should be skipped for tmpfs:

_notrun "$FSTYP does not allocate acls and data from the same space pools"

(assuming tmpfs does not in fact charge acl and data to the same account
like ondisk filesystems have to)

--D

> +fi
>  
>  _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount || _fail "mount failed"
> -- 
> 2.43.0
> 
