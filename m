Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:16852 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbbJAX51 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 1 Oct 2015 19:57:27 -0400
Date: Fri, 2 Oct 2015 09:56:53 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: help on xfs test results
Message-ID: <20151001235653.GH3902@dastard>
References: <560C69D9.6020807@sysam.it>
 <560CF355.7050200@sysam.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560CF355.7050200@sysam.it>
Sender: fstests-owner@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 01, 2015 at 10:48:21AM +0200, Angelo Dureghello wrote:
> On 30/09/2015 01:28, Dave Chinner wrote:
> >On Wed, Sep 30, 2015 at 01:03:36AM +0200, Angelo Dureghello wrote:
> >>00:42:13.822058816 +0000
> >>     @@ -1 +1,2229 @@
> >>      QA output created by 256
> >>     +wrote 1073741824/1073741824 bytes at offset 0
> >>     +1 GiB, 262144 ops; 0:02:35.00 (6.602 MiB/sec and 1690.0353 ops/sec)
> >>     +pwrite64: No space left on device
> >>     +pwrite64: No space left on device
> >>     +pwrite64: No space left on device
> >>     +pwrite64: No space left on device
> >>     ...
> >
> >There should be ENOSPC being reported during the test but they
> >should all be redirected to /dev/null. Perhaps shomething wrong with
> >redirection?
> 
> Well, this is generic/256,
> the expected output is null,
> my output btw is full of failed and also non-failed operations.
> Sounds quite strange.

It uses "&> /dev/null" as the method of redirection. what happens if
you replace that with something like "> /dev/null 2>&1"?

....

> >>**** 136
> >>very long test, output similar but different values
> >
> >xfs/136 shouldn't run your machine out of memory. If it does, then
> >you probably should start looking for a memory leak...
> >
> 
> Sorry, was not precise in explaining this.
> This is xfs/136,
> Test is very long and full of differences compared to the expected
> .out. Strange thing is that the the messages are very similar, but
> values displayed are different.
> 
> xfs/136	 - output mismatch (see
> /home/angelo/xfstests/results//xfs/136.out.bad)
>      --- tests/xfs/136.out	2015-09-17 10:54:06.984088997 +0000
>      +++ /home/angelo/xfstests/results//xfs/136.out.bad	2015-09-20
> 

Ah, xfs/136 is not part of the "auto" group. That means it's
unreliable. Indeed, the original commit back in 2006:

commit 7dcf3ce6f95603965b51c53d0a48864b0c6e8268
Author: Tim Shimmin <tes@sgi.com>
Date:   Tue Oct 17 06:10:19 2006 +0000

    test out attr2 with different number of extents and number
    of EAs - with both sizes shrinking and enlarging and changing
    formats. Need to fix up the output before setting live.
    Merge of master-melb:xfs-cmds:27208a by kenmcd.

had output problems and it has never been fixed...

And, looking at:

commit 3e29b0b732f2386aa01e1b8d6dc3e57bfe6d3762
Author: Tim Shimmin <tes@sgi.com>
Date:   Fri Dec 1 14:46:42 2006 +0000

    Add some more tests for the attr2 test.
    Do some EA and extent interaction at different formats due to different
    number of extents and EAs.
    It showed up the current attr2 bug.
    With the proposed patch this doesn't happen.
    Merge of master-melb:xfs-cmds:27606a by kenmcd.

The diff has:

-- a/136.out
+++ b/136.out
@@ -22,7 +22,7 @@ core.size = 0
 core.extsize = 0
 core.nextents = 0
 core.naextents = 0
-core.forkoff = 47 (376 bytes)
+core.forkoff = 24 (192 bytes)
 core.aformat = 1 (local)
 a.sfattr.hdr.totsize = 18
 a.sfattr.hdr.count = 1
@@ -39,7 +39,7 @@ core.size = 0
 core.extsize = 0
 core.nextents = 0
 core.naextents = 0
-core.forkoff = 47 (376 bytes)
+core.forkoff = 24 (192 bytes)
 core.aformat = 1 (local)
 a.sfattr.hdr.totsize = 32
 a.sfattr.hdr.count = 2
@@ -62,7 +62,7 @@ core.size = 0
 core.extsize = 0
 core.nextents = 0
 core.naextents = 0
-core.forkoff = 44 (352 bytes)
+core.forkoff = 24 (192 bytes)
 core.aformat = 1 (local)
 a.sfattr.hdr.totsize = 60
 a.sfattr.hdr.count = 4
@@ -97,7 +97,7 @@ core.size = 0
 core.extsize = 0
 core.nextents = 0
 core.naextents = 0
-core.forkoff = 37 (296 bytes)
+core.forkoff = 24 (192 bytes)
 core.aformat = 1 (local)
 a.sfattr.hdr.totsize = 116
 a.sfattr.hdr.count = 8

Which looks very much like the diff you are seeing, and I think the
bug referred to by the commit message was fixed by this commit:

http://oss.sgi.com/cgi-bin/gitweb.cgi?p=archive/xfs-import.git;a=commitdiff;h=94aa0de19b6654848be060d4bcae2e9147733d41

which implies the attribute fork is being created with the wrong
size. Hmmm.

Are you testing with something like selinux or some other security
subsystem enabled that creates attributes at inode creation time?

Also, can you run this:

$ pahole fs/xfs/libxfs/xfs_attr.o

And grab the output of these structure definitions:

(from x86-64, using gcc 4.9.3):

struct xfs_attr_sf_hdr {
        __be16                     totsize;              /*     0     2 */
        __u8                       count;                /*     2     1 */

        /* size: 4, cachelines: 1, members: 2 */
        /* padding: 1 */
        /* last cacheline: 4 bytes */
};
struct xfs_attr_sf_entry {
        __uint8_t                  namelen;              /*     0     1 */
        __uint8_t                  valuelen;             /*     1     1 */
        __uint8_t                  flags;                /*     2     1 */
        __uint8_t                  nameval[1];           /*     3     1 */

        /* size: 4, cachelines: 1, members: 4 */
        /* last cacheline: 4 bytes */
};
struct xfs_attr_shortform {
        struct xfs_attr_sf_hdr     hdr;                  /*     0     4 */

        /* XXX last struct has 1 byte of padding */

        struct xfs_attr_sf_entry   list[1];              /*     4     4 */

        /* size: 8, cachelines: 1, members: 2 */
        /* paddings: 1, sum paddings: 1 */
        /* last cacheline: 8 bytes */
};


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
