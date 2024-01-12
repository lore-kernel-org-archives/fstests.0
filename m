Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB67175B8
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMCdK6r+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F687C433F1;
	Fri, 12 Jan 2024 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705078856;
	bh=k3tzF/7XbGS1+AJGt4Od68mBULRTFmejMZ9d4kNpubo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMCdK6r+gqiqNEGWPYcYtbYud6qCrQdxhd7HWTGaT277dSplP6LJECptkHeKadRMx
	 0oNvGfafQhbyn5hzrIxR5kRPAlugxGjamecmwKEFl2UqCRwtR2h8SSLNNev6z1gMu+
	 02JXcyLK258DIuzw1H1GUP2XqWHut9pT03jHt72au6o2/MApOuNAzI9WmrQfHe4S/Z
	 Tj1M8ymB6q/tfHV2GIlmR7Qbm/GFOpXdr7NqEsH4KdDnj3o1aJHx73R9+UhhYJnib6
	 8EwZzZqQAuOsXkCdMarAv+TR8tsa/xr2gPOj2qKLocpF/hi7+Zp2tNlx5hiwbovPfW
	 aiieLxXdJMaBw==
Date: Fri, 12 Jan 2024 09:00:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] src/af_unix: drop unused offsetof macro definition
Message-ID: <20240112170056.GF722968@frogsfrogsfrogs>
References: <20240112130331.4079-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112130331.4079-1-ailiop@suse.com>

On Fri, Jan 12, 2024 at 02:03:31PM +0100, Anthony Iliopoulos wrote:
> The offsetof macro is causing compiler warnings since it is being
> redefined, but it is anyway not used, so drop it completely.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/af_unix.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/src/af_unix.c b/src/af_unix.c
> index 41037ee4b7ad..89df76586f27 100644
> --- a/src/af_unix.c
> +++ b/src/af_unix.c
> @@ -17,8 +17,6 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  
> -#define offsetof(TYPE, MEMBER)	((size_t)&((TYPE *)0)->MEMBER)
> -
>  int main(int argc, char *argv[])
>  {
>  	struct sockaddr_un sun;
> -- 
> 2.41.0
> 
> 
