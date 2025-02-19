Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA9286284
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985507; cv=none; b=olVYtSrgVNa37wBhdQOrw4ma8RcH0j3dKfIV5J4L/T/i4BIBNrPNp7xsnApJDEqQ4ET0On69svM35276VyPjtccp1qjP7+Sc2RxuorMYtkFWRV+c8+anXtECik3HZ9n1ARPi5CwEpfbD/CyjUy8Vm6ftEJLsvOBoyjIAT2EmYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985507; c=relaxed/simple;
	bh=1dFLLiQ9JRVtr50KhPaOoGmNgLjhwrkpAbyCNceJzkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEbwbjDgUxRT/tQsDRNjYJ9lWcg4SV9RLxI3/WOPKJPtGga5sXl/UAZOZ8P/mMFdUwU+ENDxjy6BBBFs/3wrL57YR8dkziW2bqlRViVql89UATrsb+348uHpLaOdxLw0/v9X0sAnMQa/f2s05M/V/Ok9GnqKZs2eld9jxmyMUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5z1ueKb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5z1ueKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70CCC4CEDD;
	Wed, 19 Feb 2025 17:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985506;
	bh=1dFLLiQ9JRVtr50KhPaOoGmNgLjhwrkpAbyCNceJzkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5z1ueKbU4CccCFTuq3rM8gzO2/S6vurcoCAeNvyzPdWaSjuL5yOAhHuFMGRy1GZG
	 5S9GNSBCji4vppnwrhSAQW4iFfGcQtaAHw2rh8H7BbmBxx/epHuwdxaOHa0UdkRZAn
	 EhEvpXkbEODxfJwXUOb+LnnVsDl3bWTG9PS+ehWCt9S4RvJTyDhTUO6RM2/urbme3V
	 brVf2xqRTV6EZy3Q1PyC0pzJUN4FGH+9E6NcLYTZq+4i7R7gTjZ7/qGVsFxKYuA3l+
	 R3TOpfrBMPgneCQCYdiU42IP/HCOaBtqMIQnLS2E3midBa+bF2TkaEtySN1kTlLp9d
	 XVqRG556h/pDQ==
Date: Wed, 19 Feb 2025 09:18:26 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH fstests] generic/126: run it inside its own subdirectory
Message-ID: <20250219171826.GP21799@frogsfrogsfrogs>
References: <20250219-generic126-v1-1-018e4e60c811@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-generic126-v1-1-018e4e60c811@kernel.org>

On Wed, Feb 19, 2025 at 11:50:03AM -0500, Jeff Layton wrote:
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
> ---
>  tests/generic/126 | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb97db706bafd2152856ef0993c5c273441..fe0d6db1b6bd85d4942333fdf04d23a63c4052ec 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -23,7 +23,13 @@ _require_chown
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
> @@ -46,7 +52,8 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
>  $QA_FS_PERMS 040 99 99 99 500 r 1
>  $QA_FS_PERMS 400 99 99 200 99 r 1
>  
> -rm -f ./testx.file
> +cd /
> +rm -rf $testdir

You might want to put:

	test -n "$testdir" && rm -r -f "$testdir"

into _cleanup so that it's always removed?

--D

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
