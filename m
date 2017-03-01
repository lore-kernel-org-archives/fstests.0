Received: from mx2.suse.de ([195.135.220.15]:58401 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbdCAQtn (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 1 Mar 2017 11:49:43 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05D40AD59
        for <fstests@vger.kernel.org>; Wed,  1 Mar 2017 16:48:06 +0000 (UTC)
From: Nikolay Borisov <nborisov@suse.com>
Subject: _fiemap_filter awk brokeness causing test failures
Message-ID: <30ba15cb-0503-5337-b447-f1228d431534@suse.com>
Date: Wed, 1 Mar 2017 18:48:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello,

Running the script at http://paste.opensuse.org/6056e809 produces the
following output:

root@ubuntu-virtual:~/xfstests-dev# ./test.sh /media/test/file1
0: [0..39]: hole

However, if I run the xfs_io -c "fiemap -v" command I get something
different:

root@ubuntu-virtual:~/xfstests-dev# xfs_io -c "fiemap -v" /media/test/file1
/media/test/file1:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..7]:          hole                 8
   1: [8..23]:         192..207            16 0x801
   2: [24..39]:        hole                16


Finally, if I remove the invocation of _coalesce_extents in the script I
get:
root@ubuntu-virtual:~/xfstests-dev# ./test.sh /media/test/file1
0: [0..7]: hole
2: [24..39]: hole


The script is a streamlined version of _test_generic_punc into a whole.
However, due to the wrong output it's causing this particular test to
fail and some other which deal with hole punching. The correct output
should be :

0: [0..7]: hole
1: [8..23]: unwritten
2: [24..39]: hole

My AWK version is the default coming with ubuntu 16.04:

awk -W version
mawk 1.3.3 Nov 1996, Copyright (C) Michael D. Brennan

compiled limits:
max NF             32767
sprintf buffer      2040

However, if I install gawk the filter works as expected. Perhaps gawk
should be made a hard requirement of xfstests?
