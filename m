Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:38803 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932394AbeARXmh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Jan 2018 18:42:37 -0500
Date: Fri, 19 Jan 2018 10:42:34 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] Replace obsolete symbols and macros, fix build with musl
 libc.
Message-ID: <20180118234234.GK16421@dastard>
References: <1516296058-8224-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516296058-8224-1-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 18, 2018 at 05:20:58PM +0000, Rostislav Skudnov wrote:
> This commit replaces some obsolete and non-standard data types, headers,
> macros and symbols with standard and modern ones in order to allow
> building xfstests with musl C library.
> 
> Replace all __[u]intNN_t types with standard [u]intNN_t. This has been
> done with the following command:
> sed -r -i 's/__(u?int[0-9]{2}_t)/\1/g' src/*.c ltp/*.c
> 
> doio, growfiles: Use standard signal name SIGCHLD instead of SIGCLD.
> 
> fsstress: Include stddef.h for ptrdiff_t.
> 
> metaperf: Include linux/param.h for HZ macro.
> 
> dmiperf: Include sys/types.h for u_int32_t.
> 
> getdevicesize: Include stdint.h for uint64_t.
> 
> t_mtab: Replace sys_siglist[] with strsignal().
> 
> fssum: Use bswap_64() instead of __bswap_64().
> 
> pwrite_mmap_blocked: Include standard header signal.h instead of
> sys/signal.h.

There's about 10 unrelated changes in this one patch. Can
you split it up into one patch per unrelated change, with these
one-line descriptions as the patch titles and the reason why the
change is needed in th body of the commit description?

Thanks!

-Dave.
-- 
Dave Chinner
david@fromorbit.com
