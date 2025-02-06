Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2C123C380
	for <fstests@vger.kernel.org>; Thu,  6 Feb 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881388; cv=none; b=SwXOBIOPsQ8861PTV9JbvbiUUhXbukotw6By4l6usFIRNjM8ton+IjIlOVjAIBbRvbXHw2bLiDyLInTu998SP2o6lUB+NjJeNr3Wmhp/rajj/iAu/0Fsd1nA6MmTL6xekMONVfwUBVzLh/uMfQTJiuaXRMbFPuLrTSg8vtM18W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881388; c=relaxed/simple;
	bh=JDL4AMPQlFws+ThPojavz7DeZ/BR4RCZtAHXCQXyp7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRCfbYSfAPk6SCTM6EI1f4XNgFmtkPCYSBJVY63n4rJcIhONUhuhIgELQhPJM5tzr6fLCxSFfHrZ1yMIP7OfiEmJiCeL185zyhz4OMrJKSfNV7pwj3v2jNJ6kFbuwGJDRbNCZomxy4rDMjn93xsLnWu6/xS3z7YpIiX5aZ6XSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPHZ9s9r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPHZ9s9r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C065C4CEDD;
	Thu,  6 Feb 2025 22:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738881388;
	bh=JDL4AMPQlFws+ThPojavz7DeZ/BR4RCZtAHXCQXyp7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPHZ9s9rWdcnaViIXlcUDMeC1N8ABgL8Uu6PbpC/jspM/r/GVWX6PPtCguQOusYlO
	 A1PNeysbSocZWDAp/r7ESawG8ey2YUelRtFfkYRJLqNYG0dDTiUNv1Qfdte0xd0d/P
	 EjKN8pUazrVKSeAAjKKXsG5UCUTkvooQth6WcVPEGD0Vw06lN9/Zog2HOfKwMjQgMa
	 0PhShzDO5p71AsfSrUx5paIgIO9qI4pXPORoQKV5mRC+ZcHGNGdgdcyrhS+79KnBvH
	 l92Ih+T8mC4i2wrPaNJ/uajtV0SXXCARG5T+jl1O+/pwXMGZ2eo11LJbBSZl0dy6Ou
	 F18ZxVf5llQpw==
Date: Thu, 6 Feb 2025 14:36:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/7] fstests: enable sparse checking with make C=[12]
Message-ID: <20250206223627.GN21799@frogsfrogsfrogs>
References: <20250206212145.7732-1-sandeen@redhat.com>
 <20250206212145.7732-2-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206212145.7732-2-sandeen@redhat.com>

On Thu, Feb 06, 2025 at 03:19:56PM -0600, Eric Sandeen wrote:
> Enable "make C=1" sparse checking when files get rebuilt. To check
> all files, run "make clean" first.
> 
> Enable "make C=2" sparse checking of all files without rebuilding them.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks just like the one in xfsprogs and the kernel!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  Makefile           | 14 ++++++++++++++
>  include/buildrules | 19 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index f6f91a4d..79779d5e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -14,6 +14,20 @@ else
>    Q = @
>  endif
>  
> +CHECK=sparse
> +CHECK_OPTS=-Wsparse-all -Wbitwise -Wno-transparent-union -Wno-return-void -Wno-undef \
> +	-Wno-non-pointer-null -D__CHECK_ENDIAN__ -D__linux__
> +
> +ifeq ("$(origin C)", "command line")
> +  CHECK_CMD=$(CHECK) $(CHECK_OPTS)
> +  CHECKSRC=$(C)
> +else
> +  CHECK_CMD=@true
> +  CHECKSRC=0
> +endif
> +
> +export CHECK_CMD CHECKSRC
> +
>  MAKEOPTS = --no-print-directory Q=$(Q)
>  
>  TOPDIR = .
> diff --git a/include/buildrules b/include/buildrules
> index bf187662..6c2b7e18 100644
> --- a/include/buildrules
> +++ b/include/buildrules
> @@ -35,6 +35,21 @@ endif
>  # Standard targets
>  #
>  
> +ifeq ($(CHECKSRC),2)
> +
> +# Check every .c file with sparse CHECK_CMD, do not call compiler
> +$(LTCOMMAND) $(LTLIBRARY) : $(SUBDIRS) $(OBJECTS)
> +.PHONY: $(LTCOMMAND) $(LTLIBRARY)
> +
> +%.lo %.o : %.c FORCE
> +	@echo "    [CHECK]  $<"
> +	$(Q)$(CHECK_CMD) $(CFLAGS) $<
> +
> +FORCE:
> +
> +else
> +# Regular build, possibly calling sparse CHECK_CMD as well
> +
>  ifdef LTCOMMAND
>  $(LTCOMMAND) : $(SUBDIRS) $(OBJECTS) $(LTDEPENDENCIES)
>  	@echo "    [LD] $*"
> @@ -49,12 +64,16 @@ $(LTLIBRARY) : $(SUBDIRS) $(LTOBJECTS)
>  %.lo: %.c
>  	@echo "    [CC] $@"
>  	$(Q)$(LTCOMPILE) -c $<
> +	$(Q)$(CHECK_CMD) $(CFLAGS) $<
>  else
> +
>  %.o: %.c
>  	@echo "    [CC] $@"
>  	$(Q)$(CC) $(CFLAGS) -c $<
> +	$(Q)$(CHECK_CMD) $(CFLAGS) $<
>  
>  endif
> +endif
>  
>  ifdef POTHEAD
>  %.pot: $(XGETTEXTFILES)
> -- 
> 2.48.0
> 
> 
