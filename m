Received: from mx2.mpynet.fi ([82.197.21.85]:54517 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753570AbeASOmg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 19 Jan 2018 09:42:36 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Replace obsolete symbols and macros, fix build with musl libc.
From: Rostislav <rostislav@tuxera.com>
In-Reply-To: <20180118234234.GK16421@dastard>
Date: Fri, 19 Jan 2018 16:42:34 +0200
Content-Transfer-Encoding: 7bit
Message-ID: <B415BC70-4BDB-46EC-B36A-0249C6D5DC3A@tuxera.com>
References: <1516296058-8224-1-git-send-email-rostislav@tuxera.com> <20180118234234.GK16421@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> On Jan 19, 2018, at 1:42 AM, Dave Chinner <david@fromorbit.com> wrote:
> 
> On Thu, Jan 18, 2018 at 05:20:58PM +0000, Rostislav Skudnov wrote:
>> This commit replaces some obsolete and non-standard data types, headers,
>> macros and symbols with standard and modern ones in order to allow
>> building xfstests with musl C library.
>> 
>> Replace all __[u]intNN_t types with standard [u]intNN_t. This has been
>> done with the following command:
>> sed -r -i 's/__(u?int[0-9]{2}_t)/\1/g' src/*.c ltp/*.c
>> 
>> doio, growfiles: Use standard signal name SIGCHLD instead of SIGCLD.
>> 
>> fsstress: Include stddef.h for ptrdiff_t.
>> 
>> metaperf: Include linux/param.h for HZ macro.
>> 
>> dmiperf: Include sys/types.h for u_int32_t.
>> 
>> getdevicesize: Include stdint.h for uint64_t.
>> 
>> t_mtab: Replace sys_siglist[] with strsignal().
>> 
>> fssum: Use bswap_64() instead of __bswap_64().
>> 
>> pwrite_mmap_blocked: Include standard header signal.h instead of
>> sys/signal.h.
> 
> There's about 10 unrelated changes in this one patch. Can
> you split it up into one patch per unrelated change, with these
> one-line descriptions as the patch titles and the reason why the
> change is needed in th body of the commit description?
Thanks for your feedback. I will prepare a new patch series as you suggest.
> 
> Thanks!
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

