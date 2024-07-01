Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD684A2B
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873389; cv=none; b=AQzyLoCTpEn+H4QtIk05CBDWw3vpvV30jrOBER7mnVuGeNnJrWvtUos3iu43uvjpubSD+OzCCax4efAuyQYmV34LC/grxuQSaZvVrE0L5qujad9PhAigBNOuIKr6ghPcXlPGnCOdsOloq72VmP+wBZyDq6WhEUAnTkU10YAH2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873389; c=relaxed/simple;
	bh=7Q8pSltz6bbuuAdlvzoTcmbdstNWbPdljb3xLqGj+Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7rA44x0KyqzUKrm62CQf0V0fZ2YrCyjQQsWaHkSYC+qLL4tRniJIrQuD9wXyWT/lWKkUBIg9ogPrsmdGHPQzvw7qZGUXhtpFfQwhog+sB8bB9DL9ckNTlejJK757woWzL/0DYLYmRSXfEGzt1VMmR5yqCjN2MkCPykwEkKzGDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4lx6fCn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4lx6fCn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4824C116B1;
	Mon,  1 Jul 2024 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719873388;
	bh=7Q8pSltz6bbuuAdlvzoTcmbdstNWbPdljb3xLqGj+Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4lx6fCnJk+Sn0S5TX9DoxkLTdrI5eypc1ow4iv6zU5rpGKX82h3JiwRvMADdoPLy
	 JYzNxEnmFMpc+oY/DriYrFFXPpKmLq7aX8xotCi7Sh2grmn/a23tHrxxtbuVV3lJ6v
	 lDFEmEy6Za55GWFbSt9HOe9L9slXvm77rT0H3aKgbqHpEAycbCo2ppmO/4YvutnfWI
	 Cfw1rOpyVk07Xbx3w6AtLHiIg8lrq9BU1o08zNMINbKBKa98VEfUbT1dCig6ETiGig
	 qSx3UcjQrFRalFkf0T1a49NCalmLPQZBhy4csVB8gY7Vz8A0Pt5gQ5jE2REJ6UU4RJ
	 QNVnIgdTokWnw==
Date: Mon, 1 Jul 2024 15:36:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: da.gomez@samsung.com
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
	mcgrof@kernel.org, gost.dev@samsung.com,
	Samsung Samsung <Daniel Gomez d+samsung@kruces.com>
Subject: Re: [PATCH v2 2/5] common/rc: add recreation support for tmpfs
Message-ID: <20240701223628.GJ103020@frogsfrogsfrogs>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
 <20240630-common-fixes-v2-2-16d26fb1dee0@samsung.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630-common-fixes-v2-2-16d26fb1dee0@samsung.com>

On Sun, Jun 30, 2024 at 11:52:41PM +0200, Daniel Gomez via B4 Relay wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Add support for test device recreation (RECREATE_TEST_DEV=true) for
> tmpfs.
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 163041fea..51827119c 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -604,6 +604,9 @@ _test_mkfs()
>      pvfs2)
>  	# do nothing for pvfs2
>  	;;
> +	tmpfs)

Indentation problem here.

> +	# do nothing for tmpfs

If we're recreating the test filesystem, shouldn't that unmount and
remount for tmpfs?  Or at least rm -rf everything underneath it?  That's
generally the effect of _test_mkfs for disk filesystems.

(That said, I'm much less familiar with non-disk filesystems...)

--D

> +	;;
>      udf)
>          $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
>  	;;
> 
> -- 
> 2.43.0
> 
> 
> 
