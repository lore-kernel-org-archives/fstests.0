Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B43211499
	for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900216; cv=none; b=TAQWyfwlK6co9uMHs8N8OjfAH5SebSGukN7rajF8+Tk6YViOJtmcj/rtTFhOiaUaLVTTK1Oliecg/OD0ijVHZTY69XvMQ3XO0DLjMJRHcdCutRIOS7hmXcr1fktyJ45ksziO5XZJUjauwUP3SebsdSlED+KXyJeFqS9bX9omDHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900216; c=relaxed/simple;
	bh=RfzrYOx8L8Zp8Db/VcUj8ikXX0fTSsLg4Dz7wWC1C5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr47mdtDPea5NYbTSYkASBMLWj88hP8QG53cV3jEZJjE62TbUpm5my/mcwrOwEhEUugCUZgiJhGGhOM+ijDBJbOsRI1teN2plBW4qfGHu09Enlc9AbpWhG2u36UP1leYzqMK1Qorw2cNw69QBt2oU/6xXhXLYPeE6TZqEj+acuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATycwEko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATycwEko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73303C4CEE2;
	Tue, 18 Feb 2025 17:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739900215;
	bh=RfzrYOx8L8Zp8Db/VcUj8ikXX0fTSsLg4Dz7wWC1C5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATycwEkobjHFmjZcjGx2/zWLKqj6FDMOZSDQrmP5RKzTiyquTBp25usJRFm++Cnmh
	 TYnA8aDaowvkddmMVlMS89pObpQ1rufz0IFBTuQvEwOQ+0E6DIhVrVnR+FH/usBVkB
	 NUSjHJzPqT/PvH7/mKyvYB8y4mDoXcrDFZ+1Rzl8ucZTNUrP3nQgu7Gk5z0yY2C+jq
	 sboXfepYxZtBGWQNveFrudQqkSRmfLrNsWWTlsmTU5RCch2a9d8CCbbjt+yFDhUz9C
	 frYwyXhpxJEkRKNifKGnenyNn+fzwihcNDa/YeWGm9pQTXoc/tL7g+xsmxOYtSvufD
	 QslIzkFLUzF1A==
Date: Tue, 18 Feb 2025 09:36:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fsx: add missing #include for sys/uio.h
Message-ID: <20250218173654.GJ21799@frogsfrogsfrogs>
References: <20250218145012.382965-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218145012.382965-1-tytso@mit.edu>

On Tue, Feb 18, 2025 at 09:50:12AM -0500, Theodore Ts'o wrote:
> The <sys/uio.h> header is needed to provide the function declarations
> for preadv2() and pwritev2().
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  ltp/fsx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 2c19fff88..9a3d4cce0 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -38,6 +38,7 @@
>  #include <liburing.h>
>  #endif
>  #include <sys/syscall.h>
> +#include <sys/uio.h>

Already fixed by commit a7d82369dcae0d ("fsx: fix compile error for
preadv2()") in for-next.

--D

>  #ifndef MAP_FILE
>  # define MAP_FILE 0
> -- 
> 2.47.2
> 
> 
