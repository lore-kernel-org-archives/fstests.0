Received: from mx1.redhat.com ([209.132.183.28]:50742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdCBQdr (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 2 Mar 2017 11:33:47 -0500
Date: Fri, 3 Mar 2017 00:32:01 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: _fiemap_filter awk brokeness causing test failures
Message-ID: <20170302163201.GO14226@eguan.usersys.redhat.com>
References: <30ba15cb-0503-5337-b447-f1228d431534@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ba15cb-0503-5337-b447-f1228d431534@suse.com>
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On Wed, Mar 01, 2017 at 06:48:04PM +0200, Nikolay Borisov wrote:
> Hello,
> 
> Running the script at http://paste.opensuse.org/6056e809 produces the
> following output:
> 
> root@ubuntu-virtual:~/xfstests-dev# ./test.sh /media/test/file1
> 0: [0..39]: hole
> 
> However, if I run the xfs_io -c "fiemap -v" command I get something
> different:
> 
> root@ubuntu-virtual:~/xfstests-dev# xfs_io -c "fiemap -v" /media/test/file1
> /media/test/file1:
>  EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>    0: [0..7]:          hole                 8
>    1: [8..23]:         192..207            16 0x801
>    2: [24..39]:        hole                16
> 
> 
> Finally, if I remove the invocation of _coalesce_extents in the script I
> get:
> root@ubuntu-virtual:~/xfstests-dev# ./test.sh /media/test/file1
> 0: [0..7]: hole
> 2: [24..39]: hole
> 
> 
> The script is a streamlined version of _test_generic_punc into a whole.
> However, due to the wrong output it's causing this particular test to
> fail and some other which deal with hole punching. The correct output
> should be :
> 
> 0: [0..7]: hole
> 1: [8..23]: unwritten
> 2: [24..39]: hole
> 
> My AWK version is the default coming with ubuntu 16.04:

I haven't looked into these two filters deeply, but a quick test showed
that mawk works fine for me too. But the mawk version is 1.3.4, and it's
from RHEL7 epel repo.

# mawk -W version
mawk 1.3.4 20131226
Copyright 2013, Thomas E. Dickey
Copyright 1996, Michael D. Brennan

internal regex
compiled limits:
max NF             32767
sprintf buffer      2040

Perhaps that's an mawk bug caused the test failure?

Thanks,
Eryu

> 
> awk -W version
> mawk 1.3.3 Nov 1996, Copyright (C) Michael D. Brennan
> 
> compiled limits:
> max NF             32767
> sprintf buffer      2040
> 
> However, if I install gawk the filter works as expected. Perhaps gawk
> should be made a hard requirement of xfstests?
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
