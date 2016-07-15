Received: from mx1.redhat.com ([209.132.183.28]:41173 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511AbcGOKGC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 Jul 2016 06:06:02 -0400
Date: Fri, 15 Jul 2016 18:05:59 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/4] xfstests: Fix installation for extended names
Message-ID: <20160715100559.GJ2432@eguan.usersys.redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
 <1468229169-24045-2-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1468229169-24045-2-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 11, 2016 at 11:26:06AM +0200, Jan Tulak wrote:
> xfstests supports extended test names like 314-foo-bar, but installation of
> these tests was skipped (not matching a regexp). So this patch fixes the
> makefiles in tests/*/
> 
> The include/buildrules change was written by Dave Chinner.
> 
> Signed-off-by: Jan Tulak <jtulak@redhat.com>
> ---
> UPDATE:
> Use Dave's code to at first select all files and then separate output and test
> files. BTW, in this version, when most of this version is written by Dave,
> should I add Signed-off-by, or is better to keep it mentioned only in the text?
> ---
>  include/buildrules     | 31 +++++++++++++++++++++++++++++++
>  tests/btrfs/Makefile   |  4 ++--
>  tests/cifs/Makefile    |  4 ++--
>  tests/ext4/Makefile    |  4 ++--
>  tests/f2fs/Makefile    |  4 ++--
>  tests/generic/Makefile |  4 ++--
>  tests/overlay/Makefile |  4 ++--
>  tests/shared/Makefile  |  4 ++--
>  tests/udf/Makefile     |  4 ++--
>  tests/xfs/Makefile     |  4 ++--
>  10 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/include/buildrules b/include/buildrules
> index c8a7c47..1269c8c 100644
> --- a/include/buildrules
> +++ b/include/buildrules
> @@ -100,3 +100,34 @@ MAKEDEP := $(MAKEDEPEND) $(CFLAGS)
>  	    cp /dev/null .dep; \
>  	fi
>  
> +# Gather files for installing into two lists:
> +# TESTS with executable scripts and OUTFILES with all the test outputs.
> +# Makefile has a very small matching, so we have to go this long way.
> +
> +# Start with all test related files:
> +ALLFILES = $(wildcard [0-9]??*)
> +
> +# Now build a list of known output files.  Unfortunately, the
> +# multiple output test files are poorly handled as makefiles don't
> +# handle wildcarded multi-suffix matching. Hence we separate the
> +# processing of these right now.
> +EXTENDED_OUTFILES = $(wildcard [0-9]??*.out.*)
> +BASIC_OUTFILES = $(wildcard [0-9]??*.out)

This turns out to be not sufficient, [0-9]??.cfg files are missed, so
tests like ext4/001 and generic/088 fail due to "no qualified output",
because _link_out_file() failed to work correctly without these *.cfg
files.

Adding another wildcard to match cfg files works for me. e.g.

EXTENDED_OUTFILE_CFGS = $(wildcard [0-9]??.cfg)

then update OUTFILES accordingly

> +OUTFILES = $(EXTENDED_OUTFILES) $(BASIC_OUTFILES)

OUTFILES = $(EXTENDED_OUTFILES) $(EXTENDED_OUTFILE_CFGS) $(BASIC_OUTFILES)

Can you please send an updated version of this patch?

Thanks,
Eryu
