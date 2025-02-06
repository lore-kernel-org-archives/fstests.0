Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF223C380
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881546; cv=none; b=h5+kEl4xEXL6wC+4LyPTB2Y8yL6SckV7uM6nEo7Bb9IbrGI6e5fitVuB1lav8uOhcX1sQGcAksYfbay+K2cd9d8FTfiibz7oBRLv6pewdjbiB1T1l28CJcq3dDFg0U4hChEYKYdgBgL+9tBEJTmYxzukO3GBvSenmFYtfUyUhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881546; c=relaxed/simple;
	bh=FDNh/d7173jUhJMpYLqRiDWAZ/6ItyDuOe6xZzxCtZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHR2KxlbVQMtiSTLKkJHS703Ao8sEmnBD1y8wLpeTIWXTXE8NDZuB+34fceeacyVvlHhHxWEyQ4iZv093PVXFCt31SZHMIcV+P3SnzNJj6qqAwWaHfscgPKe4DTfrHOJdQHedgWjiye4YDEM6xO+NMj1OwtdR5xr/fQHXy7OMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2raxZl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2raxZl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B56C4CEDD;
	Thu,  6 Feb 2025 22:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881546;
	bh=FDNh/d7173jUhJMpYLqRiDWAZ/6ItyDuOe6xZzxCtZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2raxZl0IO2p2x4YQcO/zDwU5fh5b9HGRuRYtikRiLo3P0mQan6Zj7L2qsLQYnu4F
	 vOE/oPYs39eGRBlGyqbCo2nanF0uDQn104Qda6H/BWFKsClM1ZusetP+oetgfAVqUF
	 /Z99+6k0934nwDpw0SbbYZuziNUIOIUh4VOtBNpUad+OMNKIbr1Nh4eiYMR/RsFJfk
	 7RiidZQamIhPFxyJlGDwdwLcSi0ODHfX6YoSfcoG3qSoISrq1eLaHYWg2u9GYyCPU0
	 iJ6y+ssa9Nm5HkANZygQ4IiJUmvega78Vk4jxxnfRzCjRBCH5/Fs9hh7fFHaO5ENpL
	 MuM4Hs5mwAbbQ==
Date: Thu, 6 Feb 2025 14:39:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/7] builddefs: define linux
Message-ID: <20250206223905.GO21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-3-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-3-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:19:57PM -0600, Eric Sandeen wrote:
> There are several #ifdef linux guards in the code, but nothing
> defined it. This caused several sparse warnings, so define it
> when building on linux.

cpp in gcc 12.2 defines this:

$ touch /tmp/moo.h ; cpp -dM /tmp/moo.h | grep define.linux
#define linux 1

--D

> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  include/builddefs.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 7274cde8..00dec0ea 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -78,7 +78,7 @@ HAVE_FICLONE = @have_ficlone@
>  GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
>  
>  ifeq ($(PKG_PLATFORM),linux)
> -PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> +PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -Dlinux $(GCCFLAGS)
>  endif
>  ifeq ($(PKG_PLATFORM),darwin)
>  PCFLAGS = -traditional-cpp $(GCCFLAGS)
> -- 
> 2.48.0
> 
> 
