Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A122E11DC
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826893; cv=none; b=b0S6hEl1vkLgU8rZvDhVu5ybQpKrw8QsgLkZwHZruBZS4KY3bV32ZPjUyTWVx827oGC5tp82qG6DZoKxHNyS7PHk2zgxGAnBnChHvxY0KUU1wNZ8uZIRZqABBKBf7Swo7vUKedA5jQMC7bYWp/ItU65pWbOaQ+R1S3aMK4ZPBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826893; c=relaxed/simple;
	bh=VcAatDr/bhaDHkz36NFkVSWn8SnnAxiyXfK2nz1oOMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e73XYQY6xNcoiAfiYtkYU+W33h7O/OVOTXy5R8YoMmdHkH+PqGO29Z+ejhmwH0HQrnbZZFcLwusfPPZhSRuq5Fxtnujas4qYbRpfICnThCbdwYCWkHmd2GdoT7ozBwYx/i9QA1rrfFMOem07w4mKUTVrDDk1I1JsXbPuiYbEcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGzUORI8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGzUORI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F95C4CEED;
	Fri, 13 Jun 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749826893;
	bh=VcAatDr/bhaDHkz36NFkVSWn8SnnAxiyXfK2nz1oOMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XGzUORI85v8S48bkZDsSg8dCox04nhcg2Z79Wk/QS2gpMqlYPNVQArtGpKdalqFIa
	 avFeKosra017b2A4hMCIkNMX+bumYWoxnj3ZIYwfJ6/IGn7nQflzl3Wy4P3qhp9Ucc
	 p9Gn3H13/LjXVf7opObraisNJmdQuAHWxq5OmYWsZnQ18ZDfHZZzDRZenyKdtGzUvj
	 hBZJpzeaok/CI1zL/j2sj9WPKmdbQFbkjyrCMmznRKVswxmlpTiza93K2kZZGbay5D
	 6fK/HKY7kr4EolvU7dlJNTIaS7tldUVLh5D6O5md35tmseo/Wet5BHV1xC40PWLYNx
	 9yYPsiR6ZQu5Q==
Date: Fri, 13 Jun 2025 08:01:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org,
	Friendy Su <friendy.su@sony.com>
Subject: Re: [PATCH] generic/633: add _require_chown
Message-ID: <20250613150132.GW6143@frogsfrogsfrogs>
References: <20250613135209.645818-2-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613135209.645818-2-Yuezhang.Mo@sony.com>

On Fri, Jun 13, 2025 at 09:52:10PM +0800, Yuezhang Mo wrote:
> For file systems that do not support chown, such as exfat,
> running this test does not make sense and should be skipped.

/me scans the test, only sees stuff about idmap...

If I read this correctly, exfat doesn't assign individual files a
user/group id, so idmapping (which is what this test really does) has
very little meaning, because every file is "owned" either by the value
provided by the uid= mount option, or the uid of the mount(8) process.
Therefore g/633 can't test remapping of select uids.

If that's the case then
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/633 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/633 b/tests/generic/633
> index b683c427..d75d4dc8 100755
> --- a/tests/generic/633
> +++ b/tests/generic/633
> @@ -13,6 +13,7 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
>  . ./common/filter
>  
>  _require_test
> +_require_chown
>  
>  echo "Silence is golden"
>  
> -- 
> 2.25.1
> 
> 
