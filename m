Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7E3DD537
	for <fstests@vger.kernel.org>; Fri, 25 Sep 2026 20:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366697; cv=none; b=W5sDp7pjnmblGEgVJkkEPIpSo1W/Q0fipUbcaggiGFtKTNZlSquonO19TCaNi8GNuLbdst6l1A8CVE5UPPsAp+amXQg/S6PM+oKjm1G8YuRmVRhDtuCCGLH6xGaIX6lQ0mhljR70RT3ABiDeBVBd3zfprjsCpoaq5bHbs8vDiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366697; c=relaxed/simple;
	bh=i2VXnN71iBe1b0Q4e/XG8RKT+/cyEhV9/Pk00F/RcTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxrX8YOodBfOBU1fbbZc0WAFMQEjt+q5L29x4T9I+kybuXASvq38RIe1QyhT/MxL9x8kwJ+xpaZLgXezfaef3vHyB5c7OhWxFlRbtwnrDYpMkNteOrqMIuAFsWpsghycYpwSrrDdiUVfTOTOVYtsHOWwPsUqfijnCZ8A2JBFjsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJJdgOvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJJdgOvq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F0B251F000FF;
	Fri, 25 Sep 2026 20:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366696;
	bh=8HsFFLVT7VXQkblKU8RiUAVKAMHuINtlu56y1FJxuKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJJdgOvq/f/QRAOjeEoCSPBfca382TDdb/OduWhJazPspY0hH219I+21J+ZPFX85S
	 LXEd5521m6SOCM7erdK24gS3nDLECLhsfnqG6V0A+Zw4jgH/p1jio2a7ipMPOu0xR3
	 gnBgNU99wDMKlJj+MCdNaevHI1MqE7oZlTpDaYBZPCpGHQjxtdNh2jZLsqYTF7F++U
	 gdU4qCaqY+ioxsJOfAgMtO8VDFntGxZFdqVmo1SY2u/P7hxOSTLDZEOFcJtQ4X2gXS
	 NwkoXSZRzTTQP243/sdIVEjXhX4cOf2HVDh5plOb8H5A7rCJWhtV8tUov7JvhmlZpG
	 Dn/wfuwXUy4uA==
Date: Fri, 25 Sep 2026 13:04:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests@vger.kernel.org, zlang@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 4/4] xfstests: fix permissions on system file
 installed by libtoolize
Message-ID: <20260925200455.GO6253@frogsfrogsfrogs>
References: <20260925104514.664260-1-aalbersh@kernel.org>
 <20260925104514.664260-5-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925104514.664260-5-aalbersh@kernel.org>

On Fri, Sep 25, 2026 at 12:45:12PM +0200, Andrey Albershteyn wrote:
> Libtoolize installs set of auxiliary files from its system package.
> Not all distributions have the same permissions set on these files.
> For example, read-only libtoolize system package will copy those
> files without write permissions. This causes build to fail as next
> line copies ./include/install-sh over ./install-sh which will fail.
> 
> Fix this by setting permission explicitly on files copied by libtoolize.
> 
> See similar commit in xfsprogs:
> 6b32423addd2 ("xfsprogs: fix permissions on files installed by libtoolize")
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index a48d8d62f038..6c3de609bf38 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -76,6 +76,9 @@ endif
>  
>  configure: configure.ac
>  	libtoolize -cfi
> +	chmod 755 config.guess config.sub install-sh
> +	chmod 644 ltmain.sh m4/libtool.m4 m4/ltoptions.m4 m4/ltsugar.m4 \
> +		m4/ltversion.m4 m4/lt~obsolete.m4
>  	cp include/install-sh .
>  	aclocal -I m4
>  	autoheader
> -- 
> 2.54.0
> 
> 
